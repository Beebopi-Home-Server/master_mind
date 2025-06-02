#!/bin/bash

cd /opt/master_mind
python -m gunicorn -b 0.0.0.0:8000 main:app
