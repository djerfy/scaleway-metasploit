# Inherit from the Debian Jessie image by Scaleway.
FROM armbuild/scw-distrib-debian:jessie
MAINTAINER Djerfy <djerfy@gmail.com> (@djerfy)

# Prepare rootfs for image-builder.
RUN /usr/local/sbin/builder-enter

# Install system packages
RUN apt-get -q update && \
    apt-get -y -qq upgrade && \
    apt-get install -y build-essential libreadline-dev libssl-dev libpq5 libpq-dev && \
    apt-get install -y libreadline5 libsqlite3-dev libpcap-dev openjdk-7-jre git-core && \
    apt-get install -y autoconf postgresql pgadmin3 curl zlib1g-dev libxml2-dev && \
    apt-get install -y libxslt1-dev vncviewer libyaml-dev curl zlib1g-dev subversion apt-utils

# Install ruby with using rbenv
RUN git clone git://github.com/sstephenson/rbenv.git /root/.rbenv && \
    echo 'export PATH="/root/.rbenv/bin:$PATH"' >> /root/.bashrc && \
    echo 'eval "$(rbenv init -)"' >> /root/.bashrc && \
    . /root/.bashrc && \
    git clone git://github.com/sstephenson/ruby-build.git /root/.rbenv/plugins/ruby-build && \
    echo 'export PATH="/root/.rbenv/plugins/ruby-build/bin:$PATH"' >> /root/.bashrc && \
    . /root/.bashrc && \
    rbenv install 2.1.6 && \
    rbenv global 2.1.6

# Install nmap
RUN svn co https://svn.nmap.org/nmap /root/nmap && \
    cd /root/nmap && \
    ./configure --without-ncat && \
    make && \
    make install && \
    rm -Rf /root/nmap && \
    . /root/.bashrc

# Configure postgresql server
RUN service postgresql start && \
    su - postgres -c "createuser msf -P -S -R -D" && \
    su - postgres -c "createdb -O msf msf" && \
    update-rc.d postgresql enable

# Install metasploit framework
RUN cd /opt && \
    . /etc/.bashrc && . /etc/profile && \
    git clone https://github.com/rapid7/metasploit-framework.git && \
    chown -R root:root /opt/metasploit-framework && \
    cd /opt/metasploit-framework && \
    gem install bundler && \
    bundle install && \
    for MSF in $(ls msf*); do ln -s /opt/metasploit-framework/$MSF /usr/local/bin/$MSF; done && \
    echo export MSF_DATABASE_CONFIG=/opt/metasploit-framework/config/database.yml >> /etc/profile && \
    . /etc/profile

# Add local files from the patches directory
ADD ./patches/ /

# Clean rootfs from image-builder.
RUN /usr/local/sbin/builder-leave

