resource "aws_lb_listener_rule" "alb_listener_rule" {
  for_each = var.alb_listener_rule

  listener_arn = each.value.listener_arn
  priority     = each.value.priority

  dynamic "condition" {
    for_each = try(each.value.condition_host_header, null) != null ? [1] : []
    content {
      host_header {
        values = each.value.condition_host_header
      }
    }
  }
  dynamic "condition" {
    for_each = try(each.value.condition_source_ip, null) != null ? [1] : []
    content {
      source_ip {
        values = each.value.condition_source_ip
      }
    }
  }
  dynamic "condition" {
    for_each = try(each.value.condition_path_pattern, null) != null ? [1] : []
    content {
      path_pattern {
        values = each.value.condition_path_pattern
      }
    }
  }
  dynamic "condition" {
    for_each = try(each.value.condition_http_request_method, null) != null ? [1] : []
    content {
      http_request_method {
        values = each.value.condition_http_request_method
      }
    }
  }

  action {
    type = each.value.action_type
    #action_type = "forward"
    target_group_arn = try(each.value.action_target_group_arn, null)
    #action_type = "fixed-response"
    dynamic "fixed_response" {
      for_each = each.value.action_type == "fixed-response" ? [1] : []
      content {
        content_type = each.value.action_fixed_response_content_type
        status_code  = each.value.action_fixed_response_status_code
        message_body = try(each.value.action_fixed_response_message_body_template, null) != null ? data.template_file.action_fixed_response_message_body[each.key].rendered : try(each.value.action_fixed_response_message_body, null)
      }
    }
  }

  lifecycle {
    create_before_destroy = false
  }
}

data "template_file" "action_fixed_response_message_body" {
  for_each = var.alb_listener_rule
  template = try(each.value.action_fixed_response_message_body_template, null)
  vars     = try(each.value.action_fixed_response_message_body_vars, null)
}
