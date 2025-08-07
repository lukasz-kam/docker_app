
data "aws_route53_zone" "main" {
  name = var.domain_name
}

module "cloudfront" {
  source = "git@git.epam.com:lukasz_kaminski1/terraform-modules.git//modules/cloudfront?ref=v1.3.4"

  domain_name     = var.domain_name
  domain_prefix   = "ecs"
  alb_dns         = module.ecs_cluster.alb_dns_name
  route53_zone_id = data.aws_route53_zone.main.zone_id
}

resource "aws_lb_listener" "https" {
  load_balancer_arn = module.ecs_cluster.alb_arn
  port              = "443"
  protocol          = "HTTPS"
  certificate_arn   = module.cloudfront.alb_valdited_certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = module.ecs_cluster.alb_tg_arn
  }
}