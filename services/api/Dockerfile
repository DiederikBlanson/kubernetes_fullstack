FROM python:3.8.5-alpine
WORKDIR /app
COPY . /app

RUN apk update
RUN apk add py-pip
RUN apk add --no-cache python3-dev 
RUN pip install --upgrade pip

RUN apk add gcc musl-dev python3-dev libffi-dev openssl-dev
RUN pip --no-cache-dir install -r requirements.txt

EXPOSE 5000
CMD ["python", "app.py"]