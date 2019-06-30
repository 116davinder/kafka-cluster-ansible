# Kafka Manager Guide

# Installation
1. Download the latest Release Code:  ( https://github.com/yahoo/kafka-manager/releases )
2. Build the Code in your desktop ( https://github.com/yahoo/kafka-manager/blob/master/README.md#deployment )
3. Upload Zip to kafka Manager Node
4. Install OpenJDK 8
5. update zookeeper address kafka-manager/conf/application.conf only
```
kafka-manager.zkhosts="10.0.0.1:2181,10.0.0.2:2181,10.0.0.3:2181"
```
6. create kafka-manager systemd file
```
cat /usr/lib/systemd/system/kafka-manager.service
[Unit]
Description=Apache Kafka
After=syslog.target network.target

[Service]
Type=simple

ExecStart=/kafka-manager/kafka-manager/bin/kafka-manager

[Install]
WantedBy=multi-user.target
```

7. update basic auth settings
```
basicAuthentication.enabled=true
basicAuthentication.username="admin"
basicAuthentication.password="xxxxxxx"
```

8. Start Kafka Manager Service


# UI Access
Kafka Manager Start at **`9000`** Port.