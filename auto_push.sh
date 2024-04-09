#!/bin/bash

cd /root/Desktop/pnpt

while true; do
	git add .
	git commit -m "Update Git Repo"
	git push origin master
	sleep 300 # WAIT for 5 miutes before checking again
done
