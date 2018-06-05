#  Java Spring Docker Image

The Java Spring Docker Image substantially simplifies the environment and configuration setup for spring project. It can be used for development, demonstration, and test. It is a DevOps enviroment and proof of concepts. It can be further developed into an integrated part of continuous development, continuous delivery, and deployment pipeline.

## Demonstration and Test

In project - <a href="https://github.com/samw2017/spring-data-service">A Spring Boot Based Data Service</a>, this docker image is used for demonstration and Test:

<b>Step 1</b> Setup databse

If you have a database running somewhere, no need to run a mysql docker image. Otherwise, 

<pre>
docker run -d --rm --name=database-server -e MYSQL_ROOT_PASSWORD=newPassword -e MYSQL_ROOT_HOST="%" -e MYSQL_DATABASE=employees -p 3306:3306 mysql/mysql-server:latest
</pre>

<b>Step 2</b> Run java-spring docker image

<pre>
docker run -it --rm --name=data-service --link database-server:database-server -e DB_HOST_NAME=database-server -e DB_USER_NAME=root -e DB_USER_PASS=newPassword -p 8080:8080 samwen2017/java-spring:latest sh
</pre>

<b>Step 3</b> Get source

<pre>
git clone https://github.com/samw2017/spring-data-service.git
cd spring-data-service
</pre>

## Development

In development scenario, you may already an IDE environment setup, but want to run, verify and test before submitting your code for any reasons. You may run it many times a day. The same project is used, but setup differently.

<b>Step 1</b> Run mysql docker image

If you have a database running somewhere, no need to run a mysql docker image. Otherwise, 
<pre>
docker run -d --rm --name=database-server -e MYSQL_ROOT_PASSWORD=newPassword -e MYSQL_ROOT_HOST="%" -e MYSQL_DATABASE=employees -p 3306:3306 mysql/mysql-server:latest
</pre>

<b>Step 2</b> Get source

<pre>
# Your WORKSPACE directory hosts multiple projects
cd WORKSPACE
export WORKSPACE=$(pwd)

git clone https://github.com/samw2017/spring-data-service.git

# WORKSPACE is the parent directory of spring-data-service
</pre>

<b>Step 3</b> Run java-spring docker image

<pre>
docker run -it --rm --name=data-service -v /tmp/local-repo:/tmp/local-repo -v ${WORKSPACE}/spring-data-service:/workspace/spring-data-service --link database-server:database-server -e DB_HOST_NAME=database-server -e DB_USER_NAME=root -e DB_USER_PASS=newPassword -p 8080:8080 samwen2017/java-spring:latest sh

cd spring-data-service

mvn clean test

mvn clean spring-boot:run

# for running the simple text based HAL browser client

docker run -it --rm --name=data-client --link data-service:data-service -v /tmp/local-repo:/tmp/local-repo -v ${WORKSPACE}/spring-data-service:/workspace/spring-data-service samwen2017/java-spring:latest sh

cd spring-data-service/client

mvn clean spring-boot:run

</pre>
