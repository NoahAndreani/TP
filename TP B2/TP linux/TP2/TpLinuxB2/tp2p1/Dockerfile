FROM python:3

RUN apt update -y

WORKDIR /app

COPY pyapp/requirements.txt ./

RUN pip install -r requirements.txt

COPY ./pyapp/main.py .

CMD [ "python", "main.py"]