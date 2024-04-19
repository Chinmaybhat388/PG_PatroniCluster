# PG_PatroniCluster

This project is to deploy a 3 node Postgresql Patroni cluster using ETCD as the Distributed Configuration Store using Ansible. 


Install_pgsql.yaml    : Installs desired version of postgresql database. 
install_etcd.yaml     : Installs and configures etcd as a systemd unit. 
etcd.service.j2       : Jinja2 template for etcd configuration.
patroni_install2.yaml : Installs patroni.
patroni.yml.j2        : Jinja2 template for patroni configuration. 
inventory_patroni     : The inventory file. 
pg_monitor.sh         : A simple script to monitor the environment and send a mail in case of failures. 
