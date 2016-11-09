#!/bin/sh

errbot_venv=".errbot-venv"

die() {
  local exit_code=$?
  [ $exit_code -eq 0 ] && exit_code=1
  echo "ERROR: $@" >&2
  exit $exit_code
}

# Prerequisites:
# - python3
command -v python3 >/dev/null 2>&1 || die "python3 not installed."
# - virtualenv
command -v virtualenv >/dev/null 2>&1 || die "virtualenv not installed. (pip install virtualenv)"

virtualenv --python "$(which python3)" "$errbot_venv" || die "Could not create virtual environment."

pip() {
  "${errbot_venv}/bin/pip" "$@"
}

pip install errbot || die "Could not install errbot."
pip install slackclient || die "Could not install slackclient."

mkdir data
ln -s "${errbot_venv}/bin/errbot" errbot
