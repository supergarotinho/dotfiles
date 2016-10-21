
ZSH_THEME_GIT_PROMPT_PREFIX=" %{$fg[green]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%}!"
ZSH_THEME_GIT_PROMPT_CLEAN=""

function prompt_char {
	if [ $UID -eq 0 ]; then echo "%{$fg[red]%}#%{$reset_color%}"; else echo $; fi
}

if [[ $terminfo[colors] -ge 256 ]]; then
    turquoise="%F{81}"
    orange="%F{166}"
    purple="%F{135}"
    hotpink="%F{161}"
    limegreen="%F{118}"
else
    turquoise="%F{cyan}"
    orange="%F{yellow}"
    purple="%F{magenta}"
    hotpink="%F{red}"
    limegreen="%F{green}"
fi

git_changes() {
	local s='';

	# Check if the current directory is in a Git repository.
	if [[ $(git rev-parse --is-inside-work-tree &>/dev/null; echo "${?}") == '0' ]]; then

		# check if the current directory is in .git before running git checks
		if [[ "$(git rev-parse --is-inside-git-dir 2> /dev/null)" == 'false' ]]; then

			# Ensure the index is up to date.
			git update-index --really-refresh -q &>/dev/null;

			# Check for uncommitted changes in the index.
			if ! $(git diff --quiet --ignore-submodules --cached); then
				s+='+';
			fi;

			# Check for unstaged changes.
			if ! $(git diff-files --quiet --ignore-submodules --); then
				s+='!';
			fi;

			# Check for untracked files.
			if [ -n "$(git ls-files --others --exclude-standard)" ]; then
				s+='?';
			fi;

			# Check for stashed files.
			if $(git rev-parse --verify refs/stash &>/dev/null); then
				s+='$';
			fi;

		fi;

		[ -n "${s}" ] && s="[${s}]";

		echo -e "${s}";
	else
		return;
	fi;
}

git_branch() {
	local branchName='';

	# Check if the current directory is in a Git repository.
	if [[ $(git rev-parse --is-inside-work-tree &>/dev/null; echo "${?}") == '0' ]]; then

		# Get the short symbolic ref.
		# If HEAD isn’t a symbolic ref, get the short SHA for the latest commit
		# Otherwise, just give up.
		branchName="$(git symbolic-ref --quiet --short HEAD 2> /dev/null || \
			git rev-parse --short HEAD 2> /dev/null || \
			echo '(unknown)')";

		echo -e "${1}${branchName}";
	else
		return;
	fi;
}
# %{$fg[purple]%}$(git_branch " on")%{$reset_color%} %{$fg[green]%}$(git_changes)%{$reset_color%}

#%{$orange%}%{$reset_color%}

PROMPT='%(?, ,%{$fg[red]%}FAIL%{$reset_color%}
)
%{$orange%}%n%{$reset_color%}@%{$fg[yellow]%}%m%{$reset_color%}: %{$fg_bold[blue]%}%~%{$reset_color%} $(git_branch "on %{$fg[magenta]%}")%{$reset_color%} %{$fg[green]%}$(git_changes)%{$reset_color%}
%_ $(prompt_char) '

RPROMPT='%{$fg[green]%}[%*]%{$reset_color%}'
