 
select *, (total_time/calls) as avg_time from pg_stat_statements 
where 
  lower(query)     like all (array['%%', '% where %'])  and
  lower(query) not like '%from pg%' and
  lower(query) not like '%explain%'
  
order by avg_time desc ;
