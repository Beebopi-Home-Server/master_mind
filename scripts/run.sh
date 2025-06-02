#!/bin/bash

cd /opt/master_mind

mode=$1
if [ $mode == "--local" ]; then
    python -m gunicorn -b 127.0.0.1:8000 main:app
else if [ $mode == "--docker" ]; then
    python -m gunicorn -b 172.17.0.1:8000 main:app
else
    python -m gunicorn -b 0.0.0.0:8000 main:app
fi
