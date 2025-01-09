module "database" {
  source   = "./modules/database"
  for_each = var.databases

  redis_cache = { resource_id = azapi_resource.redis_enterprise.id }

  access_keys_authentication = try(each.value.access_keys_authentication, null)
  client_protocol            = try(each.value.client_protocol, null)
  clustering_policy          = try(each.value.clustering_policy, null)
  defer_upgrade              = try(each.value.defer_upgrade, null)
  eviction_policy            = try(each.value.eviction_policy, null)
  port                       = try(each.value.port, null)
  geo_replication            = try(each.value.geo_replication, null)
  modules                    = try(each.value.modules, null)
  persistence                = try(each.value.persistence, null)

  timeouts = try(each.value.timeouts, null)
}
