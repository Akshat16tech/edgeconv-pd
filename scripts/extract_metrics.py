#!/usr/bin/env python3
import json, sys
from pathlib import Path
run = Path(sys.argv[1]) if len(sys.argv) > 1 else Path("runs")
latest = sorted(run.glob("*/"))[-1]
m = json.load(open(latest / "final" / "metrics.json"))
print(f"WNS: {m.get('route__timing__setup__wns', 'N/A')} ns")
print(f"Area: {m.get('floorplan__design__core__area', 'N/A')} um2")
print(f"Cells: {m.get('synthesis__design__instance__count__stdcell', 'N/A')}")
print(f"DRC: {m.get('magic__drc__error__count', 'N/A')}")
