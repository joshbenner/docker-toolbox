FROM tutum/ubuntu:trusty
MAINTAINER Josh Benner <josh@bennerweb.com>

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y -q \
        slapd ldap-utils rsync curl wget git s3cmd python-pip mysql-client \
        dnsutils php5-cli build-essential libffi-dev libssl-dev python-dev && \
    apt-get clean && \
    pip install -U pip virtualenv setuptools pyOpenSSL ndg-httpsclient pyasn1 && \
    apt-get purge -y build-essential libffi-dev libssl-dev python-dev && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /root/.cache/pip

ENV SSH_IMPORT_IDS=**None** \
    MYSQLDUMP_OPTIONS="--quote-names --quick --add-drop-table --add-locks --allow-keywords --disable-keys --extended-insert --single-transaction --create-options --comments --net_buffer_length=16384" \
    MYSQL_HOST=**None** \
    MYSQL_PORT=3306 \
    MYSQL_USER=root \
    MYSQL_PASSWORD=**None** \
    MYSQL_BACKUP_DIR=/var/backup/mysql

COPY mysql-backup.sh /mysql-backup.sh
COPY run.sh /run.sh
