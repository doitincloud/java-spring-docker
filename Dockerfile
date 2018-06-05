##
# Copyright 2017 the original author or authors.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# History:
#   created by Sam Wen @ 08/17/2017
##
FROM frolvlad/alpine-oraclejdk8:slim

RUN apk update 
RUN apk upgrade

# common tool sets
#
RUN apk add --no-cache bash wget curl jq git mysql-client openssh-client git tree

# Add maven 3.5.0
ADD http://ftp.wayne.edu/apache/maven/maven-3/3.5.0/binaries/apache-maven-3.5.0-bin.tar.gz /opt
ENV MAVEN_HOME /opt/apache-maven-3.5.0
ENV PATH $MAVEN_HOME/bin:$PATH

# run with -v /tmp/local-repo:/tmp/local-repo to save maven downloads
RUN sed -i '$ i\  <localRepository>/tmp/local-repo<\/localRepository>\n' /opt/apache-maven-3.5.0/conf/settings.xml

RUN rm -rf /var/cache/apk/*

WORKDIR /workspace

EXPOSE 8080
