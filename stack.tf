# # stack.tf

resource "spacelift_stack" "database" {
    count = contains(local.config.component, "database") ? 1 : 0
    space_id           = try(local.config.stack.database.space_id, "root")
    administrative     = try(local.config.stack.database.administrative, false)
    autodeploy         = try(local.config.stack.database.autodeploy, true)
    branch             = try(local.config.stack.database.branch, try(local.config.global.branch, "main"))
    description        = try(local.config.stack.database.description, "Database infrastructure")
    name               = try(local.config.stack.database.name, "database_infra")
    repository         = try(local.config.stack.database.repository, "database")
    project_root       = try(local.config.stack.database.project_root, "infra")
    terraform_version  = try(local.config.stack.database.terraform_version, try(local.config.global.terraform.version, "1.5.7"))
    labels          = try(concat(local.config.stack.database.labels, ["all", "infra", "database"]), ["all", "infra", "database"])
    github_enterprise { 
        namespace = try(local.config.stack.database.github_enterprise.namespace, "nodadyoushutup-terraform")
    }
}

resource "spacelift_context_attachment" "config_database" {
  count = contains(local.config.component, "database") ? 1 : 0
  context_id = "config"
  stack_id   = "database_infra"
  priority   = 100
}