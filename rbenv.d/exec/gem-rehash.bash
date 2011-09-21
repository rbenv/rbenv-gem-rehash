#!/bin/sh
export GEM_PATH=$(`rbenv-which gem` env gempath):$RBENV_ROOT/gems
