# Splunk Logging Configuration

**Example**
```
[default]
host = $HOSTNAME

[monitor:///kafka/kafka-logs/*.log]
disabled = false
index = kafka
sourcetype = kafka
crcSalt = <SOURCE>
```