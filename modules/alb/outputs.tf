#modules/alb/outputs.tf
#alb
output "alb_dns_name" {
  value = aws_lb.alb.dns_name
}
output "alb_zone_id" {
  value = aws_lb.alb.zone_id
}
output "alb_arn" {
  value = aws_lb.alb.arn
}
output "alb_arn_suffix" {
  value = aws_lb.alb.arn_suffix
}

#target_group
output "alb_target_group_arn" {
  value = aws_lb_target_group.alb_target_group.arn
}
output "alb_target_group_arn_suffix" {
  value = aws_lb_target_group.alb_target_group.arn_suffix
}
output "alb_target_group_name" {
  value = aws_lb_target_group.alb_target_group.name
}

#alb-listener
output "alb_listener_arn" {
  value = { for key, value in aws_lb_listener.alb_listener : key => value.arn }
}
