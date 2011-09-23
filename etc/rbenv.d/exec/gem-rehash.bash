#!/bin/sh

cwd="$(pwd)"
cd "${script%/*}/../../.."
export GEM_PATH="$(pwd):${GEM_PATH}"
cd "$cwd"
