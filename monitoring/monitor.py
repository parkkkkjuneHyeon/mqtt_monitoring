import paho.mqtt.client as mqtt
import json
import time

user_id = "user1234"
MQTT_BROKER = "localhost"  # MQTT 브로커 주소
TOPIC = f"server/metrics/{user_id}"

# MQTT 메시지 수신 콜백 함수
def on_message(client, userdata, msg):
    try:
        data = json.loads(msg.payload.decode())
        print(f"📥 MQTT 데이터 수신: {data}")
    except Exception as e:
        print(f"❌ 데이터 파싱 오류: {e}")

def mqtt_thread():
    client = mqtt.Client(mqtt.CallbackAPIVersion.VERSION2)
    client.on_message = on_message

    # MQTT 연결 시도 (예외 처리 추가)
    for _ in range(5):  # 5번까지 재시도
        try:
            print("🔄 MQTT 브로커 연결 시도 중...")
            client.connect(MQTT_BROKER, 1883, 60)
            print("✅ MQTT 브로커 연결 성공")
            client.subscribe(TOPIC)
            print("🚀 MQTT 구독 시작...")
            client.loop_forever()
            break  # 연결 성공하면 루프 탈출
        except Exception as e:
            print(f"❌ MQTT 연결 실패: {e}")
            time.sleep(5)  # 5초 후 재시도

mqtt_thread()
