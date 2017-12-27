#!/bin/bash

PORT=${PORT:-5000}

sleep ${PAUSE:-0}

exec  java -Dserver.port=$PORT $JAVA_OPTS -jar target/*.jar
