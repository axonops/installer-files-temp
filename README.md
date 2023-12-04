# installer-files-temp

Follow the instructions below to setup a test environment for self-hosted AxonOps service. The instructions below is intended for a quick and simple installation, with no encryption / authentication.

## Requirements
### AxonOps Server
* Linux RedHat / CentOS compatible OS
* 4 CPU Cores
* 16GB memory
* 

## Download and Unpack
Steps to install AxonOps
1. Download axonops-installer-files.tar.gz file in this project click on the file in the github UI, then click on `Download raw file` button.
2. Unpack the file using the command `tar xzf axonops-installer-files.tar.gz`.
3. You will see a directory named `axonops-files` with a number of files inside.

## Install AxonOps service
### Install ElasticSearch
1. Follow the instructions in the following link - https://www.elastic.co/guide/en/elasticsearch/reference/7.17/install-elasticsearch.html
2. Start ElasticSearch

### Install and start axon-server
1. Copy `axon-dash-1.0.76.docker` and `axon-server-1.0.127-1.x86_64.rpm` to a server where you will be hosting the AxonOps service.
2. Install axon-server on a RedHat-based Linux OS using the command `sudo rpm -Uvh axon-server-1.0.127-1.x86_64.rpm`.
3. Start axon-server `systemctl start axon-server`

### Install and start axon-dash
1. Install Docker - `sudo yum install docker`
2. Import axon-dash docker image `docker load axon-dash-1.0.76.docker`
3. Start axon-dash `docker run -d --network host europe-docker.pkg.dev/axonops-public/axonops-docker/axon-dash`

## Install Cassandra agent
1. Copy `axon-agent-1.0.61-1.x86_64.rpm` and `axon-cassandra<cassandra_version>-agent-1.0.6-1.noarch.rpm` to your Cassandra nodes
2. Install 2 packages using the commands `sudo rpm -Uvh axon-agent-1.0.61-1.x86_64.rpm`
3. Configure axon-agent - edit `sudo vi /etc/axonops/axon-agent.yml` and replace with the following
```
axon-server:
    hosts: "<ip_address_of_axon_server>:1888"
axon-agent:
    org: <your_org_name>
    tls:
      mode: "disabled" # disabled, TLS, mTLS
```
4. Set file permissions on `/etc/axonops/axon-agent.yml` file by executing the following command
```sudo chmod 0644 /etc/axonops/axon-agent.yml```
5. Edit `cassandra-env.sh`, usually located in your Cassandra install path such as `/<Cassandra Installation Directory>/conf/cassandra-env.sh`, and append the following line at the end of the file:
```
JVM_OPTS="$JVM_OPTS -javaagent:/usr/share/axonops/axon-cassandra3.11-agent.jar=/etc/axonops/axon-agent.yml"
```
6. Add AxonOps user to Cassandra user group and Cassandra user to AxonOps group
```
sudo usermod -aG <your_cassandra_group> axonops
sudo usermod -aG axonops <your_cassandra_user>
```
7. (Re)start Cassandra
8. Start axon-agent - `sudo systemctl start axon-agent`

## Accessing AxonOps UI
Using your browser go to `http://<ip_address_of_axonops_server>:3000`
