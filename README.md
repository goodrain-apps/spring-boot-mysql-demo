# Spring Boot Goodrain demo

[![License](http://img.shields.io/:license-apache-blue.svg)](http://www.apache.org/licenses/LICENSE-2.0.html)

This is a small demo application for showing how to run a [Spring Boot](http://projects.spring.io/spring-boot/)
application on [Goodrain](https://www.goodrain.com). For more information see the Dev Center article on 
[Deploying Spring Boot Applications to Goodrain](https://www.rainbond.com/articles/deploying-spring-boot-apps-to-goodrain).

## How to use

```bash
docker run -it --link mysql -e DATABASE_URL='jdbc:mysql://mysql:3306/test' -p 5000:5000 spring-boot-database-demo
```

## License

Code is under the [Apache Licence v2](https://www.apache.org/licenses/LICENSE-2.0.txt).
