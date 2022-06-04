#! /bin/bash
cd
sh -c "$(curl -fsLS chezmoi.io/get)"
./bin/chezmoi init -v matt-forster --apply --one-shot


