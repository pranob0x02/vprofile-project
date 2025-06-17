resource "aws_db_subnet_group" "vprofile-rds-subnet-group" {
  name       = "vprofile-rds-subnet-group"
  subnet_ids = module.vpc.private_subnets

  tags = {
    Name = "vprofile-rds-subnet-group"
  }
}

resource "aws_db_instance" "vprofile-rds-instance" {
  allocated_storage      = 20
  storage_type           = "gp3"
  db_name                = var.db_name
  engine                 = "mysql"
  engine_version         = "8.0"
  instance_class         = "db.t4g.micro"
  username               = var.username
  password               = var.password
  parameter_group_name   = "default.mysql8.0"
  multi_az               = "false"
  publicly_accessible    = "false"
  skip_final_snapshot    = true
  db_subnet_group_name   = aws_db_subnet_group.vprofile-rds-subnet-group.name
  vpc_security_group_ids = [aws_security_group.vprofile-backend-sg.id]
}



###### aws_elastic subnet group #######
resource "aws_elasticache_subnet_group" "vprofile-ecache-subnet-group" {
  name       = "vprofile-ecache-subnet-group"
  subnet_ids = module.vpc.private_subnets

  tags = {
    Name = "vprofile-ecache-subnet-group"
  }
}

resource "aws_elasticache_cluster" "vprofile-ecache" {
  cluster_id           = "vprofile-ecache"
  engine               = "memcached"
  node_type            = "cache.t3.micro"
  engine_version       = "1.6.22"
  num_cache_nodes      = 1
  parameter_group_name = "default.memcached1.6"
  port                 = 11211
  security_group_ids   = [aws_security_group.vprofile-backend-sg.id]
  subnet_group_name    = aws_elasticache_subnet_group.vprofile-ecache-subnet-group.name
}



######## aws_mq_broker ########
resource "aws_mq_broker" "vprofile-rmq" {
  broker_name = "vprofile-rmq"

  engine_type                = "RabbitMQ"
  engine_version             = "3.13"
  host_instance_type         = "mq.t3.micro"
  auto_minor_version_upgrade = true
  security_groups            = [aws_security_group.vprofile-backend-sg.id]
  subnet_ids                 = [module.vpc.private_subnets[0]]

  user {
    username = var.rmqusername
    password = var.rmqpassword
  }
}
