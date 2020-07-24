# Apache Kafka Ansible

It is group of playbooks to manage apache kafka. It is also 100% compliant with ansible-lint rules.

## **Requirements**
* Download Apache Kafka Tar on Ansible Server ( Mandatory )
* vagrant (optional)
* Any OS with SystemD
* Ansible

## **Notes***
```
1. It assumes you have zookeeper already running in localmode or cluster mode.
2. All tasks like broker/jvm/logging/downgrade/removeOldVersion will be done in serial order.
```

## **Extra**
* **Open Source Web-UI** https://github.com/yahoo/kafka-manager
* **Zookeeper Installation**
https://github.com/116davinder/zookeeper-cluster-ansible

# **Production Environment Setup**

## **Apache Kafka Playbooks**

### **To start new cluster**
* Update Required vars in ```inventory/<environment>/group_vars/all.yml``` .
* Update Required vars in ```inventory/<environment>/cluster.ini``` .

```ansible-playbook -i inventory/<environment>/cluster.ini clusterSetup.yml```

### Monitoring for Kafka Cluster
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
these are under "files/splunk dashboards" folder.
```
* **To add newrelic monitoring to cluster**

```ansible-playbook -i inventory/<environment>/cluster.ini clusterNewRelicSetup.yml```

* **Sample NewRelic Dashboards**
```
these are under "files/newrelic-dashboards" folder.
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

```ansible-playbook -i inventory/<environment>/mirror-maker.ini clusterKafkaMirrorMaker.yml```

### **To upgrade cluster**
* Update Required vars in ```inventory/<environment>/group_vars/all.yml``` .
* Update Required vars in ```inventory/<environment>/group_vars/kafka-mirror-maker.yml``` .

```ansible-playbook -i inventory/<environment>/cluster.ini clusterKafkaMirrorMakerUpgrade.yml```

### **To Remove nodes from cluster**
* Update Required vars in ```inventory/<environment>/group_vars/all.yml``` .
* Update Required vars in ```inventory/<environment>/group_vars/kafka-mirror-maker.yml``` .

```ansible-playbook -i inventory/<environment>/mirror-maker.ini clusterKafkaMirrorMakerRemoveNodes.yml```

### **Rolling restart cluster**

```ansible-playbook -i inventory/<environment>/mirror-maker.ini clusterKafkaMirrorMakerRollingRestart.yml```

### **Install / Upgrade / Update Kafka Manager**
* `inventory/<environment>/group_vars/kafka-manager.yml`

```ansible-playbook -i inventory/<environment>/cluster.ini clusterKafkaManager.yml```

### **Tested OS**
* CentOS 7
* RedHat 7

### **Tested Ansible Version**
```
ansible 2.9.11
  config file = None
  configured module search path = ['/home/davinderpal/.ansible/plugins/modules', '/usr/share/ansible/plugins/modules']
  ansible python module location = /usr/local/lib/python3.8/dist-packages/ansible
  executable location = /usr/local/bin/ansible
  python version = 3.8.2 (default, Jul 16 2020, 14:00:26) [GCC 9.3.0]
```
