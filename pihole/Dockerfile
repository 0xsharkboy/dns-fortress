FROM pihole/pihole:2025.02.4

# Install and configure unbound
RUN apk add --no-cache unbound && \
    mkdir -p /var/log/unbound && \
    touch /var/log/unbound/unbound.log && \
    chown unbound:unbound /var/log/unbound/unbound.log

COPY ./unbound.conf /etc/unbound/unbound.conf

RUN mkdir -p /var/lib/unbound

# Run Unbound
COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ./entrypoint.sh
