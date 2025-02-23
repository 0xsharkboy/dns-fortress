FROM pihole/pihole:latest

# Install and configure unbound
RUN apk add unbound && \
    mkdir -p /var/log/unbound && \
    touch /var/log/unbound/unbound.log && \
    chown unbound:unbound /var/log/unbound/unbound.log

COPY ./unbound.conf /etc/unbound/unbound.conf

# Replace upstream DNS with unbound (127.0.0.1#5335)
RUN sed -i '/^  upstreams = \[/,/^  \]/c\  upstreams = [\n    "127.0.0.1#5335"\n  ]' /etc/pihole/pihole.toml

# Run Unbound
CMD ["./entrypoint.sh"]
