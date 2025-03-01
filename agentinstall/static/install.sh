#!/bin/bash

# MQTT 브로커 설치 확인
if ! command -v mosquitto >/dev/null 2>&1; then
    echo "🚀 Mosquitto 설치 중..."
    apt update
    apt install -y mosquitto mosquitto-clients
    apt install -y jq
    systemctl enable mosquitto
    systemctl start mosquitto
    echo "✅ Mosquitto 설치 완료!"
else
    echo "✅ Mosquitto 이미 설치됨!"
fi

# 에이전트 다운로드 경로
AGENT="mqtt_publisher.sh"
AGENT_URL="http://install_server:8000/static/mqtt_publisher.sh"
AGENT_PATH="/usr/local/bin/mqtt_publisher.sh"

# 에이전트 다운로드
echo "🚀 MQTT 에이전트 다운로드 중..."
curl -o "$AGENT_PATH" "$AGENT_URL"

# 실행 권한 부여
chmod +x "$AGENT_PATH"

# 백그라운드 실행
echo "🔄 MQTT 에이전트 실행 중..."
"$AGENT"

echo "✅ 설치 및 실행 완료!"
