LOAD DATA
TRUNCATE
INTO TABLE vger_report.tmp_hathi_overlap
FIELDS TERMINATED BY x'09'
TRAILING NULLCOLS
( oclc_number
, bib_id
, item_type
, access_lvl
, rights_code
)
