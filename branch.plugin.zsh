#
# Command to list branches, create a new branch or checkout to another existing branch. Examples:
# type branch -h for help
#
function branch() {
  case $1 in
    (help | -h | --help)
      print "Wrapper for git branch management. Usage:
      branch help               #=> print this help
      branch                    #=> list local branches
      branch current            #=> display current branch
      branch [tab]              #=> autocomplete with local branches
      branch <other-branch>     #=> change current branch to <other-branch>
      branch go <other-branch>  #=> change current branch to <other-branch>
      branch new <new-branch>   #=> creates and and checkout <new-branch>
      branch push [<branch>]    #=> push <branch> [default current branch] commits to origin
      branch pull [<branch>]    #=> pull <branch> [default current branch] from origin
      branch pullrebase [<b>]   #=> same as pull, but rebase local commits on top of origin (git pull --rebase)
      branch rm [<branch>]      #=> removes both local and remote versions of <branch> [default current branch]
      branch RM [<branch>]      #=> same as rm but forces removal of local branch even if is not fully merged
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
      local branch_to_push=$2; : ${branch_to_push:=$(branch current)}
      printdo git push origin $branch_to_push
      ;;
    (pull)
      local branch_to_pull=$2; : ${branch_to_pull:=$(branch current)}
      printdo git pull origin $branch_to_pull
      ;;
    (pullrebase)
      local branch_to_pull=$2; : ${branch_to_pull:=$(branch current)}
      printdo git pull --rebase origin $branch_to_pull
      ;;
    (remove | rm | RM)
      local branch_to_remove=$2; : ${branch_to_remove:=$(branch current)}
      if [[ $branch_to_remove = $(branch current) ]]; then
        branch master
      fi
      if [[ $1 = RM ]]; then
        printdo git branch -D $branch_to_remove
      else
        printdo git branch -d $branch_to_remove
      fi
      printdo git push origin :$branch_to_remove
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