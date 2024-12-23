variable "access_keys_authentication" {
  type        = bool
  description = "Indicates whether access keys authentication is enabled."
}

variable "client_protocol" {
  type        = string
  description = "The client protocol to use."
}

variable "clustering_policy" {
  type        = string
  description = "The clustering policy for the database."
}

variable "defer_upgrade" {
  type        = bool
  description = "Indicates whether to defer upgrades."
}

variable "eviction_policy" {
  type        = string
  description = "The eviction policy for the database."
}

variable "name" {
  type        = string
  description = "The name of the Redis Enterprise database."

  validation {
    condition     = can(regex("^[A-Za-z0-9]{1,60}$", var.name))
    error_message = "The name must be between 1 and 60 characters and contain only alphanumeric characters."
  }
}

variable "port" {
  type        = number
  description = "The port number for the database."
}

variable "redis_cache" {
  type = object({
    resource_id = string
  })
  description = "The resource ID of the Redis Enterprise cache."
}

variable "geo_replication" {
  type = object({
    group_nickname = string
    linkedDatabases = list(object({
      id = string
    }))
  })
  default = {
    group_nickname  = ""
    linkedDatabases = []
  }
  description = "Configuration for geo-replication."
}

variable "modules" {
  type = list(object({
    args = string
    name = string
  }))
  default     = []
  description = "List of modules to be enabled in the database."
}

variable "persistence" {
  type = object({
    aof_enabled   = bool
    aof_frequency = string
    rdb_enabled   = bool
    rdb_frequency = string
  })
  default     = null
  description = "Persistence configuration for the database."
}

variable "timeouts" {
  type = object({
    create = string
    delete = string
    read   = string
  })
  default     = null
  description = "The timeouts for creating, reading, and deleting the storage resource."
}
