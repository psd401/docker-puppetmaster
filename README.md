# docker-puppetmaster
Docker image for puppet server

Autosigning is turned *on* in puppet.conf.

In addition, both the confdir and vardir are set to /opt/, and both the confdir and vardir are marked as data volumes in the Dockerfile.  This makes it easy to use data-only containers.

To use this container:
---

1.	Make a data-only container first, so you can destroy the puppetmaster container without losing certs or other configuration data:  
	`docker run -d --name puppet-data --entrypoint /bin/echo nmcspadden/puppetmaster Data-only container for puppetmaster`
2. `docker run -d --name puppetmaster -h puppet.sacredsf.org -p 8140:8140 --volumes-from puppet-data nmcspadden/puppetmaster`
3. To see list of certs: `docker exec puppetmaster puppet cert list -all`
4. To test on a client:
	1. Install Puppet, Hiera, Facter, and Puppet LaunchDaemon onto client
	2. Add the IP of your Docker host to /etc/hosts (or configure DNS so that your Docker host is reachable at "puppet").  For example:  
		"10.1.40.180	puppet"
	3. Test puppet on client running as root:  
		`# puppet agent --test`  
		You should see the cert request being generated and autosigned.
5. Verify cert signing on puppetmaster docker container:  
	`docker exec puppetmaster puppet cert list -all`
6. On the client, run:  
	`# puppet agent --test` again to verify that cert exists and was confirmed.
7.	To create manifests, place them in /opt/puppet/manifests/.