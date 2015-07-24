# Branch: ZSH Plugin for GIT easy branch management

This is a *zsh* plugin to define the `branch` command, designed to just wrap the git commands that I most use, in an intuitive way, to let me handle [gitflow](https://github.com/nvie/gitflow) without hassle, without having to use a heavy plugin or other git commands.

In fact, the command output will display the original git command that was used, so you don't forget about real git.

It is similar to a simple set of aliases (like in the [git plugin of oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh/blob/master/plugins/git/git.plugin.zsh)), but with a little extra functionality, because it knows the current branch and can autocomplete accordingly.

It's all about making it intuitive:

    $ branch[enter]      #=> show branches
    $ branch [tab]       #=> show branches to autocomplete
    $ branch mast[tab]   #=> autocomplete with 'master', then you hit enter and checkout into master
    $ branch new <name>  #=> create and checkout new branch
    $ branch pull        #=> pull from origin the remote branch with the same name as current branch
    $ branch pull master #=> pull from origin/master and merge into current branch
    $ branch remove      #=> removes both local and remote versions of the current branch


### Installation
If you are using oh-my-zsh:

Copy the branch folder to `.oh-my-zsh/custom/plugins`, for example:
```
cd ~/.oh-my-zsh/custom/plugins
git clone git@github.com:marioizquierdo/git-branch-zsh-command.git branch
```
Enable the plugin in your `.zshrc` file. Edit `~/.zshrc` to activate the plugin, for example: `plugins=(branch)`
And restart the terminal to apply (or just type `source ~/.zshrc`).


### Usage

In you shell, go to any git project, for example 'project' in branch master:

    [zsh]project(master)$ _

See branches (actually same as git branch):

    [zsh]project(master)$ branch
    * master
      other-branch

Change branch (note that branch [tab] will autocomplete with local branches):

    [zsh]project(master)$ branch other-branch
    > git checkout other-branch
    Switched to branch 'other-branch'

Pull changes from origin, to current branch:

    [zsh]project(other-branch)$ branch pull
    > git pull origin other-branch
    From github.com:whatever
     * branch            other-branch     -> FETCH_HEAD
    Already up-to-date.

Create branch and push to origin:

    [zsh]project(other-branch)$ branch new my-new-cool-branch
    > git checkout -b my-new-cool-branch
    Switched to a new branch 'my-new-cool-branch'

    [zsh]project(my-new-cool-branch)$ branch push
    > git push origin test-branch
    Total 0 (delta 0), reused 0 (delta 0)
    To git@github.com:whatever
     * [new branch]      my-new-cool-branch -> my-new-cool-branch

Delete both local and remote versions of my-new-cool-branch:

    [zsh]project(my-new-cool-branch)$ branch rm
    > git checkout master
    Switched to branch 'master'
    > git checkout -d my-new-cool-branch
    Deleted branch my-new-cool-branch (was 6036aa3).
    > git push origin :my-new-cool-branch
    To git@github.com:whatever
     - [deleted]         my-new-cool-branch


### Write more aliases to make it better:

You should do your own aliases that work for you. With branch, you can write more accurate easy-to-type commands.

For example, in my `~/.zshrc`:

    # GIT ALIASES
    alias st='git status -s'
    alias cm='git commit -a -m'
    alias pull='branch pull'
    alias push='branch push'

Now my usual git flow looks be like this:

    (master)$ pull                         # pull changes from master
    (master)$ branch new new-branch        # create a new branch and checkout
    (new-branch)$ touch x
    (new-branch)$ git add x                # add a new file
    (new-branch)$ st                       # check status
    (new-branch)$ cm "added a new x file"  # commit
    (new-branch)$ push                     # push changes to origin/new-branch
    (new-branch)$ branch m[tab][enter]     # use autocomplete to change back to master
    (master)$
