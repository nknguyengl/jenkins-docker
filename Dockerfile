FROM jenkins/jenkins:lts

USER root

RUN apt-get update && \
    apt-get -y --no-install-recommends install \
        apt-transport-https \
        ca-certificates \
        curl \
        gnupg2 \
        software-properties-common

RUN curl -fsSL \
    https://download.docker.com/linux/$(. /etc/os-release; echo "$ID")/gpg > /tmp/dkey; apt-key add /tmp/dkey \
    "deb [arch=amd64] https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") \
    $(lsb_release -cs) stable"

RUN apt-get update && \
    apt-get -y --no-install-recommends install \
        docker-ce

RUN apt-get clean

RUN usermod -aG docker jenkins

RUN curl -L \
  "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" \
  -o /usr/local/bin/docker-compose

RUN chmod +x /usr/local/bin/docker-compose

USER jenkins
