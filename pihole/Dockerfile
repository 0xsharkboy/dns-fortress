FROM pihole/pihole:latest

# Install and configure unbound
RUN apk add unbound && \
    mkdir -p /var/log/unbound && \
    touch /var/log/unbound/unbound.log && \
    chown unbound:unbound /var/log/unbound/unbound.log

COPY ./unbound.conf /etc/unbound/unbound.conf.d/pi-hole.conf
COPY ./root.hints /var/lib/unbound/root.hint

# Run Unbound
CMD service unbound start
