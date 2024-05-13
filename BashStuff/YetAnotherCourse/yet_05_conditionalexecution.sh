#!/usr/bin/env bash

# Let's re-check set -e

#false || exit 1
#echo "This line won't run"

set -e

false || true
echo "This line runs. '-e' doesn't matter here because the whole OR statement is taken into account and it returns a valid value."

#As seen before, this will fail if we also add '-o pipefail'. We can join these two with set '-eo pipefail'
