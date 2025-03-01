# 베이스 이미지는 파이썬 3.9 버전의 슬림 이미지를 사용해요.
FROM python:3.9-slim

RUN apt-get update
RUN apt install -y jq
RUN apt install -y systemctl

# 작업 디렉토리를 /app으로 설정해요.
WORKDIR /app

# requirements.txt 파일을 컨테이너로 복사해요.
COPY requirements.txt .

# requirements.txt에 있는 라이브러리들을 설치해요.
RUN pip install --no-cache-dir -r requirements.txt

# 애플리케이션의 나머지 파일들을 모두 컨테이너에 복사해요.
COPY . .

# FastAPI 서버가 사용하는 포트 8000을 개방해요.
EXPOSE 8000

# 컨테이너가 시작될 때 uvicorn을 사용해서 FastAPI 앱(app.py의 app 객체)을 실행해요.
CMD ["sh", "-c", "uvicorn app:app --host 0.0.0.0 --port 8000"]
