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

# Install mysql
echo "Installing MySql"
sudo amazon-linux-extras install epel -y
sudo yum install https://dev.mysql.com/get/mysql80-community-release-el7-5.noarch.rpm -y
sudo yum install mysql-community-server -y
sudo systemctl start mysqld

cd /home/ec2-user

# Create mysql conf file for easy access to mysql
echo "Creating mysql .my.cnf file"
echo "[mysql]
user=${db_user_name}
password=${db_user_password}
host=${db_host_name}" > .my.cnf

# Clone Backend and database code
echo "Cloning backend and database"
su ec2-user -c "git clone https://github.com/MahnoorFatima02/AWS-Project-Backend.git"
su ec2-user -c "git clone https://github.com/datacharmer/test_db.git"
mv AWS-Project-Backend aws_backend

cd /home/ec2-user/test_db
# Create employee sql
echo "Creating users.sql file"
echo "CREATE TABLE employees.users (
    emp_no     INT    NOT NULL,
    role       ENUM ('manager', 'staff', 'senior engineer', 'engineer', 'assistant engineer', 'technique leader') NOT NULL,
    password   VARCHAR(255)   NOT NULL,
    createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    deletedAt TIMESTAMP DEFAULT NULL,
    KEY         (emp_no),
    FOREIGN KEY (emp_no) REFERENCES employees (emp_no) ON DELETE CASCADE,
    PRIMARY KEY (emp_no)
);
INSERT INTO employees.users(emp_no, role, password) values(110183, 'manager', 'testpassword1');
INSERT INTO employees.users(emp_no, role, password) values(110022, 'manager', 'testpassword');
INSERT INTO employees.users(emp_no, role, password) values(10002, 'staff', 'testpassword1');
" > users.sql

# Load sql data
echo "Loading data to database"
sudo mysql --host="${db_host_name}" --user="${db_user_name}" --password="${db_user_password}" < employees.sql
sudo mysql --host="${db_host_name}" --user="${db_user_name}" --password="${db_user_password}" < test_employees_md5.sql
sudo mysql --host="${db_host_name}" --user="${db_user_name}" --password="${db_user_password}" < users.sql

cd /home/ec2-user/aws_backend

# Create env file for backend
echo "Creating .env file for backend"
echo "DB_USERNAME=${db_user_name}
DB_PASSWORD=${db_user_password}
DB_HOST=${db_host_name}
PORT=8080
JWT_KEY=$(openssl rand -base64 128)" > .env

# Install dependencies
echo "Installing node dependencies"
sudo npm i

# Running backend in dev mode
echo "Starting backend"
sudo npm run dev
