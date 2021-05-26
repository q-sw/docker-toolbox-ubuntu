FROM ubuntu:18.04

ARG TF_VERSION="0.14.5"
ARG HELM_VERSION="3.2.4"
ARG KUBECTL_VERSION="1.19.7"

RUN apt-get update \
    && apt-get install --fix-missing -y  ssh git curl wget zip tree groff python3-pip vim  groff less \
    &&  apt-get clean \ 
    && rm -rf /var/lib/apt/lists/*

RUN wget https://releases.hashicorp.com/terraform/${TF_VERSION}/terraform_${TF_VERSION}_linux_amd64.zip
RUN wget https://storage.googleapis.com/kubernetes-release/release/v${KUBECTL_VERSION}/bin/linux/amd64/kubectl
RUN wget https://get.helm.sh/helm-v${HELM_VERSION}-linux-amd64.tar.gz
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"

RUN unzip awscliv2.zip && ./aws/install

RUN unzip terraform_${TF_VERSION}_linux_amd64.zip -d /usr/local/bin/ \
    && chmod 755 /usr/local/bin/terraform \
    && rm -f terraform_${TF_VERSION}_linux_amd64.zip

RUN mv kubectl /usr/local/bin/kubectl \
    && chmod 755 /usr/local/bin/kubectl

RUN tar xvf helm-v${HELM_VERSION}-linux-amd64.tar.gz \
    && mv linux-amd64/helm /usr/local/bin/helm \
    && chmod 755 /usr/local/bin/helm \
    && rm -f helm-v${HELM_VERSION}-linux-amd64.tar.gz

COPY requirements.txt /root/requirements.txt
RUN pip3 install -r /root/requirements.txt

RUN ansible-galaxy collection install community.general
RUN ansible-galaxy collection install community.kubernetes

