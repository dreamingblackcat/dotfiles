# How to kill a delayed_job worker.

# Utility functions and aliases
function kill_delaybed_job() {
  echo "Killing delayed_job worker...";
  ps aux | grep jobs | grep -v grep | awk '{print $2}' | xargs kill -9
}
alias kjobs=kill_delaybed_job


function create_github_pr() {
  branch=$(git rev-parse --abbrev-ref HEAD)

  if [[ ! $branch ]]; then
    echo "You are not on a git repo. Please use this command inside a git repo."
    return 1
  fi

  if [[ $branch == "stable" ]]; then
    echo "You are on master branch. Please checkout to a feature branch."
    return 1
  fi

  if [[ ! $1 ]]; then
    base="stable"
  else
    base="$1"
  fi

  RED='\033[0;31m'
  NC='\033[0m' # No Color
  echo "Creating PR with base: ${RED}${base}${NC} and branch: ${RED}${branch}${NC}"
  gh pr create --title "${branch}" --assignee @me --base "${base}" --web
}
alias ghpr=create_github_pr

# Resolving confliciting awscli clients
# Thingaha aws
alias taws="$HOME/opt/anaconda3/envs/thingaha/bin/aws"

# Workcloud aws
alias waws="/usr/local/bin/aws"

alias rrpr="ghpr relationship_refactoring_master_branch_WEB-23229"

function release_pr(){
  ./merge_to_production.sh
}
