variable "web_ips"  { default = "10.0.0.1,10.0.0.2,10.0.0.3" }

resource "template_file" "web_ansible" {
  count = "${length(split(",",var.web_ips))}"
  template = "${file("${path.module}/hostname.tpl")}"
  vars {
    index = "${count.index + 1}"
    name  = "web"
    env   = "p"
    extra = " ansible_host=${element(split(",",var.web_ips),count.index)}"
    # extra = ""
  }
}

resource "template_file" "ansible_hosts" {
  template = "${file("${path.module}/ansible_hosts.tpl")}"
  vars {
    env         = "production"
    web_hosts   = "${join("\n",template_file.web_ansible.*.rendered)}"
  }
}

output "ansible_hosts" {
	value = "${template_file.ansible_hosts.rendered}"
}

