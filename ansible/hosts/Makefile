

all: ansible.hosts

terraform.tfstate: 
	terraform apply

ansible.hosts: terraform.tfstate
	terraform output ansible_hosts > $@

clean:
	rm -f terraform.tfstate ansible.hosts