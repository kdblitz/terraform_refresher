resource "aws_db_instance" "db_server" {
  identifier_prefix   = "simple-server"
  engine              = "mysql"
  allocated_storage   = 10
  instance_class      = "db.t2.micro"
  name                = "${var.cluster_name}_server_db"
  username            = var.db_username
  password            = var.db_password
  skip_final_snapshot = true
}