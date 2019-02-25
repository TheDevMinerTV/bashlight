#!/usr/bin/env bash

#######################################################################################################
# Bashlight 	: 0.2.2
# Copyright		: 2019, MIT
# Author		: André Lademann <vergissberlin@googlemail.com>, TheDevMinerTV <tobigames200@gmail.com>
# Repository	: https://github.com/vergissberlin/bashlight
#######################################################################################################

# Load configuration
readonly THIS_FILE=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

# shellcheck source=config.bash
. "${THIS_FILE}/config.bash"

# Copying over all required files to ~/.bin/bashlight
for INSTALL_DIR="$HOME/.bin/bashlight"

install_bashlight() {
	for FILE in "$REQUIRED_FILES"
	do
    	mv -r "$FILE" "$INSTALL_DIR" || exit
	done
}


echo "    🛈  Checking for bashrc for bashlight!"


grep -q 'if \[ -f ~/.bin/bashlight/bashlight \]' ~/.bashrc
newInstall=$?

grep -q 'if \[ -f ~/bashlight/bashlight \]' ~/.bashrc
oldInstall=$?

if [[ "${newInstall}" == 0 ]]
then
	echo "    🛈  Bashlight is already in bashrc!"
	if [ ! -d ~/.bin ]; then
		mkdir ~/.bin/
		if [ ! -d ~/.bin/bashlight ]; then
			mkdir "$INSTALL_DIR"
			echo "    🛈  Creating ${INSTALL_DIR}!"
		fi
	fi
	echo "    🛈  Installing bashlight into ${INSTALL_DIR}!"
	install_bashlight
elif [[ "${oldInstall}" == 0 ]]
then
	echo "    🛈  Migrating from old bashlight!"
	./migrate.bash
else
	echo "    🛈  Adding bashlight to bashrc!"
	echo "if [ -f ${INSTALL_DIR}/bashlight ]; then . ${INSTALL_DIR}/bashlight; fi" >> ~/.bashrc
	if [ ! -d ~/.bin ]; then
		mkdir ~/.bin/
		if [ ! -d ~/.bin/bashlight ]; then
			mkdir "$INSTALL_DIR"
			echo "    🛈  Creating ${INSTALL_DIR}!"
		fi
	fi
	echo "    🛈  Installing bashlight into ${INSTALL_DIR}!"
	install_bashlight
fi

unset install_bashlight

echo "    ✓  Bashlight has been successfully installed!"

# shellcheck source=install/git.bash
. "${BASHLIGHT_PATH}/install/git.bash"

# shellcheck source=install/tmux.bash
. "${BASHLIGHT_PATH}/install/tmux.bash"
