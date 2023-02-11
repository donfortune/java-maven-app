 #!/bin/bash
sudo yum update -y  && sudo yum install -y docker
sudo systemctl start docker
sudo usermod -aG docker ec2-user

#installing docker compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.28.5/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

docker run -p 8080:80 nginx