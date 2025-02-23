FROM mvance/unbound:1.21.1

# Copy unbound config
COPY ./unbound.conf /opt/unbound/etc/unbound/unbound.conf

# Download root hints
RUN mkdir -p /var/lib/unbound/ && \
    wget https://www.internic.net/domain/named.root -qO- | tee /var/lib/unbound/root.hints

# Create log file
RUN mkdir -p /var/log/unbound && \
    touch /var/log/unbound/unbound.log
