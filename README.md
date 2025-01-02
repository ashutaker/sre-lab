# SRE lab
Purpose of this lab is to deploy and play with various open source observability tools. This lab will be hosted by virtual environment in a Proxmox cluster. This cluster is built on two decade old laptops. Direct use of any cloud services will be avoided to save money unless they are free.
2-node K8s cluster is deployed on Proxmox. This will be used to run the microservices. Rest all tooling will be done outside of K8s. 
Terraform to be used to craete the VMs
Ansible to configure the nodes as per need.

## Lab Objectives
- [ ] Run a DB server(RDBMS)
- [ ] Run NoSQL server
- [ ] In K8s - have servicemesh
- [ ] Grafana/Prometheus for visualization
- [ ] Elastic search to store the logs and APM