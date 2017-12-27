# Spring Boot Rainbond demo

该demo是基于maven的docker镜像制作的，构建镜像过程中或会通过maven编译jave程序

## 创建demo镜像

```bash
docker build goodrainapps/spring-boot-demo .
```

## 运行demo

```bash
# 先运行mysql
docker run -d --name mysql -e MYSQL_ROOT_PASSWORD=123456 mysql

docker run -it --rm --link mysql \
-p 5000:5000 \
-e MYSQL_HOST=mysql \
-e MYSQL_PORT=3306 \
-e MYSQL_USER=root \
-e MYSQL_PASS=123456 \
goodrainapps/spring-boot-demo
```

## demo相关的文档

### 先通过spring cli创建demo项目

```bash

docker run -it --rm \
-v $PWD:/app goodrainapps/spring-boot-cli:1.5.9 spring init --dependencies=web spring-boot-demo

cd spring-boot-demo/src/main/java/com/example/springbootdemo
```

### 编辑 DemoApplication.java  文件，内容如下:

```java
package com.example.rainbondspringdemo;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

import org.springframework.web.bind.annotation.*;
import org.springframework.stereotype.*;

@Controller
@SpringBootApplication
public class DemoApplication {

        @RequestMapping("/")
        @ResponseBody
        String home() {
                return "Hello World!";
        }

        public static void main(String[] args) {
                SpringApplication.run(DemoApplication.class, args);
        }
}
```
先写个简单的hello world

### build

```bash
cd spring-boot-demo
docker run -it --rm \
-v "$PWD":/app/build \
-w /app/build maven:3.5.2-jdk-7-alpine mvn -B -DskipTests=true -s settings.xml clean install
```

### run

```bash
cd spring-boot-demo
docker run -it --rm -v $PWD:/app -w /app -p 8080:8080  goodrainapps/openjdk:8u131-jre-alpine java  -jar target/*.jar

```
### 添加数据库支持

待完善……

### docker化改造
待完善……

### 运行

```bash
docker run -d --name mysql -e MYSQL_ROOT_PASSWORD=123456 mysql


cd spring-boot-rainbond-demo
docker run -it --rm -v $PWD:/app -w /app -p 8080:8080  goodrainapps/openjdk:8u131-jre-alpine java  -jar target/*.jar

```
