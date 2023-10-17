locals {
  nodes = keys(var.node_groups)
}



resource "azurerm_monitor_metric_alert" "alert_aks-node-cpu-percentage" {
  name                = "AKS_Node_CPU_Percentage-${var.Purpose}"
  resource_group_name = ["************"]
  scopes              = ["************"]
  description         = "${var.AKSClusterName} Node CPU Percentage"

  
  criteria {
    metric_namespace = "Insights.Container/nodes"
    metric_name      = "cpuUsagePercentage"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = "80"

    dynamic "dimension" {
    for_each = [local.nodes[criteria.key]]
    content {
        name     = "Name of Node"
        operator = "Include"
        values   = dimension.key
    }
    }
  }
   
  action {
    action_group_id = ["************"]
  }
 
}



resource "azurerm_monitor_metric_alert" "node-memory-percentage" {
  name                = "AKS_Node_Memory_Percentage"
  resource_group_name = ["************"]
  scopes              = ["************"]
  description         = "${var.AKSClusterName} Node Memory Percentage"

 
  criteria {
    metric_namespace = "Insights.Container/nodes"
    metric_name      = "memoryWorkingSetPercentage"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = "80"
 
    dynamic "dimension" {
    for_each = [local.nodes[criteria.key]]
    content {
        name     = "Name of Node"
        operator = "Include"
        values   = dimension.key
    }
    }
  }
   
  action {
    action_group_id = ["************"]
  }
 
}
resource "azurerm_monitor_metric_alert" "node-disk-percentage" {
  name                = "AKS_Node_Memory_Percentage"
  resource_group_name = ["************"]
  scopes              = ["************"]
  description         = "${var.AKSClusterName} Node Disk Percentage"

 
  criteria {
    metric_namespace = "Insights.Container/nodes"
    metric_name      = "DiskUsedPercentage"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = "80"
 
    dynamic "dimension" {
    for_each = [local.nodes[criteria.key]]
    content {
        name     = "Name of Node"
        operator = "Include"
        values   = dimension.key
    }
    }
  }
   
  action {
    action_group_id = ["************"]
  }

}
