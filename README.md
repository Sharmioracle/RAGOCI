# RAGOCI



Steps:
1.	Download the zip file:
-	Download the zip file containing the Terraform configuration and resource files.
2.	Extract zip file in local machine (your laptop):
-	Extract the downloaded zip file on your local machine.
3.	Navigate to folder:
-	Open a terminal window and navigate to the directory containing the extracted Terraform configuration files.
4.	Update the config file with appropriate values:
-	user=<<user ocid>>
-	fingerprint=<<User fingerprint>>
-	tenancy=<<user tenancy>>
-	region=<<user region>>
5.	Replace key files content only (do not change the name of ssh key files):
-	Replace the content of the SSH key files with your private key information. Be cautious not to modify the filenames or location of the SSH key files.” ~/.oci/ssh_key.pem”
6.	Login to OCI, navigate to Developer services Resource manager > Create Stack:
-	Log in to the Oracle Cloud Infrastructure (OCI) console.
-	Go to Developer Services > Resource Manager.
-	Click on Create Stack.
7.	Pull the modified folder:
-	In the OCI Resource Manager, select the option to Pull an infrastructure stack.
8.	Provide the asked parameters:
-	Enter the required parameters for the Terraform configuration, as prompted by the OCI Resource Manager.
9.	Click on Plan:
-	Click on the Plan button to review the changes that Terraform will make to your OCI resources.
10.	Click apply (expect 30 mins to complete):
-	After reviewing the plan, click on Apply to provision the resources in your OCI environment. This process might take up to 30 minutes to complete.


Demo Access:
1.	Login to the vm instance as opc user with the same ssh key as used above

a.	conda activate rav_vm
b.	cd llamaindex_oracle-main

2.	Streamlit run oracle_bot.py 
3.	From your local machine open a tunnel to the vm
   
a.	ssh -L 8501:localhost:8501 -i <<your_key_here>>.key opc@<<ip of the vm>>
5.	 Browse localhost:8501 in your machine and access . 



