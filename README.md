# docker-samba

## Options

* -s
	* path to script to execute on startup which would typically setup the container users and their samba password
* -n
	* run nmbd during startup

## Example Usage

```
docker run -d -p 137:137/udp -p 138:138/udp -p 139:139 -p 445:445 \
  -v <YOUR_OWN_CONFIG_PATH>:/etc/samba/conf.d/smb.conf \
  -v  <HOST_SHARE_PATH>:<CONTAINER_SHARE_PATH> \
  -v <SOME_PATH>setup_script.sh:/opt/setup_script.sh \
  snipzwolf/docker-samba -s /opt/setup_script.sh
```

In the git repo you can find an example config and script inside the test directory
which you can run using the commands below

```
	git clone <REPO_URL> docker-samba
	cd docker-samba
	nano test/.secrets.sh #create OWN_UID,OWN_GID,OWN_USERNAME,OWN_GROUPNAME,OWN_PASSWORD variables referenced in test/own_set.sh
	docker run -d -p 137:137/udp -p 138:138/udp -p 139:139 -p 445:445 \
	  -v  `pwd`/test/share/:/srv/share/ \
	  -v `pwd`/test/:/opt/test/ \
	  snipzwolf/docker-samba -s /opt/test/own_setup.sh
```
