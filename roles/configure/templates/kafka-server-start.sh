#!/bin/bash
# Licensed to the Apache Software Foundation (ASF) under one or more
# contributor license agreements.  See the NOTICE file distributed with
# this work for additional information regarding copyright ownership.
# The ASF licenses this file to You under the Apache License, Version 2.0
# (the "License"); you may not use this file except in compliance with
# the License.  You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

if [ $# -lt 1 ];
then
        echo "USAGE: $0 [-daemon] server.properties [--override property=value]*"
        exit 1
fi
base_dir=$(dirname $0)

if [ "x$KAFKA_LOG4J_OPTS" = "x" ]; then
    export KAFKA_LOG4J_OPTS="-Dlog4j.configuration=file:$base_dir/../config/log4j.properties"
fi

if [ "x$KAFKA_HEAP_OPTS" = "x" ]; then
    export KAFKA_HEAP_OPTS="-Xmx{{ kafkaXmx }} -Xms{{ kafkaXms }}"
fi

EXTRA_ARGS=${EXTRA_ARGS-'-name kafkaServer -loggc'}

COMMAND=$1
case $COMMAND in
  -daemon)
    EXTRA_ARGS="-daemon "$EXTRA_ARGS
    shift
    ;;
  *)
    ;;
esac

# java use IPv4 stack
export KAFKA_IPV4_STACK_OPTS="-Djava.net.preferIPv4Stack=true"

# kafka OOM settings
export KAFKA_OOM_OPTS="-XX:+HeapDumpOnOutOfMemoryError -XX:HeapDumpPath={{ kafkaLogDir }} "

# kafka gc logs settings
{% if kafkaGcLogs %}
{% if javaVersion > 9 %}
export KAFKA_GC_LOG_OPTS="-Xlog:gc*:file={{ kafkaGcLogsLocation }}/kafkaServer-gc.log:time,tags:filecount={{ kafkaGcLogFileCount }},filesize={{ kafkaGcLogFileSize }}"
{% else %}
export KAFKA_GC_LOG_OPTS="-Xloggc:{{ kafkaGcLogsLocation }}/kafkaServer-gc.log -verbose:gc -XX:+PrintGCDetails -XX:+PrintGCDateStamps -XX:+PrintGCTimeStamps -XX:+UseGCLogFileRotation -XX:NumberOfGCLogFiles={{ kafkaGcLogFileCount }} -XX:GCLogFileSize={{ kafkaGcLogFileSize }}"
{% endif %}
{% endif %}

# kafka jmx settings
export KAFKA_JMX_OPTS="-Djava.rmi.server.hostname=0.0.0.0 -Dcom.sun.management.jmxremote.local.only=false -Dcom.sun.management.jmxremote.rmi.port={{ kafkaJmxPort }} -Dcom.sun.management.jmxremote.port={{ kafkaJmxPort }} -Dcom.sun.management.jmxremote=true -Dcom.sun.management.jmxremote.authenticate=false -Dcom.sun.management.jmxremote.ssl=false"
export KAFKA_JMX_OPTS="$KAFKA_JMX_OPTS $KAFKA_IPV4_STACK_OPTS"

export JMX_PORT={{ kafkaJmxPort }}

# aggregate opts
export KAFKA_HEAP_OPTS="$KAFKA_HEAP_OPTS $KAFKA_OOM_OPTS"

exec $base_dir/kafka-run-class.sh $EXTRA_ARGS kafka.Kafka "$@"
