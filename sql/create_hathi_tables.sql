-- Permanent table used by web services
create table vger_report.hathi_overlap (
  oclc_number varchar2(15) not null
, bib_id int not null
, hathi_bib_key varchar2(10) not null
, item_type varchar2(6) not null
, access_lvl varchar2(5)
, rights_code varchar2(20)
)
;
create index vger_report.ix_hathi_overlap on vger_report.hathi_overlap (bib_id, hathi_bib_key);
grant select on vger_report.hathi_overlap to ucla_preaddb;

-- Temporary tables for imports/updates
create table vger_report.tmp_hathi_import (
  oclc_number varchar2(15)
, hathi_bib_key varchar2(10) not null
)
;
create index vger_report.ix_tmp_hathi_import on vger_report.tmp_hathi_import (oclc_number);

create table vger_report.tmp_hathi_overlap (
  oclc_number varchar2(15) not null
, bib_id int not null
, item_type varchar2(6) not null
, access_lvl varchar2(5)
, rights_code varchar2(20)
)
;
create index vger_report.ix_tmp_hathi_overlap on vger_report.tmp_hathi_overlap (oclc_number);
  
