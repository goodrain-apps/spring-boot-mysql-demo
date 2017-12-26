FROM maven:3.5.2-jdk-7-alpine

RUN mkdir /app

COPY . /app/

WORKDIR /app
RUN mv /app/settings.xml /root/.m2/ \
    && mvn clean install

ENTRYPOINT ["/app/run.sh"]
