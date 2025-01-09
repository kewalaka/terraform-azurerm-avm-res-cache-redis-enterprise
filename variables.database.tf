variable "databases" {
  type = map(object({
    # name                       = string # You can currently only create or update a single RedisEnterprise database which must be named 'default'
    access_keys_authentication = optional(string)
    client_protocol            = optional(string)
    clustering_policy          = optional(string)
    defer_upgrade              = optional(string)
    eviction_policy            = optional(string)
    port                       = optional(number)
    geo_replication = optional(object({
      group_nickname = optional(string)
      linked_databases = optional(list(object({
        id = string
      })))
    }))
    modules = optional(list(object({
      args = string
      name = string
    })))
    persistence = optional(object({
      aof_enabled   = optional(bool)
      aof_frequency = optional(string)
      rdb_enabled   = optional(bool)
      rdb_frequency = optional(string)
    }))
  }))
  description = <<DESCRIPTION
Map of Redis databases.

Each database object supports the following attributes:

- `access_keys_authentication` - Indicates whether access keys authentication is enabled.
- `client_protocol` - The client protocol to use.
- `clustering_policy` - The clustering policy for the database.
- `defer_upgrade` - Indicates whether to defer upgrades.
- `eviction_policy` - The eviction policy for the database.
- `port` - The port number for the database.

`geo_replication` block supports the following:
- `group_nickname` - The nickname for the geo-replication group.
- `linked_databases` - List of linked databases for geo-replication. Each object in the list supports:
  - `id` - The ID of the linked database.

`modules` block supports the following:
- `args` - The arguments for the module.
- `name` - The name of the module.

`persistence` block supports the following:
- `aof_enabled` - Indicates whether AOF persistence is enabled.
- `aof_frequency` - The frequency of AOF persistence.
- `rdb_enabled` - Indicates whether RDB persistence is enabled.
- `rdb_frequency` - The frequency of RDB persistence.
DESCRIPTION

  default  = {}
  nullable = false
}
