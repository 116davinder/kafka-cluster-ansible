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

## Apache Kafka Playbooks

### **To start new cluster**
* Update Required vars in ```inventory/<environment>/group_vars/all.yml``` .
* Update Required vars in ```inventory/<environment>/cluster.ini``` .

```ansible-playbook -i inventory/<environment>/cluster.ini clusterSetup.yml```

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

### **To add newrelic monitoring to cluster**
* add newrelic rpms to `files` folder.

```ansible-playbook -i inventory/<environment>/cluster.ini clusterNewRelicSetup.yml```

### **To update broker settings only of cluster**
* Update Required vars in ```inventory/<environment>/group_vars/all.yml``` .

```ansible-playbook -i inventory/<environment>/cluster.ini clusterBrokerProperties.yml```

### **To update jvm settings only of cluster**
* Update Required vars in ```inventory/<environment>/group_vars/all.yml``` .

```ansible-playbook -i inventory/<environment>/cluster.ini clusterJvmConfigs.yml```

### **To update logging settings only of cluster**
* Update Required vars in ```inventory/<environment>/group_vars/all.yml``` .

```ansible-playbook -i inventory/<environment>/cluster.ini clusterLogging.yml```

### **To upgrade java version of cluster**
* Update Required vars in ```inventory/<environment>/group_vars/all.yml``` .

```ansible-playbook -i inventory/<environment>/cluster.ini clusterJava.yml```

### **To remove old version files of kafka from cluster**
* Update Required vars in ```inventory/<environment>/group_vars/all.yml``` .

```ansible-playbook -i inventory/<environment>/cluster.ini clusterRemoveOldVersion.yml```

### **To remove kafka broker from cluster**
* Update Required vars in ```inventory/<environment>/group_vars/all.yml``` .

```ansible-playbook -i inventory/<environment>/cluster.ini clusterRemoveNodes.yml```

## Apache Kafka Mirror Maker Playbooks

### **To start new cluster**
* Update Required vars in ```inventory/<environment>/group_vars/kafka-mirror-maker.yml``` .
* Update Required vars in ```inventory/<environment>/mirror-maker.ini``` .

```ansible-playbook -i inventory/<environment>/mirror-maker.ini clusterKafkaMirrorMaker.yml```

### **To Remove nodes from cluster**
* Update Required vars in ```inventory/<environment>/group_vars/kafka-mirror-maker.yml``` .
* Update Required vars in ```inventory/<environment>/mirror-maker.ini``` .

```ansible-playbook -i inventory/<environment>/mirror-maker.ini clusterKafkaMirrorMakerRemoveNodes.yml```

### **Rolling restart cluster**

```ansible-playbook -i inventory/<environment>/mirror-maker.ini clusterKafkaMirrorMakerRollingRestart.yml```


### **Tested OS**
* CentOS 7
* RedHat 7

### **Tested Ansible Version**
```
ansible 2.8.1
  config file = None
  configured module search path = ['/home/davinderpal/.ansible/plugins/modules', '/usr/share/ansible/plugins/modules']
  ansible python module location = /usr/local/lib/python3.6/dist-packages/ansible
  executable location = /usr/local/bin/ansible
  python version = 3.6.7 (default, Oct 22 2018, 11:32:17) [GCC 8.2.0]
```
