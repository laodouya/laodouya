function fish_prompt --description 'Write out the prompt'
	set -l last_status $status

	# Just calculate this once, to save a few cycles when displaying the prompt
	if not set -q __fish_prompt_hostname
		set -g __fish_prompt_hostname (ifconfig en0 | awk ' /inet /  { print $2 } '| cut -c1- | head -n1)
	end

	set -l normal (set_color normal)

	# Hack; fish_config only copies the fish_prompt function (see #736)
	if not set -q -g __fish_classic_git_functions_defined
		set -g __fish_classic_git_functions_defined

		function __fish_repaint_user --on-variable fish_color_user --description "Event handler, repaint when fish_color_user changes"
			if status --is-interactive
				commandline -f repaint ^/dev/null
			end
		end
		
		function __fish_repaint_host --on-variable fish_color_host --description "Event handler, repaint when fish_color_host changes"
			if status --is-interactive
				commandline -f repaint ^/dev/null
			end
		end
		
		function __fish_repaint_status --on-variable fish_color_status --description "Event handler; repaint when fish_color_status changes"
			if status --is-interactive
				commandline -f repaint ^/dev/null
			end
		end

		function __fish_repaint_bind_mode --on-variable fish_key_bindings --description "Event handler; repaint when fish_key_bindings changes"
			if status --is-interactive
				commandline -f repaint ^/dev/null
			end
		end

		# initialize our new variables
		if not set -q __fish_classic_git_prompt_initialized
			set -qU fish_color_user; or set -U fish_color_user -o green
			set -qU fish_color_host; or set -U fish_color_host -o cyan
			set -qU fish_color_status; or set -U fish_color_status red
			set -U __fish_classic_git_prompt_initialized
		end
	end

	set -l color_cwd
	set -l prefix
	switch $USER
	case root toor
		if set -q fish_color_cwd_root
			set color_cwd $fish_color_cwd_root
		else
			set color_cwd $fish_color_cwd
		end
		set suffix '#'
	case '*'
		set color_cwd $fish_color_cwd
		set suffix '>'
	end

	set -l prompt_status
	if test $last_status -ne 0
		set prompt_status ' ' (set_color $fish_color_status) "[$last_status]" "$normal"
	end

	set -l mode_str
	switch "$fish_key_bindings"
	case '*_vi_*' '*_vi'
		# possibly fish_vi_key_bindings, or custom key bindings
		# that includes the name "vi"
		set mode_str (
			echo -n " "
			switch $fish_bind_mode
			case default
				set_color --bold --background red white
				echo -n "[N]"
			case insert
				set_color --bold green
				echo -n "[I]"
			case visual
				set_color --bold magenta
				echo -n "[V]"
			end
			set_color normal
		)
	end

	echo -n -s (set_color $fish_color_user) "$USER" $normal @ (set_color $fish_color_host) (hostname) $normal ':' (set_color $color_cwd) (my_pwd) (__fish_git_prompt) $normal $prompt_status "$mode_str" ' ' (set_color $fish_color_host) (/bin/ls -1 | /usr/bin/wc -l | /usr/bin/sed "s: ::g") $normal "> "
end

function fish_right_prompt
    if test $CMD_DURATION
        # Show duration of the last command
        set duration (echo "$CMD_DURATION 1000" | awk '{printf "%.3fs", $1 / $2}')
        echo $duration

#        # OS X notification when a command takes longer than notify_duration
#        set notify_duration 10000
#        set exclude_cmd "bash|less|man|more|ssh"
#        if begin
#                test $CMD_DURATION -gt $notify_duration
#                and echo $history[1] | grep -vqE "^($exclude_cmd).*"
#            end
#
#            # Only show the notification if iTerm is not focused
#            echo "
#                tell application \"System Events\"
#                    set activeApp to name of first application process whose frontmost is true
#                    if \"iTerm\" is not in activeApp then
#                        display notification \"Finished in $duration\" with title \"$history[1]\"
#                    end if
#                end tell
#                " | osascript
#        end
    end
end
