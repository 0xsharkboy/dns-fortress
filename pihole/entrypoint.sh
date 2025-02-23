#!/bin/sh

# Update root hints
wget https://www.internic.net/domain/named.root -qO- | tee ${UNBOUND_LIB_DIR}/root.hints

# Start unbound
unbound -d
