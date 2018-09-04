FROM alpine:3.8
## Install Ansible
RUN apk --no-cache add python py-pip openssl ca-certificates && \
    apk --no-cache add --virtual build-dependencies \
                        python-dev libffi-dev openssl-dev build-base && \
    pip install --upgrade pip cffi && \
    pip install --upgrade pywinrm ansible && \
    apk del build-dependencies            && \
    rm -rf /var/cache/apk/*
## Install Packer
ENV PACKER_ZIP_URL 'https://releases.hashicorp.com/packer/1.2.5/packer_1.2.5_linux_amd64.zip'
RUN apk --no-cache add --virtual install-dependencies \
                        curl libarchive-tools && \
    curl -L ${PACKER_ZIP_URL} | bsdtar xvf - -C /usr/sbin && \
    chmod +x /usr/sbin/packer && \
    apk del install-dependencies && \
    rm -rf /var/cache/apk/*