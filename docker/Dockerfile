FROM python:2.7-slim

MAINTAINER malashkovv@gmail.com

WORKDIR /web

ADD . /web

RUN pip install Flask

EXPOSE 8000

CMD ["python", "web/app.py"]