#!/bin/sh

CONTAINER_HOSTNAME=$(python get_hostname.py)

export CONTAINER_HOSTNAME

exec python main.py