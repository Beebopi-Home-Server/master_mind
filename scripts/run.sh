#!/bin/bash

cd /opt/master_mind

mode=$1
if [ $mode == "--local" ]; then
    gunicorn -b 127.0.0.1:8000 main:app
else
    gunicorn -b 0.0.0.0:8000 main:app
fi
