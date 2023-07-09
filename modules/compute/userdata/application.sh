#!/bin/bash
sudo yum update -y

# Install NodeJS
echo "Installing NodeJS"
sudo yum install -y gcc-c++ make
curl -sL https://rpm.nodesource.com/setup_16.x | sudo -E bash -
sudo yum install -y nodejs

# Install Apache
echo "Installing Apache"
sudo yum -y install httpd
systemctl enable httpd
systemctl start httpd
echo "<html><h1>Ma hu Sandesh Hyoju! $(hostname -f)</h1></html>" > /var/www/html/index.html

# Install Git
echo "Installing Git"
sudo yum install git -y


# Install PostgreSQL repository RPM
sudo amazon-linux-extras enable postgresql14

# Install PostgreSQL server and client
sudo yum install -y postgresql-server

# Initialize the PostgreSQL database
sudo postgresql-setup initdb

# Start and enable PostgreSQL service
sudo systemctl start postgresql
sudo systemctl enable postgresql

echo "PostgreSQL 14 installation completed successfully."

cd /home/ec2-user

echo "${db_host_name}:5432:*:${db_user_name}:${db_user_password}" > .pgpass
chmod 0600 .pgpass

# Clone Backend
echo "Cloning backend"
su ec2-user -c "git clone https://github.com/sundesz/blogpost-backend"
mv blogpost-backend blogpost_backend

cd /home/ec2-user/blogpost_backend

# Create env file for backend
echo "Creating .env file for backend"
echo "
DB_NAME_DEVELOPMENT=${db_name}
DB_USER_DEVELOPMENT=${db_user_name}
DB_PASSWORD_DEVELOPMENT=${db_user_password}
DB_HOST_DEVELOPMENT=${db_host_name}

SERVER_HOST=${app_server_dns}

SALT=12
PORT=8080
SECRET_KEY=$(openssl rand -base64 128)" > .env

# Install dependencies
echo "Installing node dependencies"
sudo npm i

# Running backend in dev mode
echo "Starting backend"
sudo npm run dev
