#!/bin/bash
# bash for arrays

# Get latest HATHI_FILE from https://www.hathitrust.org/hathifiles
# Get latest OVERLAP_FILE from https://ucla.app.box.com/folder/114339001662 (login required)

# Command-line file handling
if [ -f "$1" -a -f "$2" ]; then
  HATHI_FILE="$1"
  OVERLAP_FILE="$2"
else
  echo Usage: $0 hathi_file.gz overlap_file.tsv
  exit 1
fi

SCHEMA=vger_report

# Extract OCLC# and Hathi title-level id from the gzipped hathi file.
# Sort on OCLC# and de-dup.
# Output is in a tab-delimited temporary file, with more processing needed.
TMPFILE_RAW=/tmp/tmp_hathi_raw.txt
echo "Generating ${TMPFILE_RAW}..."
# Sorting with -n -u seems to lose some unique data... no more numeric sorting.
###gunzip -dc ${HATHI_FILE} | awk -F'\t' '{print $8"\t"$4}' | sort -n -u > ${TMPFILE_RAW}
gunzip -dc ${HATHI_FILE} | awk -F'\t' '{print $8"\t"$4}' | sort -u > ${TMPFILE_RAW}
wc -l ${TMPFILE_RAW}

# Many records have multiple OCLC# in one comma-delimited field.
# Split those, creating one row for each OCLC#.
TMPFILE_PROCESSED=/tmp/tmp_hathi_processed.txt
if [ -f ${TMPFILE_PROCESSED} ]; then rm ${TMPFILE_PROCESSED}; fi

echo "Generating ${TMPFILE_PROCESSED}..."
grep ',' ${TMPFILE_RAW} | while read LINE; do
  OCLCS=`echo $LINE | cut -d' ' -f1`
  HATHI=`echo $LINE | cut -d' ' -f2`
  echo "${OCLCS}" | while IFS=',' read -ra ARR; do
    for OCLC in "${ARR[@]}"; do
	  echo -e "${OCLC}\t${HATHI}" >> ${TMPFILE_PROCESSED}
	done
  done
done
wc -l ${TMPFILE_PROCESSED}

# Most records have just one OCLC#, which don't need more processing
grep -v ',' ${TMPFILE_RAW} >> ${TMPFILE_PROCESSED}
wc -l ${TMPFILE_PROCESSED}

# Sort the final Hathi data
echo "Generating ${TMPFILE_FINAL}..."
HATHI_FINAL=/tmp/tmp_hathi_final.txt
sort -n ${TMPFILE_PROCESSED} > ${HATHI_FINAL}
wc -l ${HATHI_FINAL}

# Now look at the overlap file.
# Remove the header and sort by OCLC#, in the first column
OVERLAP_FINAL=/tmp/tmp_overlap_final.txt
echo "Generating ${OVERLAP_FINAL}..."
grep -v item_type ${OVERLAP_FILE} | sort -n > ${OVERLAP_FINAL}

# /tmp/tmp_hathi_final.txt has oclc# and hathi bib key
# This is the full data, processed/sorted/de-duped
# Load this into vger_report.tmp_hathi_import
${VGER_SCRIPT}/vger_sqlldr_load ${SCHEMA} ${HATHI_FINAL} sql/tmp_hathi_import.ctl

# /tmp/tmp_overlap_final.txt has oclc# and other data from the overlap report
# Load this into vger_report.tmp_hathi_import
${VGER_SCRIPT}/vger_sqlldr_load ${SCHEMA} ${OVERLAP_FINAL} sql/tmp_hathi_overlap.ctl

# Remove old data and populate main table with new data - takes about 30 seconds
${VGER_SCRIPT}/vger_sqlplus_run ${SCHEMA} sql/refresh_hathi_overlap.sql

# Clean up
rm ${TMPFILE_RAW} ${TMPFILE_PROCESSED} ${HATHI_FINAL} ${OVERLAP_FINAL}

