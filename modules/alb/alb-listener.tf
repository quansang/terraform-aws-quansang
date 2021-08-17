resource "aws_lb_listener" "alb_listener" {
  for_each = { for value in var.alb_listener : value.port => value }

  load_balancer_arn = aws_lb.alb.arn
  port              = each.value.port
  protocol          = each.value.protocol
  ssl_policy        = try(each.value.ssl_policy, null)
  certificate_arn   = try(each.value.certificate_arn, null)

  dynamic "default_action" {
    for_each = each.value.type == "redirect" ? [1] : []
    content {
      type = "redirect"
      redirect {
        port        = "443"
        protocol    = "HTTPS"
        status_code = "HTTP_301"
      }
    }
  }

  dynamic "default_action" {
    for_each = each.value.type == "forward" ? [1] : []
    content {
      type             = "forward"
      target_group_arn = aws_lb_target_group.alb_target_group.arn
    }
  }

  dynamic "default_action" {
    for_each = each.value.type == "fixed-response" ? [1] : []
    content {
      type = "fixed-response"
      fixed_response {
        content_type = each.value.fixed_response_content_type
        status_code  = each.value.fixed_response_status_code
        message_body = try(each.value.fixed_response_message_body_template, null) != null ? data.template_file.fixed_response_message_body[each.value.port].rendered : try(each.value.fixed_response_message_body, null)
      }
    }
  }

  lifecycle {
    create_before_destroy = false
  }
}

data "template_file" "fixed_response_message_body" {
  for_each = { for value in var.alb_listener : value.port => value }
  template = try(each.value.fixed_response_message_body_template, null)
  vars     = try(each.value.fixed_response_message_body_vars, null)
}
