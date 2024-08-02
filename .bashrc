#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Determine size of a file or total size of a directory
function fs() {
	if du -b /dev/null > /dev/null 2>&1; then
		local arg=-sbh;
	else
		local arg=-sh;
	fi
	if [[ -n "$@" ]]; then
		du $arg -- "$@";
	else
		du $arg .[^.]* ./*;
	fi;
}

## get the current weather based in ur current location
function weather() {
	curl "https://wttr.in/Ivanovo"
}

# Start an HTTP server from a directory, optionally specifying the port
function server() {
	if [ -z "$1" ]; then
	    port=8080
	else
	    port=$1
	fi
	python -m http.server $port
}

# Start yazi
function walk() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

## Extracts whatever you feed it
extract() {
	if [ "${1}" = "" ] || [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
		echo "Usage: extract <archive> [directory]"
		echo "Example: extract presentation.zip."
		echo "Valid archive types are:"
		echo "tar.bz2, tar.gz, tar.xz, tar, bz2, gz, tbz2,"
		echo "tbz, tgz, lzo, rar, zip, 7z, xz, txz, lzma and tlz"
	else
		case "$1" in
		*.tar.bz2 | *.tbz2 | *.tbz) tar xvjf "$1" ;;
		*.tgz) tar zvxf "$1" ;;
		*.tar.gz) tar xvzf "$1" ;;
		*.tar.xz) tar xvJf "$1" ;;
		*.cbt | *.tar) tar xvf "$1" ;;
		*.cbr | *.rar) unrar x -ad "$1" ;;
		*.cbz | *.epub | *.zip) unzip "$1" ;;
		*.lzo) lzop -d "$1" ;;
		*.gz) gunzip "$1" ;;
		*.bz2) bunzip2 "$1" ;;
		*.Z) uncompress "$1" ;;
		*.xz | *.txz | *.lzma | *.tlz) xz -d "$1" ;;
		*.exe) cabextract ./"$1" ;;
		*.cpio) cpio -id <./"$1" ;;
		*.cba | *.ace) unace x ./"$1" ;;
		*.7z | *.arj | *.cab | *.cb7 | *.chm | *.deb | *.dmg | *.iso | *.lzh | *.msi | *.pkg | *.rpm | *.udf | *.wim | *.xar)
			7z x "$1"
			;;
		*) echo "Faild extracting, '$1' - unknown archive method" ;;
		esac
	fi
}

PS1='[\u@\h \W]\$ '

alias edit='sudo micro'
alias :q="exit"
alias q="exit"
alias cls="clear"
alias tree="tree -a"
alias poweroff="sudo poweroff"
alias reboot="sudo reboot"
# video
## Play audio files in current dir by type
alias play_wav="vlc *.wav"
alias play_ogg="vlc *.ogg"
alias play_mp3="vlc *.mp3"
## Play video files in current dir by type
alias play_avi="vlc *.avi"
alias play_mov="vlc *.mov"
alias play_mp4="vlc *.mp4"
# ls
alias ls='ls --color=auto'
alias ll='ls -la'
alias la='ls -a'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
# cd
alias ..='cd ..'
alias ~='cd ~'
# pacman
alias pac-down='sudo pacman -Syuu'
alias pac-local='sudo pacman -U'
alias pac-install='sudo pacman -S'
alias pac-installed='sudo pacman -Qs'
alias pac-info='sudo pacman -Qi'
alias pac-list='sudo pacman -Ql'
alias pac-search='sudo pacman -Ss'
alias pac-update='sudo pacman -Syu'
alias pac-upgrade='sudo pacman -Syyu'
alias pac-remove='sudo pacman -R'
alias pac-purge='sudo pacman -Rnsc'
# yay
alias yay-config="yay -Pg" ## Print current config
alias yay-upgrade="yay -Sua" ## Update only AUR pkgs
alias yay-install="yay -S"               ## Install pkgs from the repo using "YAY"
alias yay-local="yay -U"         ## Install pkgs from a local file usnig "YAY"
alias yay-dep="yay -S --asdeps" ## Install pkgs as dependencies of another pkg using "YAY"
alias yay_info="yay -Qi" ## Query installed pkgs and their files
alias yay_list="yay -Ql" ## List files in a pkg
alias yay-search="yay -Ss"
alias yay-installed="yay -Qe"
alias yay-repo="yay -Si" ## Display info about a pkg in the repo
# systemctl
alias sys_list_failed_units="systemctl list-units --failed"
alias sys_start="sudo systemctl start"
alias sys_stop="sudo systemctl stop"

alias sys_enable="sudo systemctl enable"
alias sys_enable_now="sudo systemctl enable --now"
alias sys_disable="sudo systemctl disable"
alias sys_disable_now="sudo systemctl disable --now"
alias sys_reenable="sudo systemctl reenable"
alias sys_preset="sudo systemctl preset" ## Reset the enable/disable status for 1/more units

alias sys_load="sudo systemctl load"
alias sys_reload="sudo systemctl reload"
alias sys_restart="sudo systemctl restart"
alias sys_daemon_reload="sudo systemctl daemon-reload"
alias sys_try_restart="sudo systemctl try-restart"
alias sys_show_failed="sudo systemctl --state=failed"
alias sys_reset_filad="sudo systemctl reset-failed" ## Reset the failed state of the specified unit/s
alias sys_cancel="sudo systemctl cancel"

alias sys_mask="sudo systemctl mask"
alias sys_unmask="sudo systemctl unmask"
alias sys_mask-now="sudo systemctl mask --now"

alias sys_link="sudo systemctl link"       ## Link a unit file into the unit file search path
alias sys_isolate="sudo systemctl isolate" ## Start a unit & its deps && stop all others
alias sys_edit="sudo systemctl edit"       ## Edit a drop-in snippet or a whole replacement file with --full

alias sys_set_env="sudo systemctl set-environment"     ## Set 1/more systemd manager environment vars
alias sys_unset_env="sudo systemctl unset-environment" ## Unset 1/more systemd manager environment vars
alias sys_kill="sudo systemctl kill"

alias sys_is_enabled="systemctl is-enabled"           ## Checks if any oth the specified unit/s are enabled
alias sys_list_units="systemctl list-units"           ## List all units systemd has in memory
alias sys_list_timers="systemctl list-timers"         ## List timer units currently in memory
alias sys_list_unit-files="systemctl list-unit-files" ## List unit files installed on the system
alias sys_list_jobs="systemctl list-jobs"             ## List jobs that in progress
alias sys_is_active="systemctl is-active"             ## Show wheather a unit's active
alias sys_status="systemctl status"                   ## Show runtime status info about 1/more units
alias sys_show="systemctl show"                       ## Show proerities of units, jobs, or the manager itself
alias sys_help="systemctl help"                       ## Show the man page of units
alias sys_show-env="systemctl show-environment"       ## Dump the systemd manager env block
alias sys_cat="systemctl cat"                         ## Show backing files of 1/more units
alias jctl="journalctl -p 3 -xb"

alias find-file="find . -type f -name" ## Find a file with the given name
alias find-dir="find . -type d -name" ## Find a dir with the given name
alias last-dir="dirs -v"              ## lists last visited directories
alias unlock='sudo rm /var/lib/pacman/db.lck'
alias mirror='sudo reflector --completion-percent 100 -p https -f 15 -c Russia,Romania,Ukraine,Uzbekistan,Kazakhstan,Serbia,Czechia,Bulgaria'
# Print each PATH entry on a separate line
alias path='echo -e ${PATH//:/\\n}'
alias shutdown='sudo shutdown now'
alias reboot='sudo reboot'

export GTK_THEME=Adwaita:dark
export QT_STYLE_OVERRIDE=Adwaita-Dark
export GTK2_RC_FILES=/usr/share/themes/Adwaita-dark/gtk-2.0/gtkrc
export EDITOR='micro'
export BROWSER='firefox'
# Increase Bash history size. Allow 32³ entries; the default is 500.
export HISTSIZE='32768'
export HISTFILESIZE="${HISTSIZE}"
# Omit duplicates and commands that begin with a space from history.
export HISTCONTROL='ignoreboth'
# Prefer US English and use UTF-8.
export LANG='en_US.UTF-8'
export LC_ALL='en_US.UTF-8'
export LC_TIME="ru_RU.UTF-8"

export PATH=$PATH:~/Scripts

fastfetch

if [ -z "$DISPLAY" ] && [ "$XDG_VTNR" = 1 ]; then
  exec startx
fi
