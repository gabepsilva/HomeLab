#!/usr/bin/env bash


scp * bob.psilva.org:/tmp


ssh bob.psilva.org "bash /tmp/remote-exp.sh"
