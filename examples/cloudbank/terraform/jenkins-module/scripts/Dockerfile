FROM jenkins/jenkins:lts-jdk11

# if we want to install via apt
USER root

# install sudo and curl and setup apt for https sources as well as kubernetes dependencies
RUN apt-get update && apt-get install -qq -y sudo apt-transport-https ca-certificates curl


#install docker
RUN apt-get update && apt-get install -qq -y docker.io

# install git
RUN apt-get update && apt-get install -qq -y git

# setup repository for kubectl install
RUN curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg && \
echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list

# install kubectl
RUN sudo apt-get update && sudo apt-get install -y kubectl

# install plugins
RUN jenkins-plugin-cli --plugins blueocean docker-workflow matrix-auth git workflow-aggregator credentials-binding configuration-as-code kubernetes-cli generic-webhook-trigger multibranch-scan-webhook-trigger

USER jenkins