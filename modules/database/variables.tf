variable "name" {
  type        = string
  description = "The name of the Redis Enterprise database."

  validation {
    condition     = can(regex("^[A-Za-z0-9]{1,60}$", var.name))
    error_message = "The name must be between 1 and 60 characters and contain only alphanumeric characters."
  }
}

variable "redis_cache" {
  type = object({
    resource_id = string
  })
  description = "The resource ID of the Redis Enterprise cache."
}

variable "access_keys_authentication" {
  type        = bool
  default     = false
  description = "Indicates whether access keys authentication is enabled."
  nullable    = false
}

variable "client_protocol" {
  type        = string
  default     = "Encrypted"
  description = "The client protocol to use."
  nullable    = false

  validation {
    condition     = can(regex("^(Encrypted|Plaintext)$", var.client_protocol))
    error_message = "The client protocol must be either 'Encrypted' or 'Plaintext'."
  }
}

variable "clustering_policy" {
  type        = string
  default     = "OSSCluster"
  description = "The clustering policy for the database."
  nullable    = false

  validation {
    condition     = can(regex("^(OSSCluster|EnterpriseCluster)$", var.clustering_policy))
    error_message = "The clustering policy must be either 'OSSCluster' or 'EnterpriseCluster'."
  }
}

variable "defer_upgrade" {
  type        = bool
  default     = false
  description = "Indicates whether to defer upgrades."
  nullable    = false
}

variable "eviction_policy" {
  type        = string
  default     = "VolatileLRU"
  description = "The eviction policy for the database."
  nullable    = false

  validation {
    condition     = can(regex("^(AllKeysLFU|AllKeysLRU|AllKeysRandom|NoEviction|VolatileLFU|VolatileLRU|VolatileRandom|VolatileTTL)$", var.eviction_policy))
    error_message = "The eviction policy must be one of 'AllKeysLFU', 'AllKeysLRU', 'AllKeysRandom', 'NoEviction', 'VolatileLFU', 'VolatileLRU', 'VolatileRandom', or 'VolatileTTL'."
  }
}

variable "geo_replication" {
  type = object({
    group_nickname = optional(string)
    linkedDatabases = optional(list(object({
      id = string
    })))
  })
  default     = {}
  description = "Configuration for geo-replication."
  nullable    = false
}

variable "modules" {
  type = list(object({
    args = string
    name = string
  }))
  default     = []
  description = "List of modules to be enabled in the database."
  nullable    = false
}

variable "persistence" {
  type = object({
    aof_enabled   = bool
    aof_frequency = optional(string)
    rdb_enabled   = bool
    rdb_frequency = optional(string)
  })
  default = {
    aof_enabled   = false
    aof_frequency = null
    rdb_enabled   = false
    rdb_frequency = null
  }
  description = "Persistence configuration for the database."
  nullable    = false
}

variable "port" {
  type        = number
  default     = null
  description = "The port number for the database.  Defaults to an available port."
}

variable "timeouts" {
  type = object({
    create = optional(string)
    delete = optional(string)
    read   = optional(string)
    update = optional(string)
  })
  default     = null
  description = "The timeouts for creating, reading, updating, and deleting the database resource."
}
