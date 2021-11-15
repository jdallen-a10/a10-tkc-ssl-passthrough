#
#  vThunder configs for TKC demo of SSL Passthrough
#
#  John D. Allen
#  Global Solutions Architect - Cloud, IOT, & Automation
#  A10 Networks, Inc.
#  Apache v2.0 License applies.
#  November, 2021
#

terraform {
  required_providers {
    thunder = {
      source = "a10networks/thunder"
      version = "0.5.18-beta"
    }
    linux = {
      source = "mavidser/linux"
      version = ">=1.0.2"
    }
  }
}

provider "thunder" {
  address = var.thunder_ip_address
  username = var.thunder_username
  password = var.thunder_password
  # partition = "shared"
}

resource "thunder_slb_template_virtual_server" "bw-control" {
  name = "bw-control"
  conn_limit = 20
  conn_rate_limit = 20
}

resource "thunder_virtual_server" "ws-vip" {
  depends_on = [
    thunder_slb_template_virtual_server.bw-control
  ]
  name = "ws-vip"
  ip_address = var.thunder_vip
  template_virtual_server = "bw-control"
  port_list {
    port_number = 443
    protocol = "tcp"
  }
}

resource "thunder_glm" "license-glm" {
  depends_on = [
    thunder_virtual_server.ws-vip
  ]
  appliance_name = "Demo.Test521"
  token = var.thunder_glm_token
  use_mgmt_port = 0
  enable_requests = 1
  allocate_bandwidth = 1000
  interval = 1 
}

resource "thunder_glm_send" "get-license" {
  depends_on = [
    thunder_glm.license-glm
  ] 
  license_request = 1
}
