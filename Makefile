DOCKER_NAMESPACE =  armbuild/
NAME =              scaleway-metasploit
VERSION =           1.0.0
VERSION_ALIASES =   1.0.0 latest
TITLE =             Metasploit
DESCRIPTION =       An image with Metasploit
SOURCE_URL =        https://github.com/djerfy/scaleway-metasploit

## Image tools (https://github.com/scaleway/image-tools)
all:    docker-rules.mk
docker-rules.mk:
	wget -qO - http://j.mp/scw-builder | bash
-include docker-rules.mk

