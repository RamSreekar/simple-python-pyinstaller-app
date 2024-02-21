FROM python:3.11.6-alpine

RUN pip install pytest==8.0.1

RUN pip install pyinstaller==6.4.0

RUN apk update

RUN apk add binutils

COPY . /app

WORKDIR /app

CMD [ "python3" ]