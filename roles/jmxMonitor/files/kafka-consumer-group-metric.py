from kafka import KafkaConsumer, TopicPartition, KafkaAdminClient
import json
import sys
from datetime import datetime
import threading
import pendulum


class KCMetric:
    def __init__(self, topic, group_id, logDir, env):

        self.TOPIC = topic
        self.GROUP = group_id
        self.BOOTSTRAP_SERVERS = ["localhost"]
        self.ENV = env
        self.LOGDIR = logDir

        self.metricJsonDict = {
            "topic": self.TOPIC,
            "group_id": self.GROUP,
            "env": self.ENV,
            "@timestamp": str(pendulum.today()),
            "partition": {},
        }

    def checkConsumerGroupName(self):
        __kc = KafkaAdminClient(bootstrap_servers=self.BOOTSTRAP_SERVERS)
        cgnTuple = (self.GROUP, "consumer")
        for i in __kc.list_consumer_groups():
            if cgnTuple == i:
                return True
        return False

    def getMetric(self):
        consumer = KafkaConsumer(
            bootstrap_servers=self.BOOTSTRAP_SERVERS,
            group_id=self.GROUP,
            enable_auto_commit=False,
        )

        for p in consumer.partitions_for_topic(self.TOPIC):
            tp = TopicPartition(self.TOPIC, p)
            consumer.assign([tp])
            committed_offset = consumer.committed(tp)
            if committed_offset is None:
                committed_offset = 0
            for _, v in consumer.end_offsets([tp]).items():
                latest_offset = v
            self.metricJsonDict["partition"][p] = {}
            self.metricJsonDict["partition"][p]["committed_offset"] = committed_offset
            self.metricJsonDict["partition"][p]["latest_offset"] = latest_offset
            self.metricJsonDict["partition"][p]["lag"] = (
                latest_offset - committed_offset
            )

        with open(self.LOGDIR + "kafka-consumer-group-metrics.log", "a+") as logFile:
            logFile.write("\n")
            logFile.write(json.dumps(self.metricJsonDict))
            logFile.write("\n")
        consumer.close(autocommit=False)


def main():
    inputFile = sys.argv[1]
    logDir = sys.argv[2]
    env = sys.argv[3]

    # clean up log file before writing new data
    open(logDir + "/kafka-consumer-group-metrics.log", "w").close()

    for line in open(inputFile):
        line = line.strip()
        if not line.startswith("#") and len(line) > 0:
            topic = line.split()[0] + "." + env.split("-kafka")[0]
            group_id = line.split()[1]
            try:
                kc = KCMetric(topic.strip(), group_id.strip(), logDir, env)
                if kc.checkConsumerGroupName():
                    threading.Thread(target=kc.getMetric).start()
            except Exception as error:
                print(f"something failed: {error}")


main()
