#!/bin/bash
sudo yum update -y

# Install NodeJs
echo "Installing NodeJS"
sudo yum install -y gcc-c++ make
curl -sL https://rpm.nodesource.com/setup_16.x | sudo -E bash -
sudo yum install -y nodejs

# Install Nginx
echo "Installing Nginx"
sudo yum update -y
sudo amazon-linux-extras install nginx1 -y

mv /etc/nginx/nginx.conf /etc/nginx/nginx.conf.backup

# Create ngnix config file
echo "Creating nginx config file with proxy pass"
echo "# events is required, but defaults are ok
events { }

# A http server, listening at port 80
http {
  server {
    listen 80;

    # Requests starting with root (/) are handled
    location / {
      # The following 3 lines are required for the hot loading to work (websocket).
      proxy_http_version 1.1;
      proxy_set_header Upgrade \$http_upgrade;
      proxy_set_header Connection 'upgrade';

      # Requests are directed to http://localhost:3000
      proxy_pass http://localhost:3000;
    }
  }
}" > /etc/nginx/nginx.conf

# Start Nginx
echo "Starting Nginx"
sudo systemctl enable nginx
sudo systemctl start nginx

# Install Git
echo "Installing Git"
sudo yum install git -y

cd /home/ec2-user

# Clone Website code
echo "Cloning website code"
su ec2-user -c "git clone https://github.com/monir-uz-zaman/aws_frontend.git"

# cd /home/ec2-user/aws_frontend/src/lib
# sed -i 's/localhost/${app-server-public-dns}/' getBaseRoute.js

cd /home/ec2-user/aws_frontend
# Create .env file
echo "Creating .env file for frontend"
echo "NEXT_PUBLIC_BACKEND_URL=http://${app-server-public-dns}:8080" > .env

cd /home/ec2-user/aws_frontend

# Install dependencies
echo "Installing node dependencies"
sudo npm i

# Running backend in dev mode
echo "Starting backend"
sudo npm run dev


# # Forward port 80 traffic to port 3000
# echo "Forwarding 80 -> 3000"
# iptables -t nat -A PREROUTING -p tcp --dport 80 -j REDIRECT --to-ports 3000


# # Install & use pm2 to run Node app in background
# echo "Installing & starting pm2"
# sudo npm install pm2@latest -g
# pm2 start app.js