#!/bin/sh
docker run -v /var/run/docker.sock:/var/run/docker.sock -v $GOPATH/src/k8s.io/kubernetes:/go/src/k8s.io/kubernetes --name k8s-dev --rm -it alex-charlton/k8s-dev /bin/bash
