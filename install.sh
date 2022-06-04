#! /bin/bash
cd
sh -c "$(curl -fsLS chezmoi.io/get)" -- init -v matt-forster --apply --one-shot
