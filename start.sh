#!/bin/bash

set -eu

chown -R cloudron:cloudron /app/data

echo "==> Starting Folding@Home"
exec FAHClient --config "$1"
