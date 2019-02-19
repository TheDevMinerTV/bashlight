#!/usr/bin/env bash

####################################################################################
# Bashlight 	: 0.2.2
# Copyright		: 2019, MIT
# Author		: André Lademann <vergissberlin@googlemail.com>
# Repository	: https://github.com/vergissberlin/bashlight
####################################################################################

# Load configuration
readonly THIS_FILE=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

# shellcheck source=config.bash
. "${THIS_FILE}/config.bash"

# Copying over all required files to ~/.bin/bashlight
mkdir ~/.bin/
mkdir "${BASHLIGHT_PATH}"
cp -r assets bashlight config.bash config install/ migrate.bash src/ update.bash .git "${BASHLIGHT_PATH}"
echo "if [ -d ${BASHLIGHT_PATH}/bashlight ]; then . ${BASHLIGHT_PATH}/bashlight; fi" >> ~/.bashrc
echo "    ✓  Bashlight has been successfully installed!"

# shellcheck source=install/git.bash
. "${BASHLIGHT_PATH}/install/git.bash"

# shellcheck source=install/tmux.bash
. "${BASHLIGHT_PATH}/install/tmux.bash"
