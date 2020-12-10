-- Must run as ucladb.
-- Copy data from request table to our local table
insert into vger_support.call_slip_hathi
select cs.*, null as date_reponded
from ucladb.call_slip cs
inner join ucladb.bib_mfhd bm on cs.bib_id = bm.bib_id and cs.mfhd_id = bm.mfhd_id
inner join ucladb.mfhd_master mm on bm.mfhd_id = mm.mfhd_id
where exists (
  select *
  from vger_report.hathi_overlap
  where bib_id = cs.bib_id
)
and mm.record_type = 'x' -- single-volume monograph
and cs.status = 1 -- Accepted, nothing processed
;

-- Remove original requests which have been transferred
delete from ucladb.call_slip cs
where exists (
  select *
  from vger_support.call_slip_hathi
  where call_slip_id = cs.call_slip_id
  and date_responded is null
)
;

-- Also remove the "Call Slip Request" item status for these items
delete from ucladb.item_status
where item_status = 23
and item_id in (
  select distinct item_id
  from vger_support.call_slip_hathi
  where date_responded is null
)
;

commit;
