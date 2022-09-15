#First we have to define the private subnet group
resource "aws_db_subnet_group" "mariadb_subnet"{
    name="mariadb_subnet"
    description="Amazone RDS subnet group"
    subnet_ids = [aws_subnet.koria-vpc-private-subnet-1.id, aws_subnet.koria-vpc-private-subnet-2.id]
}
 
 #RDS parameters

 resource "aws_db_parameter_group" "mariadb-parameter-group"{
    name = "mariadb-parameter-group"
    family = "mariadb10.6"
    description = "Mariadb parameters"
    parameter{
        name = "max_allowed_packet"
        value = "16777217"
    }
 }

 resource "aws_db_instance" "koria_mariadb" {
  allocated_storage    = 20
  engine               = "mariadb"
  engine_version       = "10.6.8"
  instance_class       = "db.t2.micro" //for the use of the free tier
  db_name                 = "kmaridb"
  identifier           = "kmaridb"
  username             = "root"
  password             = "root1234"
  parameter_group_name = aws_db_parameter_group.mariadb-parameter-group.name
  db_subnet_group_name = aws_db_subnet_group.mariadb_subnet.name
  multi_az                = "false"
  vpc_security_group_ids = [aws_security_group.allow_mariadb.id]
  storage_type = "gp2"
  backup_retention_period = 30
  skip_final_snapshot  = true
  tags={
    name = "koria_mariadb"
  }
}

output "rds" {
    value = aws_db_instance.koria_mariadb.endpoint
}