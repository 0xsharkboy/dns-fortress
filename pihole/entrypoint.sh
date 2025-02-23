#!/bin/sh

# Update root hints
UNBOUND_LIB_DIR=/var/lib/unbound
if [ ! -f "$UNBOUND_LIB_DIR" ]; then
    mkdir -p $UNBOUND_LIB_DIR
fi
wget https://www.internic.net/domain/named.root -qO- | tee ${UNBOUND_LIB_DIR}/root.hints

# Start unbound
unbound -d
