
# SVI Diagnostic

#### Consul KV Review

1. Grep the properties of interest.
   ```bash
   [root@XXXX]# source /opt/sas/viya/config/consul.conf; /opt/sas/viya/home/bin/sas-bootstrap-config --token-file /opt/sas/viya/config/etc/SASSecurityCertificateFramework/tokens/consul/default/client.token kv read --recurse config/ | grep -Evi 'username|password|host|secret|jdbc' | grep -Ei 'maxActive|maxIdle|max_connections|max_prepared_transactions|num_init_children|cacheserver/jvm/java_option_xm|spring.datasource|sas/url|sas.url'
   ```
   
2. Confirm cacheserver min and max heap size are set to the same value at least 2g or greater.

3. Confirm spring.datasource max min active and idle are 100 and 0.

4. Confirm the 3 postgres and pgpool connection values are appropriate.

5. Confirm the ldap max min active and idle are 30 and 30 per the viya tuning guide.
   
6. Confirm if the sas url values are pointing to an F5 or load balancer that the latencies are sub millisecond.  Meaning no network packet scanning.

#### Viya Tuning Guide Review

1. If possible run apache2buddy.pl diagnostic on all httpd nodes.
   * [apache2buddy](https://github.com/richardforth/apache2buddy#new-method)

2. Confirm worker module and updated settings.

3. Confirm dns lookup is disabled which is part of the apache2buddy tool diagnostic.

4. Confirm LDAP pool size of 30.

5. Confirm tcp settings increases. 

#### Postgres Tuning

1. If possible run postgresqltuner.pl diagnostic on all postgres nodes.
   * [postgresqltuner](https://github.com/jfcoz/postgresqltuner#postgresqltunerpl)

2. Confirm SSD drives and the "random_page_cost" is 1 so that random_page_cost / seq_page_cost=1 instead of the 4 to 1 
   ratio that is tuned for spinning disks.
   
3. Redo and review index hit rate metrics and row counts after the performance tests have run.
   * [index_hit_rates](../postgres/index_hit_rates.sql)
   * [row_counts](../postgres/row_counts.sql)
   
#### Network Review

1. Confirm the Radware load balancer is not packet scanning internal SAS micro-service traffic.  This was disabled 
   in prior environments and it needs to continue that way.
   
2. The latencies from a micro-service to another micro-service node, apache node, and SharedServices database were all 
   sub millisecond.  Except for the ping to the Radware load balancer was 6 milliseconds on average (10 to 20 times worse than pinging another node).  Is there any way to improve 
   that latency.  Again ensure pack scanning of VI traffic is disabled.
   
#### ETL Review

1. See if there is an opportunity to encode data en route so it lands properly formatted in VI.

#### SQL index Review

1. Consider if any of the open jiras would benifit the customer.  Verify with the index hit rate reports and table scan counts.

#### Data Model Review

1. Determine duplicated searchable fields in parent and child documents.  With so many child documents (hundreds) on some
   entities, removing the duplicates would make searches faster and keep index size down with no negative effect on search 
   results.             
  
2. Consider model alernatives for poorly performing entities.

#### Patch jars

1. Update any slowly starting services.

#### Elasticsearch review

1. Verify settings, but confirm with sand team before making changes.
   * [Search speed](https://www.elastic.co/guide/en/elasticsearch/reference/master/tune-for-indexing-speed.html)


    

  
