
# Create a launch template for WEB server
resource "aws_launch_template" "webserver_lt" {
  name_prefix            = "web-LT"
  description            = "Web Tier"
  image_id               = data.aws_ami.amazon_linux_2.id
  key_name               = aws_key_pair.key_pair.key_name
  instance_type          = var.settings.web_server.instance_type
  vpc_security_group_ids = [var.web_sg]

  user_data = base64encode(templatefile("${path.module}/userdata/web.sh", {
    app_server_dns  = var.app_alb_dns,
    app_server_port = var.app_server_port
  }))

  tags = {
    Name        = var.settings.web_server.name
    Environment = "dev"
  }

  depends_on = [
    var.app_alb
  ]
}





# Create a launch template for APPLICATION server
resource "aws_launch_template" "appserver_lt" {
  name_prefix            = "app-LT"
  description            = "App Tier"
  image_id               = data.aws_ami.amazon_linux_2.id
  key_name               = aws_key_pair.key_pair.key_name
  instance_type          = var.settings.app_server.instance_type
  vpc_security_group_ids = [var.app_sg]
  user_data = base64encode(templatefile("${path.module}/userdata/application.sh", {
    db_host_name     = var.dbEndpoint,
    db_name          = var.settings.database_instance.db_name,
    db_user_name     = var.settings.database_instance.username,
    db_user_password = var.settings.database_instance.password,
    app_server_dns   = var.app_alb_dns,

  }))

  tags = {
    Name        = var.settings.app_server.name
    Environment = "dev"
  }

  depends_on = [
    var.db_instance
  ]
}
