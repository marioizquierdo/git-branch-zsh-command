#
# Command to list branches, create a new branch or checkout to another existing branch. Examples:
# type branch -h for help
#
function branch() {
  case $1 in
    (-h)
      print "Wrapper for git branch management. Usage:
      branch -h                 #=> print this help
      branch [tab]              #=> show branches and actions (using zsh autocomplete)
      branch                    #=> list local branches
      branch current            #=> display current branch
      branch <other-branch>     #=> change current branch to <other-branch>
      branch new <new-branch>   #=> creates the <new-branch> and change current branch to <new-branch>
      branch push               #=> push current branch commits to origin
      branch pull               #=> push current branch commits to origin
      branch remove             #=> removes both local and remote versions of the current branch
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
    (-remove)
      printdo git branch -d $2 && git push origin :$2
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