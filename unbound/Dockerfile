FROM debian:bookworm-slim

# Disable interactions
ENV DEBIAN_FRONTEND=noninteractive

# Installer Unbound and wget
RUN apt-get update && \
    apt-get install -y unbound wget

# Copy Unbound config
COPY ./unbound.conf /etc/unbound/unbound.conf.d/pi-hole.conf

# Download root hints
RUN mkdir -p /var/lib/unbound/ && \
    wget https://www.internic.net/domain/named.root -qO- | tee /var/lib/unbound/root.hints

# Create Unbound log file
RUN mkdir -p /var/log/unbound && \
    touch /var/log/unbound/unbound.log && \
    chown unbound /var/log/unbound/unbound.log

# Expose Unbound ports
EXPOSE 5335/udp 5335/tcp

# Start unbound service and displayy logs
CMD service unbound start && tail -f /var/log/unbound/unbound.log

