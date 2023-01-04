#!/usr/bin/env bash

# WARNING! this has a vulnerability
# to fix this properly, see https://stackoverflow.com/a/73027407/11756613
# (I tried, but audit fix didn't work for me, and I couldn't find webpack config, so I left it this way)
export NODE_OPTIONS=--openssl-legacy-provider
# fixed using this answer: https://stackoverflow.com/a/73604364/11756613
# WARNING! this is also insecure
export LD_LIBRARY_PATH=$HOME/opt/lib:$LD_LIBRARY_PATH

trap "trap - SIGTERM && kill -- -$$" SIGINT SIGTERM EXIT

(cd ~/projects/diplomacy/diplomacy/web; npm start) &

(cd ~/projects/diplomacy; source venv/bin/activate; python -m diplomacy.server.run) &

(cd ~/projects/diplomacy_research; source venv/bin/activate; export PYTHONPATH="${PYTHONPATH}:~/projects/diplomacy_research"; python diplomacy_research/scripts/launch_bot.py) &

sleep infinity
