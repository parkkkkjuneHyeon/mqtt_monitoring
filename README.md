# mqtt_monitoring
MQTT Mosquitto를 이용한 리소스 모니터링
총 3개의 호스트가 필요함<br>
하나는 mqtt agent를 설치파일을 전달해 줄 서버 -> agentinstall<br>
두번째는 자신의 리소스 정보를 전달해 줄 호스트 -> 리소스 헬스체크 받을 호스트 <br>
세번째는 리소스를 전달받는 서버 -? monitoring <br>
도커를 사용해서 3개의 컨테이너를 띄워서 실행해야함.
