#! /bin/bash

sh -c "$(curl -fsLS chezmoi.io/get)" -- init
chezmoi update
