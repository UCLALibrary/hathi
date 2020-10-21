-- Must run as vger_support.
-- Table for relevant call slip requests (copy empty structure to start)
create table vger_support.call_slip_hathi as
select * from ucladb.call_slip where 1=0
;

-- Add column with date/time response was sent (null if not yet processed)
alter table vger_support.call_slip_hathi
add (date_responded date null)
;

-- Indexes
create index vger_support.ix_call_slip_hathi on vger_support.call_slip_hathi (date_responded, bib_id);
create index vger_support.ix_call_slip_hathi_pt on vger_support.call_slip_hathi (patron_id);
create index vger_support.ix_call_slip_hathi_id on vger_support.call_slip_hathi (call_slip_id);

-- Access
grant select on vger_support.call_slip_hathi to ucla_preaddb;

