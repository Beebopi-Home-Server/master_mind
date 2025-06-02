#!/bin/bash

cd /opt/master_mind
.venv/bin/gunicorn \
  -k uvicorn.workers.UvicornWorker \
  -w 4 \
  -b 0.0.0.0:8000 \
  main:app
