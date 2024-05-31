variable "compartment_id" {
  type        = string
  description = "The Compartment ID where the Instance needs to provision"
}

variable "availability_domain" {
  type        = string
  description = "The availability domain of the region"
}
variable "vcn_id"{
type        = string
  description = "The available vcn"
}
variable "Subnet_id" {
  type        = string
  description = "The OCID of the Subnet for  instance"
    validation {
    condition     = length(regexall("^ocid1.subnet.*$", var.Subnet_id)) > 0
    error_message = "ERROR: The value for subnet_id should start with \"ocid1.subnet.\"."
  }
}
variable "ssh_public_key" {
  type        = string
  description = "Public key for ssh access to WebLogic compute instances. Use the corresponding private key to access the WebLogic compute instances"
}
variable "COHERE_API_KEY" {
  type        = string
  description = "COHERE_API_KEY for DB configuration"
}
