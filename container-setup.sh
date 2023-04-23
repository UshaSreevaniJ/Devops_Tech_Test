#!/bin/bash 

yum update
yum install docker -y
sudo systemctl restart docker && sudo systemctl enable docker
curl -L https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
cat <<EOF >/home/ec2-user/docker-compose.yml
version: '3.8'
services:
  cadvisor:
    image: gcr.io/cadvisor/cadvisor:latest
    container_name: cadvisor
    ports:
    - 8080:8080
    volumes:
    - /:/rootfs:ro
    - /var/run:/var/run:rw
    - /sys:/sys:ro
    - /var/lib/docker/:/var/lib/docker:ro
  prometheus:
    image: prom/prometheus:latest
    container_name: prometheus
    ports:
    - 9090:9090
    command:
    - --config.file=/etc/prometheus/prometheus.yml
    volumes:
    - ./prometheus.yml:/etc/prometheus/prometheus.yml
    depends_on:
    - cadvisor
  grafana:
    image: grafana/grafana
    container_name: grafana
    ports:
    - 3000:3000
  porttutorial:
    image: chuckwired/port-tutorial
    entrypoint: ['/usr/bin/nodejs','/home/hello-world/app.js']
    deploy: 
      mode: replicated
      replicas: 3
    ports:
      - 3000
EOF
chown ec2-user:ec2-user /home/ec2-user/docker-compose.yml
sudo /usr/local/bin/docker-compose -f /home/ec2-user/docker-compose.yml up -d
