resource "azurerm_network_security_group" "res-0" {
  location            = "eastus"
  name                = "vm-rdp-nsg"
  resource_group_name = "rg-rdp-001"
  depends_on = [
    azurerm_resource_group.res-14,
  ]
}
resource "azurerm_public_ip" "res-1" {
  allocation_method   = "Static"
  location            = "eastus"
  name                = "vm-rdp-ip"
  resource_group_name = "rg-rdp-001"
  sku                 = "Standard"
  zones               = ["1"]
  depends_on = [
    azurerm_resource_group.res-14,
  ]
}
resource "azurerm_virtual_network" "res-2" {
  address_space       = ["10.1.0.0/20"]
  location            = "eastus"
  name                = "rg-rdp-001-vnet"
  resource_group_name = "rg-rdp-001"
  depends_on = [
    azurerm_resource_group.res-14,
  ]
}
resource "azurerm_network_security_rule" "res-5" {
  access                      = "Allow"
  destination_address_prefix  = "*"
  destination_port_range      = "3389"
  direction                   = "Inbound"
  name                        = "RDP"
  network_security_group_name = "vm-rdp-nsg"
  priority                    = 300
  protocol                    = "Tcp"
  resource_group_name         = "rg-rdp-001"
  source_address_prefix       = "*"
  source_port_range           = "*"
  depends_on = [
    azurerm_network_security_group.res-0,
  ]
}
resource "azurerm_subnet" "res-6" {
  address_prefixes     = ["10.1.0.0/24"]
  name                 = "default"
  resource_group_name  = "rg-rdp-001"
  virtual_network_name = "rg-rdp-001-vnet"
  depends_on = [
    azurerm_virtual_network.res-2,
  ]
}
resource "azurerm_subnet" "res-7" {
  address_prefixes     = ["10.1.1.0/24"]
  name                 = "snet-test-001"
  resource_group_name  = "rg-rdp-001"
  virtual_network_name = "rg-rdp-001-vnet"
  depends_on = [
    azurerm_virtual_network.res-2,
  ]
}
resource "azurerm_network_interface" "res-13" {
  location            = "eastus"
  name                = "vm-rdp431_z1"
  resource_group_name = "rg-rdp-001"
  ip_configuration {
    name                          = "ipconfig1"
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = "/subscriptions/6211e26b-b9e2-4017-aea5-23b2281870ad/resourceGroups/rg-rdp-001/providers/Microsoft.Network/publicIPAddresses/vm-rdp-ip"
    subnet_id                     = "/subscriptions/6211e26b-b9e2-4017-aea5-23b2281870ad/resourceGroups/rg-rdp-001/providers/Microsoft.Network/virtualNetworks/rg-rdp-001-vnet/subnets/default"
  }
  depends_on = [
    azurerm_public_ip.res-1,
    azurerm_subnet.res-6,
    azurerm_network_security_group.res-0,
  ]
}
resource "azurerm_resource_group" "res-14" {
  location = "eastus"
  name     = "rg-rdp-001"
}