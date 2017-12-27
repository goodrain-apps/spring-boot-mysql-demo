# Spring Boot Rainbond demo

[![License](http://img.shields.io/:license-apache-blue.svg)](http://www.apache.org/licenses/LICENSE-2.0.html)

This is a small demo application for showing how to run a [Spring Boot](http://projects.spring.io/spring-boot/)
application on [Goodrain](https://www.goodrain.com). For more information see the Dev Center article on 
[Deploying Spring Boot Applications to Rainbond](https://www.rainbond.com/articles/deploying-spring-boot-apps-to-goodrain).

## How to use

```bash

docker run -it --rm \
-v $PWD:/app goodrainapps/spring-boot-cli:1.5.9 spring init --dependencies=web rainbond-spring-demo

cd rainbond-spring-demo/src/main/java/com/example/rainbondspringdemo
```

编辑 DemoApplication.java  文件，内容如下

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

build

```bash
docker run -it --rm \
-v "$PWD"/rainbond-spring-demo:/app/build \
-w /app/build maven:3.5.2-jdk-7-alpine mvn -B -DskipTests=true -s settings.xml clean install
```


docker run -it --link mysql -e DATABASE_URL='jdbc:mysql://mysql:3306/test' -p 5000:5000 spring-boot-database-demo
```

## License

Code is under the [Apache Licence v2](https://www.apache.org/licenses/LICENSE-2.0.txt).
