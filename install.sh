#!/usr/bin/bash

if [ $# -eq 0 ]; then

	# Execute the init.sh file for each module
	while read -r module; do
		if [[ $module =~ \#.* ]]; then
			continue
		fi

		bash -c "./$module/init.sh"
	done <"$PWD"/modules
else
	bash -c "./$1/init.sh"
fi

fish -c "fish_update_completions"
