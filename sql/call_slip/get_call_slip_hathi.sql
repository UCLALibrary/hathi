-- Query to get space-delimited data needed by vger_handle_hathi_call_slips
set trimout on;

with d as (
  select
    cs.call_slip_id 
  , trim(pa.address_line1) as email
  , case 
      when h.access_lvl = 'deny'
      then 'https://catalog.hathitrust.org/Record/' || h.hathi_bib_key || '?signon=swle:urn:mace:incommon:ucla.edu'
      else 'https://catalog.hathitrust.org/Record/' || h.hathi_bib_key
  end as hathi_url
  from vger_support.call_slip_hathi cs
  -- Email address is required
  inner join ucladb.patron_address pa on cs.patron_id = pa.patron_id and pa.address_type = 3 -- email
  inner join vger_report.hathi_overlap h on cs.bib_id = h.bib_id
  where cs.date_responded is null
)
select
  call_slip_id || ' ' || email || ' ' || hathi_url
from d
order by call_slip_id
;
