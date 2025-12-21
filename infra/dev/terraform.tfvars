#--------------------------------------
# Resource Group Values
#--------------------------------------

resource_groups = {
  "dev_rg01" = {
    resource_group_name = "dev-rg-01"
    location            = "Central India"
    environment         = "dev"
    project             = "my_project"
  }
}


#--------------------------------------
# Storage Account Values
#--------------------------------------

storage_accounts = {
  "stg01" = {
    name                     = "devstorageunique01"
    resource_group_name      = "dev-rg-01"
    location                 = "Central India"
    account_tier             = "Standard"
    account_replication_type = "GRS"
    tags = {
      environment = "dev"
    }
  }
}

#--------------------------------------
# Virtual Network Values
#--------------------------------------

vnets = {
  "dev_vnet01" = {
    name                = "dev-vnet-01"
    address_space       = ["10.0.0.0/16"]
    location            = "Central India"
    resource_group_name = "dev-rg-01"

    subnet = {
      "frontend-subnet" = {
        name             = "frontend-subnet-01"
        address_prefixes = ["10.0.1.0/24"]
      },
       "backend-subnet" = {
        name             = "backend-subnet-01"
        address_prefixes = ["10.0.2.0/24"]
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
    resource_group_name = "dev-rg-01"
    location            = "Central India"
    allocation_method   = "Static"
    environment         = "dev"
    sku                 = "Standard"
  },
   "backend-pip" = {
    name                = "backend-pip-01"
    resource_group_name = "dev-rg-01"
    location            = "Central India"
    allocation_method   = "Static"
    environment         = "dev"
    sku                 = "Standard"
  }
  # "bastion_pip01" = {
  #   name                = "bastion-pip-01"
  #   resource_group_name = "dev-rg-01"
  #   location            = "Central India"
  #   allocation_method   = "Static"
  #   environment         = "dev"
  #   sku                 = "Standard"
  # }
}


#--------------------------------------
# Network Interfaces & Virutal machine along with NSG Values
#--------------------------------------

vms = {
  "dev_vm01" = {
    name                  = "frondend-vm-01"
    location              = "Central India"
    resource_group_name   = "dev-rg-01"
    subnet_name           = "frontend-subnet-01"
    virtual_network_name  = "dev-vnet-01"
    pip_name              = "frontend-pip-01"
    network_interface_ids = []

    nic_name              = "frontend-nic-01"
    location              = "Central India"
    resource_group_name   = "dev-rg-01"
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
      offer     = "0001-com-ubuntu-server-focal"
      sku       = "20_04-lts"
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
        name                       = "AllowAllOutbound"
        priority                   = 4001
        direction                  = "Outbound"
        access                     = "Allow"
        protocol                   = "*"
        source_port_range          = "*"
        destination_port_range     = "*"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      }
    ]
  },
    "dev_vm02" = {
    name                  = "backend-vm-01"
    location              = "Central India"
    resource_group_name   = "dev-rg-01"
    subnet_name           = "backend-subnet-01"
    virtual_network_name  = "dev-vnet-01"
    pip_name              = "backend-pip-01"
    network_interface_ids = []

    nic_name              = "backend-nic-01"
    location              = "Central India"
    resource_group_name   = "dev-rg-01"
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
      offer     = "0001-com-ubuntu-server-focal"
      sku       = "20_04-lts"
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
        name                       = "AllowAllOutbound"
        priority                   = 4001
        direction                  = "Outbound"
        access                     = "Allow"
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
  "dev-kv01" = {
    name                = "dev-kv-unique-01"
    location            = "Central India"
    resource_group_name = "dev-rg-01"
    sku_name            = "standard"
  }
}

#--------------------------------------
# SQL Server Values
#--------------------------------------

mysql_server = {
  "dev_mysql_server01" = {
    name                         = "dev-mysql-server-001"
    mysql_server_name            = "dev-mysql-server-001"
    resource_group_name          = "dev-rg-01"
    location                     = "Central India"
    version                      = "12.0"
    administrator_login          = "sqladminuser"
    administrator_login_password = "Sql@dminP@ssw0rd1234"

    tags = {
      environment = "dev"
    }
  }
}

#--------------------------------------
# SQL Database Values
#--------------------------------------

mysql_db = {
  "dev_mysql_db01" = {
    name                = "dev-mysql-db-001"
    resource_group_name = "dev-rg-01"
    mysql_server_name   = "dev-mysql-server-001"
    collation           = "SQL_Latin1_General_CP1_CI_AS"
    license_type        = "LicenseIncluded"
    max_size_gb         = 2
    sku_name            = "S0"
    enclave_type        = "VBS"

    tags = {
      environment = "dev"
    }
  }
}

#--------------------------------------
# Bastion Host Values
#--------------------------------------

bastion_host = {
  "dev_bastion01" = {
    name                 = "dev-bastion-01"
    resource_group_name  = "dev-rg-01"
    location             = "Central India"
    subnet_name          = "bastion-pip-01"
    virtual_network_name = "dev-vnet-01"
    ip_configuration = {
      name           = "dev-bastion-ipconfig-01"
      public_ip_name = "dev-pip-01"
    }
  }
}
