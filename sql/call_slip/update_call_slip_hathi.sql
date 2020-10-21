-- Mark the current request (identified by the calling script) as sent.
update vger_support.call_slip_hathi
set date_responded = sysdate
where call_slip_id = &1
;
commit;
