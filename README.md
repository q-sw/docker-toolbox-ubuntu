# docker-devops-toolbox-ubuntu
# Version: 4.0

# Outillage:  
- Terraform v0.14.5
- Ansible v2.10.1
- kubectl v1.19.7 
- CLI openstack (cinder, glance, heat, neutron, nova)
- CLI AWS V2
- Helm v3.2.4

# Construire l'image:  
```
make build name="mytoolbox" version="2.0"
```
# Construire le container:
`docker run --name my_toolbox  -it toolbox:2.0 `

