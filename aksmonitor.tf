resource "azurerm_monitor_action_group" "main" {
  name                = "test-ahmemo07-aks"
  resource_group_name = "app-block-prod-eastus"
  short_name          = "test-ahmed"
  email_receiver {
    name          = "send to ahmed"
    email_address = "mohammed.ahmed1@lexisnexisrisk.com"

  }
}

locals {
  nodes = keys(var.node_groups)
}



resource "azurerm_monitor_metric_alert" "alert_aks-node-cpu-percentage" {
  name                = "AKS_Node_CPU_Percentage"
  resource_group_name = "app-block-prod-eastus"
  scopes              = [module.aks_cluster.cluster_id]
  description         = "${var.cluster_name} Node CPU Percentage"


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
    action_group_id = azurerm_monitor_action_group.main.id
  }

}



resource "azurerm_monitor_metric_alert" "node-memory-percentage" {
  name                = "AKS_Node_Memory_Percentage"
  resource_group_name = "app-block-prod-eastus"
  scopes              = [module.aks_cluster.cluster_id]
  description         = "${var.cluster_name} Node Memory Percentage"


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
    action_group_id = azurerm_monitor_action_group.main.id
  }

}
resource "azurerm_monitor_metric_alert" "node-disk-percentage" {
  name                = "AKS_Node_Disk_Percentage"
  resource_group_name = "app-block-prod-eastus"
  scopes              = [module.aks_cluster.cluster_id]
  description         = "${var.cluster_name} Node Disk Percentage"


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
    action_group_id = azurerm_monitor_action_group.main.id
  }

}
