variable "region" {
    description = "this is the region where my resources will be created"
    type = string
    default = "us-central1"
  
}

variable "name" {
    description = "this is the name of my resource"
    type = string
    default = "norbert"
  
}

variable "image" {
    description = "The image of the vm"
    type = string
    default = "centos-cloud/centos-7"
  
}

variable "zone" {
    description = "This the zone where my resources will be created"
    type = string
    default = "us-central1-a"
}
variable "machine-type" {
    description = "The instance type to use after creating the vm"
    type = string
    default = "e2-medium"
  
}