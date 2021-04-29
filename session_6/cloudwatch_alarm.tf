# Scale in/out policies and cloudwatch scale_out/in alarms
# resource "aws_autoscaling_policy" "asg_scale_policy" {
#   for_each               = local.asg_scale_policy
#   name                   = each.value.name
#   scaling_adjustment     = each.value.scaling_adjustment
#   adjustment_type        = each.value.adjustment_type
#   cooldown               = each.value.cooldown
#   autoscaling_group_name = each.value.autoscaling_group_name
#   policy_type            = each.value.policy_type
# }

resource "aws_cloudwatch_metric_alarm" "cpu_util_alarm" {
  for_each            = local.cloudwatch_alarm
  alarm_name          = each.value.alarm_name
  comparison_operator = each.value.comparison_operator
  evaluation_periods  = each.value.evaluation_periods
  metric_name         = each.value.metric_name
  namespace           = each.value.namespace
  period              = each.value.period
  statistic           = each.value.statistic
  threshold           = each.value.threshold

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.web_asg.name
  }

  actions_enabled   = true
  alarm_description = each.value.alarm_description
  alarm_actions     = each.value.alarm_actions
}


resource "aws_autoscaling_policy" "asg_target_tracking_policy" {
  name = "${var.env}_scale_out_policy"
  policy_type = "TargetTrackingScaling"
  autoscaling_group_name = aws_autoscaling_group.web_asg.name
  estimated_instance_warmup = 200
  
  target_tracking_configuration {
  predefined_metric_specification {
  predefined_metric_type = "ASGAverageCPUUtilization"
  }
  
      target_value = "60"
  
  }
}

resource "aws_autoscaling_policy" "asg_target_tracking_policy" {
  name = "${var.env}_scale_in_policy"
  policy_type = "TargetTrackingScaling"
  autoscaling_group_name = aws_autoscaling_group.web_asg.name
  estimated_instance_warmup = 200
  
  target_tracking_configuration {
  predefined_metric_specification {
  predefined_metric_type = "ASGAverageCPUUtilization"
  }
  
      target_value = "40"
  
  }
}