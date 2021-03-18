#!/bin/bash
#
# Is it possible to get a list of most recently installed packages?
#
# https://askubuntu.com/questions/17012/is-it-possible-to-get-a-list-of-most-recently-installed-packages
#
# Here is some shell to list dpkg installed files. (which should include all apt/aptitude/software center/synaptic installed packages)
#
grep -A 1 "Package: " /var/lib/dpkg/status | \
grep -B 1 -Ee "ok installed|half-installed|unpacked|half-configured|config-files" -Ee "^Essential:yes" | \
grep "Package:" | cut -d\  -f2
