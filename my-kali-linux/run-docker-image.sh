#!/bin/bash
set -e
x11docker --desktop --sudouser=nopasswd --user=RETAIN --network --clipboard=yes --name=mykali mykali:latest