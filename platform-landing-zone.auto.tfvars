/*
--- Built-in Replacements ---
This file contains built-in replacements to avoid repeating the same hard-coded values.
Replacements are denoted by the dollar-dollar curly braces token (e.g. $${starter_location_01}). The following details each built-in replacements that you can use:
`starter_location_01`: This is the primary Azure location sourced from the `starter_locations` variable. This can be used to set the location of resources.
`starter_location_02` to `starter_location_##`: These are the secondary Azure locations sourced from the `starter_locations` variable. This can be used to set the location of resources.
`starter_location_01_short`: Short code for the primary Azure location. Defaults to the region geo_code, or short_name if no geo_code is available. Can be overridden via the starter_locations_short variable.
`starter_location_02_short` to `starter_location_##_short`: Short codes for the secondary Azure locations. Same behavior and override rules as starter_location_01_short.
`root_parent_management_group_id`: This is the id of the management group that the ALZ hierarchy will be nested under.
`subscription_id_identity`: The subscription ID of the subscription to deploy the identity resources to, sourced from the variable `subscription_ids`.
`subscription_id_connectivity`: The subscription ID of the subscription to deploy the connectivity resources to, sourced from the variable `subscription_ids`.
`subscription_id_management`: The subscription ID of the subscription to deploy the management resources to, sourced from the variable `subscription_ids`.
`subscription_id_security`: The subscription ID of the subscription to deploy the security resources to, sourced from the variable `subscription_ids`.
*/

/*
*--- Starter Locations ---
You can define the Azure regions to use throughout the configuration.
The first location will be used as the primary location, the second as the secondary location, and so on.
*/
starter_locations = ["eastus"]

/*
*--- Custom Replacements ---
You can define custom replacements to use throughout the configuration.
*/
custom_replacements = {
  /*
  --- Custom Name Replacements ---
  You can define custom names and other strings to use throughout the configuration.
  You can only use the built in replacements in this section.
  NOTE: You cannot refer to another custom name in this variable.
  */
  names = {
    # *Defender email security contact
    defender_email_security_contact = "replace_me@replace_me.com"

    # *Resource provisioning global connectivity
    ddos_protection_plan_enabled = false # TODO 03 desabilitar

    # *Resource provisioning primary connectivity
    primary_firewall_enabled                                             = false  # TODO 14 No Firewall
    primary_firewall_sku_tier                                            = "Premium"   # TODO 14 No Firewall - ignorado pelo acelerador
    primary_firewall_management_ip_enabled                               = true      # TODO 14 No Firewall - ignorado pelo acelerador
    # TODO 14 No Firewall - o acelerador NÃO faz deploy do Firewall, Firewall Policy, Public IPs, Subnets e Route Tables associados
    primary_virtual_network_gateway_express_route_enabled                = false # TODO 06 No ExR GW
    primary_virtual_network_gateway_express_route_hobo_public_ip_enabled = false # TODO 06 No ExR GW
    primary_virtual_network_gateway_vpn_enabled                          = true
    primary_private_dns_zones_enabled                                    = true
    primary_private_dns_auto_registration_zone_enabled                   = true
    primary_private_dns_resolver_enabled                                 = false # TODO no DNS resolver
    primary_bastion_enabled                                              = true # TODO 04 no Bastion

    # *Resource group names
    management_resource_group_name               = "rg-management-$${starter_location_01}"
    connectivity_hub_primary_resource_group_name = "rg-hub-$${starter_location_01}"
    dns_resource_group_name                      = "rg-hub-dns-$${starter_location_01}"
    ddos_resource_group_name                     = "rg-hub-ddos-$${starter_location_01}" # TODO 03 desabilitar
    asc_export_resource_group_name               = "rg-asc-export-$${starter_location_01}"
    service_health_alerts_resource_group_name    = "rg-service-health-alerts-$${starter_location_01}"

    # Resource names management
    log_analytics_workspace_name            = "law-management-$${starter_location_01}"
    ddos_protection_plan_name               = "ddos-$${starter_location_01}"
    ama_user_assigned_managed_identity_name = "uami-management-ama-$${starter_location_01}"
    dcr_change_tracking_name                = "dcr-change-tracking"
    dcr_defender_sql_name                   = "dcr-defender-sql"
    dcr_vm_insights_name                    = "dcr-vm-insights"

    # *Resource names primary connectivity
    primary_virtual_network_name                                 = "vnet-hub-$${starter_location_01}"
    primary_firewall_name                                        = "fw-hub-$${starter_location_01}"           # TODO 14 No Firewall - ignorado pelo acelerador
    primary_firewall_policy_name                                 = "fwp-hub-$${starter_location_01}"          # TODO 14 No Firewall - ignorado pelo acelerador
    primary_firewall_public_ip_name                              = "pip-fw-hub-$${starter_location_01}"       # TODO 14 No Firewall - ignorado pelo acelerador
    primary_firewall_management_public_ip_name                   = "pip-fw-hub-mgmt-$${starter_location_01}" # TODO 14 No Firewall - ignorado pelo acelerador
    primary_route_table_firewall_name                            = "rt-hub-fw-$${starter_location_01}"        # TODO 14 No Firewall - ignorado pelo acelerador
    primary_route_table_user_subnets_name                        = "rt-hub-std-$${starter_location_01}"       # TODO 14 No Firewall - ignorado pelo acelerador
    primary_virtual_network_gateway_express_route_name           = "vgw-hub-er-$${starter_location_01}" # TODO 06 No ExR GW
    primary_virtual_network_gateway_express_route_public_ip_name = "pip-vgw-hub-er-$${starter_location_01}" # TODO 06 No ExR GW
    primary_virtual_network_gateway_vpn_name                     = "vgw-hub-vpn-$${starter_location_01}"
    primary_virtual_network_gateway_vpn_public_ip_name_1         = "pip-vgw-hub-vpn-$${starter_location_01}-001"
    primary_virtual_network_gateway_vpn_public_ip_name_2         = "pip-vgw-hub-vpn-$${starter_location_01}-002" 
    primary_private_dns_resolver_name                            = "pdr-hub-dns-$${starter_location_01}" # TODO no DNS resolver
    primary_bastion_host_name                                    = "bas-hub-$${starter_location_01}" # TODO 04 no Bastion
    primary_bastion_host_public_ip_name                          = "pip-bastion-hub-$${starter_location_01}" # TODO 04 no Bastion

    # *Private DNS Zones primary
    primary_auto_registration_zone_name = "$${starter_location_01}.azure.local"

    # *IP Ranges Primary
    # *Regional Address Space: 10.0.0.0/16
    primary_hub_address_space                          = "10.0.0.0/16"
    primary_hub_virtual_network_address_space          = "10.0.0.0/22"
    primary_firewall_subnet_address_prefix             = "10.0.0.0/26"   # TODO 14 No Firewall - ignorado pelo acelerador
    primary_firewall_management_subnet_address_prefix  = "10.0.0.192/26" # TODO 14 No Firewall - ignorado pelo acelerador
    primary_bastion_subnet_address_prefix              = "10.0.0.64/26" # TODO 04 no Bastion
    primary_gateway_subnet_address_prefix              = "10.0.0.128/27"
    primary_private_dns_resolver_subnet_address_prefix = "10.0.0.160/28" # TODO no DNS resolver
  }

  /*
  *--- Substituições de Identificadores de Resource Groups ---
  Pode definir identificadores de resource groups personalizados para usar em toda a configuração.
  Só pode usar as variáveis de template e nomes personalizados nesta secção.
  NOTA: Não pode referir outro identificador de resource group nesta variável.
  */
  resource_group_identifiers = {
    management_resource_group_id           = "/subscriptions/$${subscription_id_management}/resourcegroups/$${management_resource_group_name}"
    ddos_protection_plan_resource_group_id = "/subscriptions/$${subscription_id_connectivity}/resourcegroups/$${ddos_resource_group_name}"
    primary_connectivity_resource_group_id = "/subscriptions/$${subscription_id_connectivity}/resourceGroups/$${connectivity_hub_primary_resource_group_name}"
    dns_resource_group_id                  = "/subscriptions/$${subscription_id_connectivity}/resourceGroups/$${dns_resource_group_name}"
  }

  /*
 * --- Substituições de Identificadores de Recursos ---
  Pode definir identificadores de recursos personalizados para usar em toda a configuração.
  Só pode usar as variáveis de template, nomes personalizados e identificadores de resource groups nesta variável.
  NOTA: Não pode referir outro identificador de recurso nesta variável.
  */
  resource_identifiers = {
    ama_change_tracking_data_collection_rule_id = "$${management_resource_group_id}/providers/Microsoft.Insights/dataCollectionRules/$${dcr_change_tracking_name}"
    ama_mdfc_sql_data_collection_rule_id        = "$${management_resource_group_id}/providers/Microsoft.Insights/dataCollectionRules/$${dcr_defender_sql_name}"
    ama_vm_insights_data_collection_rule_id     = "$${management_resource_group_id}/providers/Microsoft.Insights/dataCollectionRules/$${dcr_vm_insights_name}"
    ama_user_assigned_managed_identity_id       = "$${management_resource_group_id}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/$${ama_user_assigned_managed_identity_name}"
    log_analytics_workspace_id                  = "$${management_resource_group_id}/providers/Microsoft.OperationalInsights/workspaces/$${log_analytics_workspace_name}"
    ddos_protection_plan_id                     = "$${ddos_protection_plan_resource_group_id}/providers/Microsoft.Network/ddosProtectionPlans/$${ddos_protection_plan_name}"
  }
}

/*
*--- Tags ---
Essas tags são aplicadas a todos os recursos que o ALZ cria (e que suportem tags) 
*/
tags = {
  deployed_by = "terraform"
  source      = "Azure Landing Zones Accelerator"
}

/*
*--- Management Resources ---
You can use this section to customize the management resources that will be deployed.
*/
management_resources_enabled = true # TODO 11

management_resource_settings = {
  location                     = "$${starter_location_01}"
  log_analytics_workspace_name = "$${log_analytics_workspace_name}"
  resource_group_name          = "$${management_resource_group_name}"
  user_assigned_managed_identities = {
    ama = {
      name = "$${ama_user_assigned_managed_identity_name}"
    }
  }
  data_collection_rules = {
    change_tracking = {
      name = "$${dcr_change_tracking_name}"
    }
    defender_sql = {
      name = "$${dcr_defender_sql_name}"
    }
    vm_insights = {
      name = "$${dcr_vm_insights_name}"
    }
  }
}

/*
*--- Management Groups and Policy ---
Basicamente desliga toda a governança do ALZ. Os únicos recursos que continuariam a ser criados 
seriam os de conectividade (VNet, Gateways, DNS) e management (Log Analytics), se estiverem ligados
You can further configure management groups and policy by supplying a `lib` folder. This is detailed in the Accelerator documentation.
*/
management_groups_enabled = true

management_group_settings = {
  # Nome da arquitetura que define quais MGs criar e sua hierarquia.
  # Refere o ficheiro config/lib/architecture_definitions/alz_custom.alz_architecture_definition.yaml
  # Não altere a menos que tenha criado outra definição de arquitetura com outro nome.
  architecture_name  = "alz_custom"                        # Nome da arquitetura (deve corresponder ao "name:" no YAML)
  location           = "$${starter_location_01}"              # Região para deploys ao nível de subscription (role assignments, etc.)
  parent_resource_id = "$${root_parent_management_group_id}" # MG pai onde toda a hierarquia ALZ será criada (normalmente Tenant Root Group)
  policy_default_values = {
    ama_change_tracking_data_collection_rule_id = "$${ama_change_tracking_data_collection_rule_id}"
    ama_mdfc_sql_data_collection_rule_id        = "$${ama_mdfc_sql_data_collection_rule_id}"
    ama_vm_insights_data_collection_rule_id     = "$${ama_vm_insights_data_collection_rule_id}"
    ama_user_assigned_managed_identity_id       = "$${ama_user_assigned_managed_identity_id}"
    ama_user_assigned_managed_identity_name     = "$${ama_user_assigned_managed_identity_name}"
    log_analytics_workspace_id                  = "$${log_analytics_workspace_id}"
    ddos_protection_plan_id                     = "$${ddos_protection_plan_id}"
    private_dns_zone_subscription_id            = "$${subscription_id_connectivity}"
    private_dns_zone_region                     = "$${starter_location_01}"
    private_dns_zone_resource_group_name        = "$${dns_resource_group_name}"
    resource_group_name_service_health_alerts   = "$${service_health_alerts_resource_group_name}"
    resource_group_name_mdfc                    = "$${asc_export_resource_group_name}"
    resource_group_location                     = "$${starter_location_01}"
    email_security_contact                      = "$${defender_email_security_contact}"
    /*
    # Example of allowed locations for Sovereign Landing Zones policies
    allowed_locations = [
      "$${starter_location_01}"
    ]
    */
  }
  subscription_placement = {
    identity = {
      subscription_id       = "$${subscription_id_identity}"
      management_group_name = "identity"
    }
    connectivity = {
      subscription_id       = "$${subscription_id_connectivity}"
      management_group_name = "connectivity"
    }
    management = {
      subscription_id       = "$${subscription_id_management}"
      management_group_name = "management"
    }
  }
  policy_assignments_to_modify = {
    alz = {
      policy_assignments = {
        Deploy-MDFC-Config-H224 = { # TODO A policy Deploy-MDFC-Config-H224 é atribuída automaticamente pelo archetype do MG alz (root). Ela configura o Microsoft Defender for Cloud em todas as subscriptions.
          parameters = {
            enableAscForServers                         = "Disabled" #TODO desliga ele
            enableAscForServersVulnerabilityAssessments = "DeployIfNotExists"
            enableAscForSql                             = "DeployIfNotExists"
            enableAscForAppServices                     = "DeployIfNotExists"
            enableAscForStorage                         = "DeployIfNotExists"
            enableAscForContainers                      = "DeployIfNotExists"
            enableAscForKeyVault                        = "DeployIfNotExists"
            enableAscForSqlOnVm                         = "DeployIfNotExists"
            enableAscForArm                             = "DeployIfNotExists"
            enableAscForOssDb                           = "DeployIfNotExists"
            enableAscForCosmosDbs                       = "DeployIfNotExists"
            enableAscForCspm                            = "DeployIfNotExists"
          }
        }
      }
    }
  }
  /*
  # Example of how to add management group role assignments
  management_group_role_assignments = {
    root_owner_role_assignment = {
      management_group_name      = "root"
      role_definition_id_or_name = "Owner"
      principal_id               = "00000000-0000-0000-0000-000000000000"
    }
  }
  */
  # role_assignment_name_use_random_uuid = false  # Uncomment this for backwards compatibility with previous naming convention
}

/*
*--- Connectivity - Hub and Spoke Virtual Network ---
You can use this section to customize the hub virtual networking that will be deployed.
*/
connectivity_type = "hub_and_spoke_vnet"

connectivity_resource_groups = {
  ddos = {
    name     = "$${ddos_resource_group_name}"
    location = "$${starter_location_01}"
    settings = {
      enabled = "$${ddos_protection_plan_enabled}"
    }
  }
  vnet_primary = {
    name     = "$${connectivity_hub_primary_resource_group_name}"
    location = "$${starter_location_01}"
    settings = {
      enabled = true
    }
  }
  dns = {
    name     = "$${dns_resource_group_name}"
    location = "$${starter_location_01}"
    settings = {
      enabled = "$${primary_private_dns_zones_enabled}"
    }
  }
}

hub_and_spoke_networks_settings = {
  enabled_resources = {
    ddos_protection_plan = "$${ddos_protection_plan_enabled}"
  }
  ddos_protection_plan = {
    name                = "$${ddos_protection_plan_name}"
    resource_group_name = "$${ddos_resource_group_name}"
    location            = "$${starter_location_01}"
  }
}

hub_virtual_networks = {
  primary = {
    location          = "$${starter_location_01}"
    default_parent_id = "$${primary_connectivity_resource_group_id}"
    enabled_resources = {
      firewall                              = "$${primary_firewall_enabled}"
      bastion                               = "$${primary_bastion_enabled}"
      virtual_network_gateway_express_route = "$${primary_virtual_network_gateway_express_route_enabled}"
      virtual_network_gateway_vpn           = "$${primary_virtual_network_gateway_vpn_enabled}"
      private_dns_zones                     = "$${primary_private_dns_zones_enabled}"
      private_dns_resolver                  = "$${primary_private_dns_resolver_enabled}"
    }
    hub_virtual_network = {
      name                          = "$${primary_virtual_network_name}"
      address_space                 = ["$${primary_hub_virtual_network_address_space}"]
      routing_address_space         = ["$${primary_hub_address_space}"]
      route_table_name_firewall     = "$${primary_route_table_firewall_name}"     # TODO 14 No Firewall - ignorado pelo acelerador
      route_table_name_user_subnets = "$${primary_route_table_user_subnets_name}" # TODO 14 No Firewall - ignorado pelo acelerador
      subnets                       = {}
    }
    # TODO 14 No Firewall - bloco ignorado pelo acelerador
    firewall = {
      subnet_address_prefix            = "$${primary_firewall_subnet_address_prefix}"
      management_subnet_address_prefix = "$${primary_firewall_management_subnet_address_prefix}"
      name                             = "$${primary_firewall_name}"
      sku_tier                         = "$${primary_firewall_sku_tier}"
      default_ip_configuration = {
        public_ip_config = {
          name = "$${primary_firewall_public_ip_name}"
        }
      }
      management_ip_enabled = "$${primary_firewall_management_ip_enabled}"
      management_ip_configuration = {
        public_ip_config = {
          name = "$${primary_firewall_management_public_ip_name}"
        }
      }
    }
    # TODO 14 No Firewall - bloco ignorado pelo acelerador
    firewall_policy = {
      name = "$${primary_firewall_policy_name}"
      sku  = "$${primary_firewall_sku_tier}"
    }
    virtual_network_gateways = {
      subnet_address_prefix = "$${primary_gateway_subnet_address_prefix}"
      express_route = {
        name                                  = "$${primary_virtual_network_gateway_express_route_name}"
        hosted_on_behalf_of_public_ip_enabled = "$${primary_virtual_network_gateway_express_route_hobo_public_ip_enabled}"
        ip_configurations = {
          default = {
            # name = "vnetGatewayConfigdefault"  # For backwards compatibility with previous naming, uncomment this line
            public_ip = {
              name = "$${primary_virtual_network_gateway_express_route_public_ip_name}"
            }
          }
        }
      }
      vpn = {
        name = "$${primary_virtual_network_gateway_vpn_name}"
        ip_configurations = {
          active_active_1 = {
            # name = "vnetGatewayConfigactive_active_1"  # For backwards compatibility with previous naming, uncomment this line
            public_ip = {
              name = "$${primary_virtual_network_gateway_vpn_public_ip_name_1}"
            }
          }
          active_active_2 = {
            # name = "vnetGatewayConfigactive_active_2"  # For backwards compatibility with previous naming, uncomment this line
            public_ip = {
              name = "$${primary_virtual_network_gateway_vpn_public_ip_name_2}"
            }
          }
        }
      }
    }
    private_dns_zones = {
      parent_id = "$${dns_resource_group_id}"
      private_link_private_dns_zones_regex_filter = {
        enabled = false
      }
      auto_registration_zone_enabled = "$${primary_private_dns_auto_registration_zone_enabled}"
      auto_registration_zone_name    = "$${primary_auto_registration_zone_name}"
    }
    private_dns_resolver = {
      subnet_address_prefix = "$${primary_private_dns_resolver_subnet_address_prefix}"
      name                  = "$${primary_private_dns_resolver_name}"
    }
    bastion = {
      subnet_address_prefix = "$${primary_bastion_subnet_address_prefix}"
      name                  = "$${primary_bastion_host_name}"
      bastion_public_ip = {
        name = "$${primary_bastion_host_public_ip_name}"
      }
    }
  }
}

# private_link_private_dns_zone_virtual_network_link_moved_blocks_enabled = true

enable_telemetry = true
telemetry_additional_content = {
  deployed_by    = "alz-terraform-accelerator"
  correlation_id = "00000000-0000-0000-0000-000000000000"
}
