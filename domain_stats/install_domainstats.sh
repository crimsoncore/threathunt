docker run --name domainstats -d -p 20000:20000 -v /opt/threathunt/domain_stats/top-1m.csv:/opt/domain_stats/top-1m.csv securityonionsolutions/so-domainstats:latest 

