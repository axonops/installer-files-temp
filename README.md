# installer-files-temp

Follow the instructions below to setup a test environment for self-hosted AxonOps service. The instructions below is intended for a quick and simple installation, with no encryption / authentication.

## Requirements
### AxonOps Server
* Linux RedHat / CentOS compatible OS
* 4 CPU Cores
* 16GB memory
* 30GB storage for elasticsearch

## Download and Unpack
Steps to install AxonOps
1. Download `axon-agent-1.0.64-1.x86_64.rpm`, `axon-server-1.0.131-1.x86_64.rpm`, `axon-dash.tar` in this project click on the file in the github UI, then click on `Download raw file` button.


## Install AxonOps service
### Install ElasticSearch
1. Follow the instructions in the following link - https://www.elastic.co/guide/en/elasticsearch/reference/7.17/install-elasticsearch.html
2. Start ElasticSearch

### Install Cassandra
1. Install Cassandra version 4.1 for the AxonOps metrics storage. See https://docs.axonops.com/installation/axon-server/metricsdatabase/
2. Start Cassandra
3. Apply the schema in https://github.com/axonops/installer-files-temp/blob/main/metrics.cql. Make sure to update the replication factor in its keyspace.

### Install and start axon-server
1. Copy `axon-dash.tar` and `axon-server-1.0.131-1.x86_64.rpm` to a server where you will be hosting the AxonOps service.
2. Install axon-server on a RedHat-based Linux OS using the command `sudo rpm -Uvh axon-server-1.0.131-1.x86_64.rpm`.
3. Apend the content of https://github.com/axonops/installer-files-temp/blob/main/axon-server-cql-additional-parameters.yml to your /etc/axonops/axon-server.yml file. Update the templated values in this file.
4. Start axon-server `systemctl start axon-server`

### Install and start axon-dash
1. Install Docker - `sudo yum install docker`
2. Import axon-dash docker image `docker load -i axon-dash.tar`
3. Start axon-dash `docker run -d --network host europe-docker.pkg.dev/axonops-public/axonops-docker/axon-dash:1.0.79`

## Install Cassandra agent
1. Copy `axon-agent-1.0.64-1.x86_64.rpm` and `axon-cassandra<cassandra_version>-agent-1.0.6-1.noarch.rpm` to your Cassandra nodes
2. Install 2 packages using the commands `sudo rpm -Uvh axon-agent-1.0.64-1.x86_64.rpm`
3. Configure axon-agent - edit `sudo vi /etc/axonops/axon-agent.yml` and replace with the following
```
axon-server:
    hosts: "<ip_address_of_axon_server>"
    port: 1888
axon-agent:
    org: <your_org_name>
    tls:
      mode: "disabled" # disabled, TLS, mTLS
    java_agent_listen_address: 127.0.0.1:17004
dse:
    tier0: # metrics collected every 5 seconds
        metrics:
            jvm_:
              - "java.lang:*"
            cas_:
              - "org.apache.cassandra.metrics:*"
              - "org.apache.cassandra.net:type=FailureDetector"
              - "com.datastax.bdp:type=metrics,*"
```
4. Set file permissions on `/etc/axonops/axon-agent.yml` file by executing the following command
```sudo chmod 0644 /etc/axonops/axon-agent.yml```
5. Copy the file named `axon-dse5.1-agent.jar` from this repository to DSE server in `/usr/share/axonops/` directory.
6. Edit `cassandra-env.sh`, usually located in your Cassandra install path such as `/<Cassandra Installation Directory>/conf/cassandra-env.sh`, and append the following line at the end of the file:
```
JVM_OPTS="$JVM_OPTS -javaagent:/usr/share/axonops/axon-dse5.1-agent.jar=/etc/axonops/axon-agent.yml"
JVM_OPTS="$JVM_OPTS -Djna.tmpdir=/home/cassandraappid<env>/tmp -Djava.io.tmpdir=/home/cassandraappid<env>/tmp -Dio.netty.native.workdir=/home/cassandraappid<env>/tmp"
```
7. Add AxonOps user to Cassandra user group and Cassandra user to AxonOps group
   1. Add `cassandraappid<env>` user to `axonops` group in `/etc/group`
    ```
    axonops:x:<gid>:axonops,cassandraappid<env>
    ```
   2. Add `axonops` user to `ux_cassandra<env>adm` group in `etc/group`
    ```
    ux_cassandra<env>adm:x:<gid>:cassandraappid<env>,axonops
    ```
8. (Re)start Cassandra / DSE
9. Start axon-agent - `sudo systemctl start axon-agent`

## Accessing AxonOps UI
Using your browser go to `http://<ip_address_of_axonops_server>:3000`
