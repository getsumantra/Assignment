#--------------------------------------
# Resource Group Values
#--------------------------------------

resource_groups = {
  "prod_rg01" = {
    resource_group_name = "prod-rg-01"
    location            = "Central India"
    environment         = "prod"
    project             = "my_project"
  }
}


#--------------------------------------
# Storage Account Values
#--------------------------------------

storage_accounts = {
  "stg01" = {
    name                     = "prodstorage01"
    resource_group_name      = "prod-rg-01"
    location                 = "Central India"
    account_tier             = "Standard"
    account_replication_type = "GRS"
    tags = {
      environment = "prod"
    }
  }
}

#--------------------------------------
# Virtual Network Values
#--------------------------------------

vnets = {
  "prod_vnet01" = {
    name                = "prod-vnet-01"
    address_space       = ["10.0.0.0/16"]
    location            = "Central India"
    resource_group_name = "prod-rg-01"

    subnet = {
      "frontend-subnet" = {
        name             = "frontend-subnet-01"
        address_prefixes = ["10.0.0.1/24"]
      },
       "backend-subnet" = {
        name             = "backend-subnet-01"
        address_prefixes = ["10.0.0.2/24"]
      }
    }
  }
}

#--------------------------------------
# Public IP Values
#--------------------------------------

public_ips = {
  "frontend-pip" = {
    name                = "frontend-pip-01"
    resource_group_name = "prod-rg-01"
    location            = "Central India"
    allocation_method   = "Static"
    environment         = "prod"
    sku                 = "Standard"
  },
   "backend-pip" = {
    name                = "backend-pip-01"
    resource_group_name = "prod-rg-01"
    location            = "Central India"
    allocation_method   = "Static"
    environment         = "prod"
    sku                 = "Standard"
  }
  # "bastion_pip01" = {
  #   name                = "bastion-pip-01"
  #   resource_group_name = "prod-rg-01"
  #   location            = "Central India"
  #   allocation_method   = "Static"
  #   environment         = "prod"
  #   sku                 = "Standard"
  # }
}


#--------------------------------------
# Network Interfaces & Virutal machine along with NSG Values
#--------------------------------------

vms = {
  "prod_vm01" = {
    name                  = "frondend-vm-01"
    location              = "Central India"
    resource_group_name   = "prod-rg-01"
    subnet_name           = "frontend-subnet-01"
    virtual_network_name  = "prod-vnet-01"
    pip_name              = "frontend-pip-01"
    network_interface_ids = []

    nic_name              = "frontend-nic-01"
    location              = "Central India"
    resource_group_name   = "prod-rg-01"
    size                  = "Standard_B1s"
    admin_username        = "adminuser"
    admin_password        = "P@ssw0rd1234!"
    script_name           = "nginx.sh"
    size                  = "Standard_B1s"
    network_interface_ids = []
    os_disk = {
      caching              = "ReadWrite"
      storage_account_type = "Standard_LRS"
    }
    source_image_reference = {
      publisher = "Canonical"
      offer     = "UbuntuServer"
      sku       = "18.04-LTS"
      version   = "latest"
    }
    nsg_name = "frontend-nsg-01"

    security_rules = [
      {
        name                       = "AllowSSH"
        priority                   = 1001
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      },
      {
        name                       = "AllowHTTP"
        priority                   = 1002
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "80"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      },
      {
        name                       = "DenyAllOutbound"
        priority                   = 4001
        direction                  = "Outbound"
        access                     = "Deny"
        protocol                   = "*"
        source_port_range          = "*"
        destination_port_range     = "*"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      }
    ]
  },
    "prod_vm02" = {
    name                  = "backend-vm-01"
    location              = "Central India"
    resource_group_name   = "prod-rg-01"
    subnet_name           = "backend-subnet-01"
    virtual_network_name  = "prod-vnet-01"
    pip_name              = "backend-pip-01"
    network_interface_ids = []

    nic_name              = "backend-nic-01"
    location              = "Central India"
    resource_group_name   = "prod-rg-01"
    size                  = "Standard_B1s"
    admin_username        = "adminuser"
    admin_password        = "P@ssw0rd1234!"
    script_name           = "nginx.sh"
    size                  = "Standard_B1s"
    network_interface_ids = []
    os_disk = {
      caching              = "ReadWrite"
      storage_account_type = "Standard_LRS"
    }
    source_image_reference = {
      publisher = "Canonical"
      offer     = "UbuntuServer"
      sku       = "18.04-LTS"
      version   = "latest"
    }
    nsg_name = "backend-nsg-01"

    security_rules = [
      {
        name                       = "AllowSSH"
        priority                   = 1001
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      },
      {
        name                       = "AllowHTTP"
        priority                   = 1002
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "80"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      },
      {
        name                       = "DenyAllOutbound"
        priority                   = 4001
        direction                  = "Outbound"
        access                     = "Deny"
        protocol                   = "*"
        source_port_range          = "*"
        destination_port_range     = "*"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      }
    ]
  }
}


#--------------------------------------
# Key Vault Values
#--------------------------------------

key_vaults = {
  "prod-kv01" = {
    name                = "prod-kv-01"
    location            = "Central India"
    resource_group_name = "prod-rg-01"
    sku_name            = "standard"
  }
}

#--------------------------------------
# SQL Server Values
#--------------------------------------

mysql_server = {
  "prod_mysql_server01" = {
    name                         = "prod-mysql-server-01"
    mysql_server_name            = "prod-mysql-server-01"
    resource_group_name          = "prod-rg-01"
    location                     = "Central India"
    version                      = "12.0"
    administrator_login          = "sqladminuser"
    administrator_login_password = "Sql@dminP@ssw0rd1234"

    tags = {
      environment = "prod"
    }
  }
}

#--------------------------------------
# SQL Database Values
#--------------------------------------

mysql_db = {
  "prod_mysql_db01" = {
    name                = "prod-mysql-db-01"
    resource_group_name = "prod-rg-01"
    mysql_server_name   = "prod-mysql-server-01"
    collation           = "SQL_Latin1_General_CP1_CI_AS"
    license_type        = "LicenseIncluded"
    max_size_gb         = 2
    sku_name            = "S0"
    enclave_type        = "VBS"

    tags = {
      environment = "prod"
    }
  }
}

#--------------------------------------
# Bastion Host Values
#--------------------------------------

bastion_host = {
  "prod_bastion01" = {
    name                 = "prod-bastion-01"
    resource_group_name  = "prod-rg-01"
    location             = "Central India"
    subnet_name          = "bastion-pip-01"
    virtual_network_name = "prod-vnet-01"
    ip_configuration = {
      name           = "prod-bastion-ipconfig-01"
      public_ip_name = "prod-pip-01"
    }
  }
}
