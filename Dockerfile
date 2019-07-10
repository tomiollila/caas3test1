FROM opensuse
MAINTAINER SUSE Manager Team "castor.fi"

### Begin: These lines Required for use with {productname}

ARG repo
ARG cert

# Add the correct certificate
RUN echo "$cert" > /etc/pki/trust/anchors/RHN-ORG-TRUSTED-SSL-CERT.pem

# Update certificate trust store
RUN update-ca-certificates

# Add the repository path to the image
RUN echo "$repo" > /etc/zypp/repos.d/susemanager:dockerbuild.repo

### End: These lines required for use with {productname}

# Add the package script
#ADD add_packages.sh /root/add_packages.sh

# Run the package script
#RUN /root/add_packages.sh

# The RUN command adds commands like from the command line.
RUN zypper refs && zypper refresh

# install package

RUN     zypper  --non-interactive in apache2 \
	apache2-mod_php7

	
ADD index.html /srv/www/htdocs/
#ADD phpinfo.php /srv/www/htdocs/

# CMD is the main command of the image. Docker images do not normally use systemd in the normal way so it is generally advised to run services manually.
# In this example, I am starting apache manually.
CMD 	/usr/sbin/apachectl -D FOREGROUND

# EXPOSE tells docker that this image will natively run on port 80 which is http. 
EXPOSE	80

# After building remove the repository path from image
#RUN rm -f /etc/zypp/repos.d/susemanager:dockerbuild.repo
