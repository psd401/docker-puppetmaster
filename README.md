# docker-puppetmaster
Docker image for puppet server

Autosigning is turned off.

To use this container:
1. docker run -d --name puppetmaster -h puppet.sacredsf.org -p 8140:8140 nmcspadden/puppetmaster
2. docker exec puppetmaster puppet cert list -all
