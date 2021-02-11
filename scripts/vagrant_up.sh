#!/bin/bash
cd vagrant-protheus-core/linux/
vagrant status
vagrant up
vagrant ssh -c 'cd /totvs/scripts;./up-stack.sh' && vagrant ssh