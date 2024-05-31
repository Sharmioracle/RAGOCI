provider "oci" {}
resource "oci_core_image" "test_image" {
    #Required
    compartment_id = var.compartment_id

    #Optional
    display_name = "DBwithapp"
    launch_mode = "PARAVIRTUALIZED"

    image_source_details {
        source_type = "objectStorageUri"
        source_uri = "https://orasenatdctocloudcorp01.objectstorage.us-chicago-1.oci.customer-oci.com/p/lq69bUaD-o__teu-xXPu73_-eY7P_CxB0qQ7QRdifdmYNPZ-qTmQacP-cR_ilJKR/n/orasenatdctocloudcorp01/b/rag_demo_image/o/rag_vec_la" 
    }
}

resource "oci_core_instance" "generated_oci_core_instance" {
	depends_on = [oci_core_image.test_image]
	agent_config {
		is_management_disabled = "false"
		is_monitoring_disabled = "false"
		plugins_config {
			desired_state = "DISABLED"
			name = "Vulnerability Scanning"
		}
		plugins_config {
			desired_state = "DISABLED"
			name = "Oracle Java Management Service"
		}
		plugins_config {
			desired_state = "ENABLED"
			name = "OS Management Service Agent"
		}
		plugins_config {
			desired_state = "DISABLED"
			name = "Management Agent"
		}
		plugins_config {
			desired_state = "ENABLED"
			name = "Custom Logs Monitoring"
		}
		plugins_config {
			desired_state = "DISABLED"
			name = "Compute RDMA GPU Monitoring"
		}
		plugins_config {
			desired_state = "ENABLED"
			name = "Compute Instance Run Command"
		}
		plugins_config {
			desired_state = "ENABLED"
			name = "Compute Instance Monitoring"
		}
		plugins_config {
			desired_state = "DISABLED"
			name = "Compute HPC RDMA Auto-Configuration"
		}
		plugins_config {
			desired_state = "DISABLED"
			name = "Compute HPC RDMA Authentication"
		}
		plugins_config {
			desired_state = "DISABLED"
			name = "Block Volume Management"
		}
		plugins_config {
			desired_state = "DISABLED"
			name = "Bastion"
		}
	}
	availability_config {
		recovery_action = "RESTORE_INSTANCE"
	}
	availability_domain = var.availability_domain
	compartment_id = var.compartment_id
	create_vnic_details {
		assign_ipv6ip = "false"
		assign_private_dns_record = "true"
		assign_public_ip = "true"
		subnet_id = var.Subnet_id
	}
	display_name = "instance-20240319-2018"
	instance_options {
		are_legacy_imds_endpoints_disabled = "false"
	}
	is_pv_encryption_in_transit_enabled = "true"
	metadata = {
		"ssh_authorized_keys" = var.ssh_public_key
	}
	shape = "VM.Standard.E4.Flex"
	shape_config {
		memory_in_gbs = "16"
		ocpus = "1"
	}
	source_details {
		source_id = oci_core_image.test_image.id
		source_type = "image"
	}
}
resource "null_resource" "remote-exec1" {
  connection {
    type        = "ssh"
    host        = oci_core_instance.generated_oci_core_instance.public_ip
    user        = "opc"
    private_key = file("ssh_key.pem")
    }
	provisioner "file"{
    source = "ssh_key.pem"
    destination = "/home/opc/.oci/ssh_key.pem"
  	}
	provisioner "file"{
    source = "config"
    destination = "/home/opc/config"
  	}
	provisioner "remote-exec" {   
    
    inline = [
      "set -o errexit",
	  "sudo sed -i \"s+ocid1.compartment.oc1..aaaaaaaavowbqjzmbhqxjgmca5xfetw37ldxed6e3plyplozkwhcgd7krhrq+\"${var.compartment_id}\"+g\" /home/opc/llamaindex_oracle-main/config_private.py",
	  "sudo sed -i \"s+ljeM0CLH0HIY1fddeV6HO6tr0GIfmEFZDfAdOvnG+\"${var.COHERE_API_KEY}\"+g\" /home/opc/llamaindex_oracle-main/config_private.py",
	  "cd /home/opc",
	  "cd .oci",
	  "sudo mv config config_copy",
	  "sudo mv /home/opc/config /home/opc/.oci/config"
	]
	}
}
