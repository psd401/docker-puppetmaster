# docker-puppetmaster
Docker image for puppet server

Autosigning is turned off in puppet.conf.

To use this container:

1. `docker run -d --name puppetmaster -h puppet.domain.com -p 8140:8140 nmcspadden/puppetmaster`
2. To see list of certs: `docker exec puppetmaster puppet cert list -all`
3. To test on a client:
	1. Install Puppet, Hiera, Facter, and Puppet LaunchDaemon onto client
	2. Add the IP of your Docker host to /etc/hosts (or configure DNS so that your Docker host is reachable at "puppet").  For example:  
		"10.1.40.180	puppet"
	3. Test puppet on client running as root:  
		`# puppet agent --test`  
		You should see the cert request being generated.
4. Verify cert signing on puppetmaster docker container:
	1. `docker exec puppetmaster puppet cert list -all`
	2. `docker exec puppetmaster puppet cert sign <hostname>`
5. On the client, run:  
	`# puppet agent --test` again to verify that cert exists and was confirmed