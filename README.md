# Toolbox
Things I find useful in alphabetical order.

## Ansible

 * [Cheatsheet](https://devhints.io/ansible-guide)
 * [Cheatsheet](./ansible/Ansible-Cheat_Sheet_Edureka.png)
 * [Tips](https://blog.ippon.tech/ansible-tips-and-tricks/)

## Apache

 * [Apache2buddy](https://github.com/richardforth/apache2buddy#new-method) - diagnostic tool.

## APM

 * [Prometheus](https://prometheus.io/)
 * [Glowroot](https://glowroot.org/)
 * [Pinpoint](https://naver.github.io/pinpoint/#introduction)

## Bash

 * Recursive grep showing hits. 
   ```bash 
   grep -rnwc . -e 'OutOfMemoryError' | awk -F: '$NF+0 > 0'
   ```
 * Scan jars for specific files and return count.  
   ```bash 
   ls -1 *.jar | xargs -l1 -I {} unzip -l {} | grep -e 'spring-rabbit-1.7.12.RELEASE.jar' -i -c
   ```
 * Delete files recursively
   ```bash 
   find . -type f -name '*.o' -delete  
   ``` 
   
 * Column and sort
   ```bash
   cat XXXX.txt | grep 'XXXX' | column -t | grep -v 'XXXX' | sort -k 6nr
   ```   
   
 * [One liners](http://www.bashoneliners.com/oneliners/popular/)
 * [More one liners](https://github.com/stephenturner/oneliners)
 
        
## Cloud Foundry

 * [Cheatsheet](https://blog.anynines.com/wp-content/uploads/2016/05/a9s-CF-Cheat-Sheet.pdf) 
 
## Continuous integration

 * [Drone](https://drone.io/)
 * [Jenkins](https://jenkins.io/)
 * [Sonarqube](https://www.sonarqube.org/)
 * [Gerrit](https://www.gerritcodereview.com/)
 * [Artifactory](https://jfrog.com/artifactory/)

## Docker

 * [Cheatsheet](https://github.com/wsargent/docker-cheat-sheet#tips)
 
 * Centos install
   ```bash
   sudo curl -SsL https://download.docker.com/linux/centos/docker-ce.repo -o /etc/yum.repos.d/docker-ce.repo ; sudo yum install docker-ce -y ; sudo service docker start
   ```
 
 * Frequently run commands...
   ```bash 
   docker stats $(sudo docker ps | awk '{if(NR>1) print $NF}')
   
   docker exec -it XXXXX bash
   
   docker cp -a CONTAINER:SRC_PATH DEST_PATH|-
   docker cp -a SRC_PATH|- CONTAINER:DEST_PATH
   
   docker run \
   -d --name fraud_workspace_1 \
   --hostname workspace \
   -v /data/workspace:/data \
   --dns 127.0.0.1 \
   --dns XXXX \
   --restart always \
   --link fraud_consul_1:consul \
   -p 20130:20130 \
   -p 20131:20131 \
   -e CONSUL_PORT_8500_TCP_ADDR=consul \
   -e CONSUL_PORT_8500_TCP_PORT=8500 \
   -e DISABLE_CONSUL_AGENT=true \
   XXXX/fraud/svi-visual-investigator:6.3.9-SNAPSHOT
   ```
 
## Git

 * [Cheatsheet](https://education.github.com/git-cheat-sheet-education.pdf) 
 
 * Prettier git output.
   ```bash
   alias gog="git log  --abbrev-commit --name-status --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset'"
   alias gml="git log --stat --color --decorate --all --oneline"
   alias gdw="git diff --word-diff=color"
   alias ccat="source-highlight --out-format=esc256 -o STDOUT -i"
   ```
   
## Helm

 * [Cheatsheet](https://github.com/RehanSaeed/Helm-Cheat-Sheet) 
 * [Charts](https://hub.helm.sh/)

## Intellij

 * [Key map](https://resources.jetbrains.com/storage/products/intellij-idea/docs/IntelliJIDEA_ReferenceCard.pdf) 

 * Remote debug to cloud foundry spring boot app instances.
   ```bash  
   cf set-env XXXX JAVA_OPTS '-agentlib:jdwp=transport=dt_socket,server=n,address=XXXX:700${CF_INSTANCE_INDEX},suspend=n'
   ```

## Istio

 * [Cheatsheet](https://istio.io/docs/reference/commands/istioctl/)

## JQ

 * [Json processor](https://stedolan.github.io/jq/)
 
## K8s

 * [Cheatsheet](https://kubernetes.io/docs/reference/kubectl/cheatsheet/)
 * [Cheatsheet](./k8s/Kubectl_Commands_Cheat_Sheet.pdf)
 * [RKE](https://github.com/rancher/rke#rke) - easy cluster deployment.
 
## Machine learning

 * [SAS](https://blogs.sas.com/content/subconsciousmusings/2017/04/12/machine-learning-algorithm-use/)
 * [Go](https://github.com/avelino/awesome-go#machine-learning) 

## Markdown

 * [Cheatsheet](https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet)
 
## Performance

 * [JMeter](https://jmeter.apache.org/)
 * [Gatling](https://gatling.io/) 

 * Inject latency to align with the target environment's measured network.
   ```bash
   [root@XXXX default]# ping -qc1 XXXX 2>&1 | awk -F'/' 'END{ print (/^rtt/? "OK "$5" ms":"FAIL") }'
   OK 1.268 ms
   [root@XXXX default]# tc qdisc add dev eth0 root netem delay 10ms
   [root@XXXX default]# ping -qc1 XXXX 2>&1 | awk -F'/' 'END{ print (/^rtt/? "OK "$5" ms":"FAIL") }'
   OK 11.634 ms
   [root@XXXX default]# tc qdisc del dev eth0 root netem
   [root@XXXX default]# ping -qc1 XXXX 2>&1 | awk -F'/' 'END{ print (/^rtt/? "OK "$5" ms":"FAIL") }'
   OK 1.341 ms
   ```bash 
   
 * [Diagnostic commands](https://medium.com/netflix-techblog/linux-performance-analysis-in-60-000-milliseconds-accc10403c55)
 * [Monitoring tools](https://blog.serverdensity.com/80-linux-monitoring-tools-know/) 
   
## Postgres
   
 * [Index hit rate metrics](./postgres/index_hit_rates.sql) 

 * [Row counts](./postgres/row_counts.sql)
   
 * [Statement metrics](./postgres/statements.sql)
      
 * [Pg_stat_statements](https://www.postgresql.org/docs/9.4/pgstatstatements.html) - sql query metrics
   ```text
     
   CREATE EXTENSION pg_stat_statements;
   SELECT *  FROM pg_available_extensions WHERE name = 'pg_stat_statements' and installed_version is not null;
   
   # postgresql.conf
   shared_preload_libraries = 'pg_stat_statements'
   pg_stat_statements.max = 10000
   pg_stat_statements.track = all
     
   restart
   ```
     
 * [postgresqltuner.pl](https://github.com/jfcoz/postgresqltuner) 
   
 * [Detect slow queries](https://www.cybertec-postgresql.com/en/3-ways-to-detect-slow-queries-in-postgresql/) 

 * [SSD random_page_cost=seq_page_cost](https://speakerdeck.com/ongres/postgresql-configuration-for-humans?slide=28)

 * [sysctl -w vm.overcommit_memory=2](https://www.postgresql.org/docs/current/kernel-resources.html#LINUX-MEMORY-OVERCOMMIT)

## SAS
 
 * [SVI](https://www.sas.com/en_us/software/intelligence-analytics-visual-investigator.html)
 * [IIM](https://www.sas.com/en_us/software/intelligence-investigation-management.html)
 
 * [Cheatsheet](http://www.theprogrammerscabin.com/SASCheat.pdf)
 
 * Logs
   ```bash
   ## tail the latest app log...
   cd /var/log/sas/viya/svi-datahub/default
   ls -1t | head -n1 | xargs tail -f
   ```       
 * Sas-bootstrap-config
   ```bash
   ## Get consul token
   sudo cat /opt/sas/viya/config/etc/SASSecurityCertificateFramework/tokens/consul/default/management.token
   
   ## Get sanitized KV recursively
   source /opt/sas/viya/config/consul.conf; /opt/sas/viya/home/bin/sas-bootstrap-config --token-file /opt/sas/viya/config/etc/SASSecurityCertificateFramework/tokens/consul/default/client.token kv read --recurse config/ | grep -Evi 'username|password|host|secret|jdbc'
   
   ## Examples for write and delete.  the 'source' part is duplicated for cut and paste reasons
   [root@XXXX ~]# source /opt/sas/viya/config/consul.conf; /opt/sas/viya/home/bin/sas-bootstrap-config --token-file /opt/sas/viya/config/etc/SASSecurityCertificateFramework/tokens/consul/default/client.token kv write --force -- "config/${applicationArray[$i]}/jvm/java_option_glowroot_$j" "${propertyArray[$j]}"
   [root@XXXX ~]# source /opt/sas/viya/config/consul.conf; /opt/sas/viya/home/bin/sas-bootstrap-config --token-file /opt/sas/viya/config/etc/SASSecurityCertificateFramework/tokens/consul/default/client.token kv delete -- "config/${applicationArray[$i]}/jvm/java_option_glowroot_$j"
   ```
 
 * [SVI diagnostic](./sas/diagnostic.md)
 
## VI

 * [Cheatsheet](https://www.splunk.com/content/dam/splunk-blogs/images/2012/08/VIM-cheatsheet1.png)