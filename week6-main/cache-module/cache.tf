resource "aws_elasticache_subnet_group" "redis_priv_sub_group" {
  name       = "redis-subnet-group-PRIV-SUB"
  subnet_ids = [var.priv_sub1, var.priv_sub2]
}

resource "aws_elasticache_cluster" "redis_priv" {
  cluster_id           = "ms-cleaning-redis-priv-sub"
  engine               = "redis"
  node_type            = "cache.t3.micro" 
  num_cache_nodes      = 1
  parameter_group_name = "default.redis7"
  subnet_group_name = aws_elasticache_subnet_group.redis_priv_sub_group.name

}