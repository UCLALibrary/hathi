truncate table vger_report.hathi_overlap;
insert into vger_report.hathi_overlap (oclc_number, bib_id, hathi_bib_key, item_type, access_lvl, rights_code)
select
  o.oclc_number
  , o.bib_id
  , i.hathi_bib_key
  , o.item_type
  , o.access_lvl
  , o.rights_code
  from vger_report.tmp_hathi_overlap o
  inner join vger_report.tmp_hathi_import i on o.oclc_number = i.oclc_number
  ;
  commit;
