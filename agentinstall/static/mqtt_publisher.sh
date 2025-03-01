#!/bin/bash

# MQTT 브로커 주소
MQTT_BROKER="monito_server"  # 로컬 Mosquitto 브로커 사용
TOPIC="server/metrics/user1234"


while true
do
    # 리소스 정보 수집
    HOSTNAME=$(hostname)
    CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | awk '{print 100 - $8}')
    MEM_USAGE=$(free -m | awk '/Mem:/ {printf "%.2f", $3/$2 * 100}')
    DISK_USAGE=$(df -h / | awk 'NR==2 {print $5}' | tr -d '%')

    # JSON 데이터 생성
    JSON_DATA=$(jq -n \
        --arg host "$HOSTNAME" \
        --arg cpu "$CPU_USAGE" \
        --arg mem "$MEM_USAGE" \
        --arg disk "$DISK_USAGE" \
        --arg broker "$MQTT_BROKERE" \
        --arg topic "$TOPIC" \
        '{hostname: $host, cpu: $cpu, memory: $mem, disk: $disk, timestamp: now, broker: $broker, topic: $topic}')

    # MQTT로 데이터 전송
    mosquitto_pub -h "$MQTT_BROKER" -t "$TOPIC" -m "$JSON_DATA"

    echo "✅ MQTT 데이터 전송됨: $JSON_DATA"

    sleep 2
done
