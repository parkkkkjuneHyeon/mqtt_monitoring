# 베이스 이미지는 파이썬 3.9 버전의 슬림 이미지를 사용해요.
FROM python:3.9-slim

# Mosquitto 설치 (Debian 기반 패키지 사용)
RUN apt-get update
RUN apt install -y jq
RUN apt install -y systemctl
RUN apt-get install -y mosquitto
RUN systemctl enable mosquitto
RUN systemctl restart mosquitto

# 작업 디렉토리를 /app으로 설정해요.
WORKDIR /app

# requirements.txt 파일을 컨테이너로 복사해요.
COPY requirements.txt .

# requirements.txt에 있는 라이브러리들을 설치해요.
RUN pip install --no-cache-dir -r requirements.txt

# 애플리케이션의 나머지 파일들을 모두 컨테이너에 복사해요.
COPY . .

# FastAPI 서버가 사용하는 포트 8000을 개방해요.
EXPOSE 1883

CMD ["sh", "-c", "mosquitto -c /etc/mosquitto/mosquitto.conf & python monitor.py"]
