# Base image: CentOS 7
FROM centos:7

# Use CentOS Vault repos for EOL packages
RUN mkdir -p /etc/yum.repos.d/backup && \
    mv /etc/yum.repos.d/*.repo /etc/yum.repos.d/backup/ && \
    cat > /etc/yum.repos.d/CentOS-Vault.repo <<EOF
[base]
name=CentOS-7 - Base
baseurl=http://vault.centos.org/7.9.2009/os/x86_64/
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7
enabled=1

[updates]
name=CentOS-7 - Updates
baseurl=http://vault.centos.org/7.9.2009/updates/x86_64/
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7
enabled=1

[extras]
name=CentOS-7 - Extras
baseurl=http://vault.centos.org/7.9.2009/extras/x86_64/
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7
enabled=1
EOF

# Install Qt3 and X11 tools
RUN yum clean all && \
    yum makecache && \
    yum install -y qt3 qt3-devel xorg-x11-xauth xorg-x11-apps && \
    yum clean all

# Copy your binary into the container
COPY bin/cutecom /usr/local/bin/cutecom
RUN chmod +x /usr/local/bin/cutecom

# Set workdir
WORKDIR /data

# Entrypoint
ENTRYPOINT ["/usr/local/bin/cutecom"]

