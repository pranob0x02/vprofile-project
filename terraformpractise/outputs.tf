output "RDS_endpoint" {
  value = aws_db_instance.vprofile-rds-instance.endpoint

}

output "memcache_endpoint" {
  value = aws_elasticache_cluster.vprofile-ecache.configuration_endpoint
}

output "bastion_host_public_ip" {
  value = aws_instance.bastion_host.public_ip

}

output "rabbitmq_endpoint" {
  value = aws_mq_broker.vprofile-rmq.instances.0.endpoints

}
