#!/usr/bin/env python3

# usage: python3 kafka-jmx-metric-collector.py localhost 9999 roles/jmxMonitor/files/input.txt /tmp/ kafka-dev

# This script suppose to export all kafka metric from one node and write to file
# from where either splunk like tools can read it.

from jmxquery import JMXQuery, JMXConnection
from socket import gethostname
import json
import sys
import psutil
import threading
import pendulum


class KafkaJmx:
    def __init__(self, kAddr, kPort, inputFile, logDir, env):
        self.kAddr = kAddr
        self.kPort = kPort
        self.kJmxAddr = (
            "service:jmx:rmi:///jndi/rmi://"
            + str(self.kAddr)
            + ":"
            + str(self.kPort)
            + "/jmxrmi"
        )
        self.cTimeNow = str(pendulum.today())
        self.jmxConnection = JMXConnection(self.kJmxAddr)
        self.inputFile = inputFile
        self.logDir = logDir
        self.env = env
        self.domainNameList = [
            "java.lang",
            "kafka.controller",
            "kafka.log",
            "kafka.network",
            "kafka.server",
            "kafka.utils",
        ]

    def getMetric(self):
        with open(self.inputFile) as file:
            for query in file:
                query = query.strip()
                if not query.startswith("#") and len(query) > 0:
                    metrics = self.jmxConnection.query(
                        [JMXQuery(query)], timeout=1000000
                    )
                    for metric in metrics:
                        domainName = metric.to_query_string().split(":")[0]
                        queryName = metric.to_query_string().split(":")[1]
                        queryValue = metric.value
                        _queryDict = {
                            "@timestamp": self.cTimeNow,
                            "domainName": str(domainName),
                            "environment": str(self.env),
                            "queryName": str(queryName),
                            "queryValue": queryValue,
                        }
                        with open(self.logDir + domainName + ".log", "a+") as logFile:
                            logFile.write("\n")
                            logFile.write(json.dumps(_queryDict))

    def cleanUpFiles(self):
        for domainName in self.domainNameList:
            open(self.logDir + domainName + ".log", "w").close()

    def getStorageMetric(self):
        _sMM = psutil.disk_usage("/kafka")
        _sMetric = {
            "@timestamp": self.cTimeNow,
            "domainName": "disk",
            "environment": self.env,
            "totalInGB": _sMM.total // (2 ** 30),
            "usedInGB": _sMM.used // (2 ** 30),
            "freeInGB": _sMM.free // (2 ** 30),
            "usedPercent": _sMM.percent,
        }

        with open(self.logDir + "disk.log", "w") as logFile:
            logFile.write(json.dumps(_sMetric))

    def getCpuMetric(self):
        _cMetric = {
            "@timestamp": self.cTimeNow,
            "domainName": "cpu",
            "environment": self.env,
            "usedCpuPercent": psutil.cpu_percent(),
        }

        with open(self.logDir + "cpu.log", "w") as logFile:
            logFile.write(json.dumps(_cMetric))

    def getMemoryMetric(self):
        _memStats = psutil.virtual_memory()
        _swapMemStats = psutil.swap_memory()
        _rMetric = {
            "@timestamp": self.cTimeNow,
            "domainName": "memory",
            "environment": self.env,
            "totalMem": _memStats.total // (2 ** 30),
            "availableMem": _memStats.available // (2 ** 30),
            "percentUsedMem": _memStats.percent,
            "usedMem": _memStats.used // (2 ** 30),
            "buffers": _memStats.buffers // (2 ** 30),
            "totalSwap": _swapMemStats.total // (2 ** 30),
            "usedSwap": _swapMemStats.used // (2 ** 30),
            "freeSwap": _swapMemStats.free // (2 ** 30),
            "percentUsedSwap": _swapMemStats.percent,
        }

        with open(self.logDir + "memory.log", "w") as logFile:
            logFile.write(json.dumps(_rMetric))


def main():
    hostname = sys.argv[1]
    port = sys.argv[2]
    inputFile = sys.argv[3]
    logDir = sys.argv[4]
    env = sys.argv[5]

    z = KafkaJmx(hostname, port, inputFile, logDir, env)
    z.cleanUpFiles()

    threading.Thread(target=z.getMetric).start()

    threading.Thread(target=z.getCpuMetric).start()

    threading.Thread(target=z.getMemoryMetric).start()

    threading.Thread(target=z.getStorageMetric).start()


main()
