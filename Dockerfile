FROM ubuntu

RUN apt-get update && apt-get install -y \
    curl \
    golang \
    openssl \
    rsync \
    apt-transport-https \
    ca-certificates \
    sudo \
    git \
    mercurial

# Go setup
ENV GOPATH /go
ENV PATH $GOPATH/bin:/usr/local/go/bin:$PATH

RUN mkdir -p "$GOPATH/src/k8s.io/kubernetes" "$GOPATH/bin"
WORKDIR $GOPATH/src/k8s.io/kubernetes

RUN go get -u github.com/jteeuwen/go-bindata/go-bindata

# Docker setup
RUN apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D

RUN echo "deb https://apt.dockerproject.org/repo ubuntu-xenial main" | tee /etc/apt/sources.list.d/docker.list

RUN apt-get update && apt-get install -y \
    docker-engine

# etcd
# Kubernetes requires an etcd > v3.0.10 and Ubuntu only has 2.<something>
ENV ETCD_VER v3.0.13

RUN curl -L "https://github.com/coreos/etcd/releases/download/${ETCD_VER}/etcd-${ETCD_VER}-linux-amd64.tar.gz" -o "/tmp/etcd-${ETCD_VER}-linux-amd64.tar.gz"
RUN mkdir -p /tmp/etcd && tar xzvf "/tmp/etcd-${ETCD_VER}-linux-amd64.tar.gz" -C /tmp/etcd --strip-components=1
RUN mv /tmp/etcd/etcd /usr/local/bin/
