FROM kasured/centos-oraclejdk-sbt
MAINTAINER Evgeny Rusak "kasured@exadel.com"

RUN mkdir /root/.ssh

#ssh-keygen -q -t rsa -N '' -f akka-cluster-ro -C 'akka-cluster-ro'
ADD ssh/keys /root/.ssh

ADD ssh/config /root/.ssh/

RUN chmod -vR 600 /root/.ssh/*

RUN ssh-keyscan -T 60 bitbucket.org > /root/.ssh/known_hosts

RUN git clone git@bitbucket.org:kasur/akka-cluster.git /opt/akka-cluster

WORKDIR /opt/akka-cluster

RUN sbt stage

ENV APP_PORT=8888

CMD ["./target/universal/stage/bin/akka-cluster"]
