#
# Command to list branches, create a new branch or checkout to another existing branch. Examples:
# type branch -h for help
#
function branch() {
  case $1 in
    (help | -h)
      print "Wrapper for git branch management. Usage:
      branch help               #=> print this help
      branch                    #=> list local branches
      branch [tab]              #=> autocomplete with branches where you can switch
      branch <other-branch>     #=> change current branch to <other-branch>
      branch go <other-branch>  #=> change current branch to <other-branch>
      branch new <new-branch>   #=> creates the <new-branch> and change current branch to <new-branch>
      branch push               #=> push current branch commits to origin
      branch pull               #=> push current branch commits to origin
      branch remove [<oldb>]    #=> removes both local and remote versions of the current branch
      branch current            #=> display current branch
      "
      ;;
    ('')
      git branch
      ;;
    (current)
      ref=$(git symbolic-ref HEAD 2> /dev/null) || return
      echo ${ref#refs/heads/}
      ;;
    (new)
      printdo git checkout -b $2
      ;;
    (push)
      printdo git push origin $(branch current)
      ;;
    (pull)
      printdo git pull origin $(branch current)
      ;;
    (remove | delete | rm)
      if [[ $2 = '' ]]; then
        local branch_to_remove=$(branch current)
        branch master
      else
        local branch_to_remove=$2
      fi
      printdo git branch -d $branch_to_remove && git push origin :$branch_to_remove
      ;;
    (go | checkout)
      printdo git checkout $2
      ;;
    (*)
      printdo git checkout $1
      ;;
  esac
}

#
# Prints a command and then execute it
#
function printdo() {
  print "\033[1;35m> $*\033[0m"
  $*
}

# Autocomplete for 'branch'
compdef _git branch=git-branch