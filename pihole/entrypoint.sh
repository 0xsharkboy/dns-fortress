#!/bin/sh

# Update root hints
wget https://www.internic.net/domain/named.root -qO- | tee /var/lib/unbound/root.hints

# Start unbound
unbound -d
