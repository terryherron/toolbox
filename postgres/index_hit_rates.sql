create or replace function 
count_rows(schema text, tablename text) returns integer
as
$body$
declare
  result integer;
  query varchar;
begin
  query := 'SELECT count(1) FROM "' || schema || '"."' || tablename || '"';
  execute query into result;
  return result;
end;
$body$
language plpgsql;

select * from (
  select p.schemaname, p.relname, count_rows(p.schemaname,p.relname),
    ROUND( 
      CASE WHEN (p.seq_scan + p.idx_scan) != 0
        THEN 100.0 * p.idx_scan / (p.seq_scan + p.idx_scan) 
        ELSE 0
      END
    ,5) AS percent_of_times_index_used,
    p.seq_scan, p.seq_tup_read, p.idx_scan, p.idx_tup_fetch, p.n_tup_ins, p.n_tup_upd, p.n_tup_del
  from pg_stat_all_tables p 
  where 
     (p.seq_tup_read + p.idx_tup_fetch) > 0 and
     p.schemaname not like any (array['pg_%']) and
     p.relname not like any (array['schema version'])  
) as q1
where 
  percent_of_times_index_used < 95 and
  count_rows >= 0 
--order by count_rows desc;
order by seq_scan desc;
