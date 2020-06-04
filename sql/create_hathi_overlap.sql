create table vger_report.hathi_overlap (
  oclc_number varchar2(15) not null
, bib_id int not null
, item_type varchar2(6) not null
, access_lvl varchar2(5)
, rights_code varchar2(20)
)
;

create index vger_report.ix_hathi_overlap on vger_report.hathi_overlap (bib_id);

grant select on vger_report.hathi_overlap to ucla_preaddb;
