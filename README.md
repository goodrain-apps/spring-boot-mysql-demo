# Spring Boot MySQL demo

该demo是基于maven的docker镜像制作的，构建镜像过程中或会通过maven编译jave程序

## 创建demo镜像

```bash
docker build goodrainapps/spring-boot-mysql-demo .
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
goodrainapps/spring-boot-mysql-demo
```

## demo相关的文档

### 先通过spring cli创建demo项目

```bash
docker run -it --rm \
-v $PWD:/app goodrainapps/spring-boot-cli:1.5.9 spring init --dependencies=web spring-boot-mysql-demo

cd spring-boot-mysql-demo/src/main/java/com/example/springbootdemo
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

为了加快maven构建，在setting.xml中添加了国内的mirror。将本文对应源码中的`setting.xml`拷到您的`spring-boot-mysql-demo`中。

```bash
cd spring-boot-mysql-demo
docker run -it --rm \
-v "$PWD":/app/build \
-w /app/build maven:3.5.2-jdk-7-alpine mvn -B -DskipTests=true -s settings.xml clean install
```

### run

```bash
cd spring-boot-mysql-demo
docker run -it --rm -v $PWD:/app -w /app -p 8080:8080  goodrainapps/openjdk:8u131-jre-alpine java  -jar target/*.jar
```

### 添加数据库支持

#### 连接数据库

添加以下内容，将此应用与数据库进行连接。

在`pom.xml`内添mysql数据库服务 ：

```xml
<dependency>
   <groupId>mysql</groupId>
   <artifactId>mysql-connector-java</artifactId>
   <version>5.1.9</version>
</dependency>
```

添加下JDBC驱动：

```Xml
<dependency>
   <groupId>org.springframework.boot</groupId>
   <artifactId>spring-boot-starter-jdbc</artifactId>
</dependency>
```

在`application.properties`添加数据库连接信息：

```properties
spring.datasource.url=jdbc:mysql://${MYSQL_HOST}:${MSYQL_PORT}/demo?createDatabaseIfNotExist=true
spring.datasource.username=${MYSQL_USER}
spring.datasource.password=${MYSQL_PASS}
spring.datasource.driver-class-name=com.mysql.jdbc.Driver
spring.datasource.maxActive=10
spring.datasource.maxIdle=5
spring.datasource.minIdle=2
spring.datasource.initialSize=5
spring.datasource.removeAbandoned=true
```

在源码添加`DatabaseConfig.java`

```java
@Configuration
public class DatabaseConfig {
    @Bean
    @Primary
    @ConfigurationProperties(prefix = "spring.datasource")
    public DataSource dataSource() {
        return new org.apache.tomcat.jdbc.pool.DataSource();
    }
}
```

#### 数据库初始化

使用 [JPA](http://www.jpa.gov.my/) 管理生成实体的映射关系的代码。

```xml
<dependency>
   <groupId>org.springframework.boot</groupId>
   <artifactId>spring-boot-starter-data-jpa</artifactId>
</dependency
```

#### 数据库重构与迁移

使用[LiquiBase](http://www.liquibase.org/index.html)，以便将JPA生成实体的映射关系在数据库体现。第一步，在`pom.xml`添加：

```xml
<dependency>
   <groupId>org.liquibase</groupId>
   <artifactId>liquibase-core</artifactId>
   <version>3.4.1</version>
</dependency>
```

第二步，创建 Liquibase 的修改日志,默认从 `db.changelog-master.yaml` 读取：
```yaml
databaseChangeLog:
  - changeSet:
      id: 1
      author: <your_name>
      changes:
        - createTable:
            tableName: person						#表明
            columns:
              - column:
                  name: id							#字段名
                  type: int							#字段类型
                  autoIncrement: true				#是否自增
                  constraints:						
                    primaryKey: true				#是否主键
                    nullable: false					#是否为null
              - column:
                  name: first_name
                  type: varchar(255)
                  constraints:
                    nullable: false
              - column:
                  name: last_name
                  type: varchar(255)
                  constraints:
                    nullable: false
```

### 渲染工具

Thymeleaf可以帮助渲染`XML`、`XHTML`、`HTML5`内容的模板引擎，它也可以轻易的与`Spring MVC`等Web框架集成作为Web应用的模板引擎。在`pom.xml`中添加：

```xml
<dependency>
   <groupId>org.springframework.boot</groupId>
   <artifactId>spring-boot-starter-thymeleaf</artifactId>
</dependency>
```

### docker化改造

使用Dockerfile集成Spring Boot。maven镜像加上spring的环境配置

### 运行

```bash
docker run -d --name mysql -e MYSQL_ROOT_PASSWORD=123456 mysql


cd spring-boot-rainbond-demo
docker run -it --rm -v $PWD:/app -w /app -p 8080:8080  goodrainapps/openjdk:8u131-jre-alpine java  -jar target/*.jar

```