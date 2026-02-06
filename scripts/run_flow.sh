#!/bin/bash
set -e
echo "Running OpenLane2 for EdgeConv..."
docker run --rm -v $(pwd):/work -w /work/openlane \
  efabless/openlane2:latest \
  python3 -m openlane --flow Classic --config config_typical.json
echo "Done! Check runs/ directory"
