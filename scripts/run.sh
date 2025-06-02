#!/bin/bash

cd /opt/master_mind
.venv/bin/gunicorn -b 0.0.0.0:8000 main:app
