FROM alpine:latest
RUN apk update && \
    apk add git && \
    apk add curl	
# install kubectl
RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" && \
	install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
