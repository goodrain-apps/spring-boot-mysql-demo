FROM maven:3.5.2-jdk-7-alpine

RUN mkdir /app

COPY . /app/

WORKDIR /app

EXPOSE 5000

RUN mvn -B -DskipTests=true clean install

ENTRYPOINT ["/app/run.sh"]
