from fastapi import FastAPI
from fastapi.staticfiles import StaticFiles

app = FastAPI()
print("서버 시작")
app.mount('/static', StaticFiles(directory="static"), name="static")

