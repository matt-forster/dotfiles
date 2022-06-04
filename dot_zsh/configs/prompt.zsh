# modify the prompt to contain git branch name if applicable
git_prompt_info() {
  current_branch=$(git current-branch 2> /dev/null)
  if [[ -n $current_branch ]]; then
	  echo " %F{082}($current_branch)%f"
  fi
}
setopt promptsubst

PS1='$FX[bold]%F{081}%c%f$FX[reset]$(git_prompt_info)$FX[reset] : '
