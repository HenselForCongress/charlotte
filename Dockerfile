# Dockerfile
FROM ghost:latest

# Install wget and other necessary utilities
RUN apt-get update && apt-get install -y wget tar

RUN cd /var/lib/ghost/content/ && \
    mkdir -p logs/ && \
    mkdir -p apps/ && \
    mkdir -p images/ && \
    mkdir -p adapters/ && \
    mkdir -p themes/ && \
    mkdir -p media/ && \
    cd .

COPY ghost-vote.zip /var/lib/ghost/content/themes/



# Install Dockerize
ENV DOCKERIZE_VERSION v0.6.1
RUN wget https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && tar -C /usr/local/bin -xzvf dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && rm dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz

# Install the Ghost storage adapter for S3
RUN npm install ghost-storage-adapter-s3
RUN mkdir -p ./content/adapters/storage
RUN cp -r ./node_modules/ghost-storage-adapter-s3 ./content/adapters/storage/s3
