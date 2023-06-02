#!/bin/bash
sudo yum install -y gcc-c++ make
curl -sL https://rpm.nodesource.com/setup_16.x | sudo -E bash -
sudo yum install -y nodejs

sudo yum install git -y
git clone https://github.com/datacharmer/test_db.git

yum -y install httpd
systemctl enable httpd
systemctl start httpd
echo '<html><h1>Ma hu Sandesh Hyoju from $(hostname -f)!</h1></html>' > /var/www/html/index.html


sudo amazon-linux-extras install epel -y
sudo yum install https://dev.mysql.com/get/mysql80-community-release-el7-5.noarch.rpm -y
sudo yum install mysql-community-server -y

sudo systemctl start mysqld
