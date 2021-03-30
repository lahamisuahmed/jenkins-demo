# Official jenkins image
FROM jenkins/jenkins:2.271-jdk11
# Swith to root to be able to install Docker and modify permissions
USER root
# Install docker
RUN curl -sSL https://get.docker.com/ | sh
# Add jenkins user to docker group
RUN usermod -aG docker jenkins
# Switch back to default user
USER jenkins
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt
COPY seedJob.xml /usr/share/jenkins/ref/jobs/seed-job/config.xml
ENV JAVA_OPTS -Djenkins.install.runSetupWizard=false