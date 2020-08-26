LOAD DATA
TRUNCATE
INTO TABLE vger_report.tmp_hathi_import
FIELDS TERMINATED BY x'09'
TRAILING NULLCOLS
( oclc_number
, hathi_bib_key
)
