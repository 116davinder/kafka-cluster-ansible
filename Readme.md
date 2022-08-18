# Apache Kafka Ansible
It is a group of playbooks to manage apache kafka.

![GitHub release (latest SemVer)](https://img.shields.io/github/v/release/116davinder/kafka-cluster-ansible?include_prereleases&style=for-the-badge)
[![Codacy Badge](https://app.codacy.com/project/badge/Grade/6b13d0a35e514d87aaed6627280769b5)](https://www.codacy.com/gh/116davinder/kafka-cluster-ansible/dashboard?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=116davinder/kafka-cluster-ansible&amp;utm_campaign=Badge_Grade)

## **Requirements**
* Download Apache Kafka Tar on Ansible Server ( Mandatory )
* vagrant (optional)
* Any OS with SystemD
* Ansible

## **Notes***
```
1. why manual download of tar file because environments can be complex and there won't be any internet connection in production.
2. It assumes you have zookeeper already running in localmode or cluster mode.
3. All tasks like broker/jvm/logging/downgrade/removeOldVersion will be done in serial order.
4. It doesn't support upgrading old kafka clusters from 0.9.0 to 2.x versions.
5. Vagrant 6.x is not stable yet and older versions doesn't have support ubuntu 20 so it might not work.
6. Please use tags for production deployment, Master will be used as development branch.
```

## **Extra**
* **Open Source Web-UI** https://github.com/yahoo/kafka-manager
* **Zookeeper Installation**
https://github.com/116davinder/zookeeper-cluster-ansible

## **Development Setup with Vagrant**

### **Vagrant PreSetup for cluster**
It will update `/etc/hosts` with required dns names.

```ansible-playbook -i inventory/development/cluster.ini clusterVagrantDnsUpdater.yml```

## **Development with Cloud Infra Setup for Apache Kafka Using Terraform**

* `terraform/aws`
* `terraform/oci`

### **AWS Cloud PreSetup for cluster**
It will enable following things on all nodes.

1. `/kafka` mount point from ebs created by terraform.
2. Install and configure `awslogs` agent for kafka-logs.
3. Install python3 packages

* Update Required vars in ```inventory/<environment>/group_vars/all.yml``` .
* Update Required vars in ```inventory/<environment>/cluster.ini``` .

```ansible-playbook -i inventory/<environment>/cluster.ini clusterAwsPreSetup.yml```

## **Production Environment Setup**

### **To start new cluster**
* Update Required vars in ```inventory/<environment>/group_vars/all.yml``` .
* Update Required vars in ```inventory/<environment>/cluster.ini``` .

```ansible-playbook -i inventory/<environment>/cluster.ini clusterSetup.yml```

### **Monitoring for Kafka & Mirror Maker Cluster**
* **To add Custom monitoring to cluster**

`roles/jmxMonitor/files/kafka-input.txt`

`roles/jmxMonitor/files/kafka-mirror-input.txt`
```
ansible-playbook -i inventory/<environment>/cluster.ini clusterJmxMonitoringSetup.yml
```

* **To add Custom Consumer Group monitoring to cluster**

It will monitor consumer groups mentioned in below file.

`roles/jmxMonitor/files/kafka-consumer-group-metric-input.txt`

```
ansible-playbook -i inventory/<environment>/cluster.ini clusterConsumerMetricSetup.yml
```

* **Sample Splunk Dashboards**
```
files/splunk-dashboards
```
* **To add newrelic monitoring to cluster**

```ansible-playbook -i inventory/<environment>/cluster.ini clusterNewRelicSetup.yml```

* **Sample NewRelic Dashboards**

```
files/newrelic-dashboards
```


### **To add new broker to cluster**
* Update Required vars in ```inventory/<environment>/group_vars/all.yml``` .
* Update Required vars in ```inventory/<environment>/cluster.ini``` .

```ansible-playbook -i inventory/<environment>/cluster.ini clusterAddNodes.yml```

### **To Upgrade Kafka Version**
* download kafka tar in your local ansible box.
* Update Required vars in ```inventory/<environment>/group_vars/all.yml``` .
* Update Required vars in ```inventory/<environment>/cluster.ini``` .

```ansible-playbook -i inventory/<environment>/cluster.ini clusterUpgrade.yml```

### **Rolling restart cluster**

```ansible-playbook -i inventory/<environment>/cluster.ini clusterRollingRestart.yml```

### **To update broker settings only of cluster**
* Update Required vars in ```inventory/<environment>/group_vars/all.yml``` .

```ansible-playbook -i inventory/<environment>/cluster.ini clusterBrokerProperties.yml```

### **To update jvm settings only of cluster**
* Update Required vars in ```inventory/<environment>/group_vars/all.yml``` .

```ansible-playbook -i inventory/<environment>/cluster.ini clusterJvmConfigs.yml```

### **To update logging settings only of cluster**
* Update Required vars in ```inventory/<environment>/group_vars/all.yml``` .

```ansible-playbook -i inventory/<environment>/cluster.ini clusterLogging.yml```

### **To update crons settings of cluster and mirror maker cluster**
It contains cron for log file clean up for kafka cluster and kafka mirror maker cluster.

```ansible-playbook -i inventory/<environment>/cluster.ini clusterCrons.yml```

### **To upgrade java version of cluster**
* Update Required vars in ```inventory/<environment>/group_vars/all.yml``` .

```ansible-playbook -i inventory/<environment>/cluster.ini clusterJava.yml```

### **To remove old version files of kafka from cluster**
* Update Required vars in ```inventory/<environment>/group_vars/all.yml``` .

```ansible-playbook -i inventory/<environment>/cluster.ini clusterRemoveOldVersion.yml```

### **To remove kafka broker from cluster**
* Update Required vars in ```inventory/<environment>/group_vars/all.yml``` .

```ansible-playbook -i inventory/<environment>/cluster.ini clusterRemoveNodes.yml```

## **Apache Kafka Mirror Maker Playbooks**
It will be installed in similar way to apache kafka but it will start apache kafka mirror maker processes only.

**Note:***
* Apache Kafka & Apache Kafka Mirror Maker should not be installed on same node.
* It is recommended to install multiple kafka mirror maker process on same node and contolled by this parameter `kafkaMirrorMakerProcessCountPerNode`

### **To start new cluster**
* Update Required vars in ```inventory/<environment>/group_vars/all.yml``` .
* Update Required vars in ```inventory/<environment>/group_vars/kafka-mirror-maker.yml``` .

```ansible-playbook -i inventory/<environment>/cluster.ini clusterKafkaMirrorMaker.yml```

### **To upgrade cluster**
* Update Required vars in ```inventory/<environment>/group_vars/all.yml``` .
* Update Required vars in ```inventory/<environment>/group_vars/kafka-mirror-maker.yml``` .

```ansible-playbook -i inventory/<environment>/cluster.ini clusterKafkaMirrorMakerUpgrade.yml```

### **To Remove nodes from cluster**
* Update Required vars in ```inventory/<environment>/group_vars/all.yml``` .
* Update Required vars in ```inventory/<environment>/group_vars/kafka-mirror-maker.yml``` .

```ansible-playbook -i inventory/<environment>/cluster.ini clusterKafkaMirrorMakerRemoveNodes.yml```

### **Rolling Restart cluster**

```ansible-playbook -i inventory/<environment>/cluster.ini clusterKafkaMirrorMakerRollingRestart.yml```

## **Kafka Management / Operations**
### **Install / Upgrade / Update Kafka Manager ( CMAK )**
**Ref:** `https://github.com/yahoo/kafka-manager/releases`

* `inventory/<environment>/group_vars/kafka-manager.yml`

```ansible-playbook -i inventory/<environment>/cluster.ini clusterKafkaManager.yml```

### **Kafka Tested Version**
* 2.x

### **Tested OS**
* CentOS 7
* RedHat 7
* Ubuntu
* Amzaon Linux 2 ( under progress, might work :) )

### **Tested Ansible Version**
```
ansible: 6.1.0
ansible-base: 2.13.2
```
