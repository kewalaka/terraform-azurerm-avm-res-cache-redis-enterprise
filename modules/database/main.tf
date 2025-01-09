resource "azapi_resource" "database" {
  type = "Microsoft.Cache/redisEnterprise/databases@2024-09-01-preview"
  body = {
    properties = {
      accessKeysAuthentication = var.access_keys_authentication ? "Enabled" : "Disabled"
      clientProtocol           = var.client_protocol
      clusteringPolicy         = var.clustering_policy
      deferUpgrade             = var.defer_upgrade ? "Deferred" : "NotDeferred"
      evictionPolicy           = var.eviction_policy
      port                     = var.port
      geoReplication = var.geo_replication != null ? {
        groupNickname = var.geo_replication.group_nickname
        linkedDatabases = var.geo_replication.linkedDatabases != null ? [
          for linkedDatabase in var.geo_replication.linkedDatabases : {
            id = linkedDatabase.id
          }
        ] : []
      } : null
      modules = var.modules != null ? [
        for module in var.modules : {
          args = module.args
          name = module.name
        }
      ] : []
      persistence = var.persistence != null ? {
        aofEnabled   = var.persistence.aof_enabled
        aofFrequency = var.persistence.aof_frequency
        rdbEnabled   = var.persistence.rdb_enabled
        rdbFrequency = var.persistence.rdb_frequency
      } : null
    }
  }
  name                   = "Default"
  parent_id              = var.redis_cache.resource_id
  response_export_values = ["*"]

  dynamic "timeouts" {
    for_each = var.timeouts == null ? [] : [var.timeouts]

    content {
      create = timeouts.value.create
      delete = timeouts.value.delete
      read   = timeouts.value.read
      update = timeouts.value.update
    }
  }
}
