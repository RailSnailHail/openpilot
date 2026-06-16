#!/usr/bin/env bash

export PASSIVE="0"
export NOBOARD="1"
export SIMULATION="1"
export SKIP_FW_QUERY="1"
export FINGERPRINT="HONDA_CIVIC_2022"

# Keep loggerd and encoderd running so qlog/rlog/camera files are produced (needed for CI artifacts)
export BLOCK="${BLOCK},camerad,micd,logmessaged,manage_athenad"
if [[ "$CI" ]]; then
  # offscreen UI and audio aren't needed in CI and only add CPU load on the free runner
  export BLOCK="${BLOCK},ui,soundd"
fi

python3 -c "from openpilot.selfdrive.test.helpers import set_params_enabled; set_params_enabled()"

SCRIPT_DIR=$(dirname "$0")
OPENPILOT_DIR=$SCRIPT_DIR/../../

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
cd $OPENPILOT_DIR/system/manager && exec ./manager.py > /tmp/manager.log 2>&1
