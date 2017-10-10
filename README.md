# docker-centos-httpd
## Apache running on CentOS (7.4)
### Build Version: 4
Date of Build: 10th October 2017

The Dockerfile should intialise the CentOS image and subscribe to the EPEL repository.

The EPEL repository provides:

    supervisor

The httpd package is installed along with mod_ssl (for SSL connection support) and is controlled via the supervisord daemon which has a web front end exposed via port 9005. Default username and password for the web front end is admin:admin.

The container can be run as follows:

    docker pull jervine/docker-centos-radarr
    docker run -d --network=<optional network> --name <optional container name> -h <optional hostname> -e TZ=<optional timezone> -v /docker/config/httpd:/config -p 80:80 -p 443:443 -p 9005:9005 jervine/docker-centos-httpd
    

The TZ variable allows the user to set the correct timezone for the container and should take the form "Europe/London". If no timezone is specified then UTC is used by default. The timezone is set up when the container is run. Subsequent stops and starts will not change the timezone.

If the container is removed and is set up again using docker run commands, remember to remove the .setup file so that the start.sh script will recreate the user account and set the local time correctly.

The container can be verified on the host by using:

    docker logs <container id/container name>

Please note that the SELinux permissions of the config and downloads directories may need to be changed/corrected as necessary. [Currently chcon -Rt svirt_sandbox_file_t ]
