# Branch: ZSH Plugin for GIT branch aliases

This is a *zsh* plugin to define the `branch` command, wrapping common git commands.

The `branch` output displays the original git command that was used, so you don't forget about real git.

It is similar to a simple set of aliases (like in the [git plugin of oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh/blob/master/plugins/git/git.plugin.zsh)), but with a little extra functionality, because it knows the current branch and can autocomplete accordingly.

The usage is quite intuitive:

    $ branch[enter]       #=> show branches
    $ branch [tab]        #=> show branches to autocomplete
    $ branch mast[tab]    #=> autocomplete with 'master', then you hit enter and checkout into master
    $ branch new <name>   #=> create and checkout new branch
    $ branch pull         #=> pull from origin, current branch
    $ branch pull master  #=> pull from origin/master and merge into current branch
    $ branch rm <b1> <b2> #=> removes both local and remote versions of branches b1 and b2

For more help, type `branch help`.

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

In you shell, cd into any git project, in branch master:

    (master)$ _

List branches (default):

    (master)$ branch
    * master
      other-branch

Change branch (note that branch [tab] will autocomplete with local branches):

    (master)$ branch other-branch
    > git checkout other-branch
    Switched to branch 'other-branch'

Pull changes from origin, to current branch:

    (other-branch)$ branch pull
    > git pull origin other-branch
    From github.com:whatever
     * branch            other-branch     -> FETCH_HEAD
    Already up-to-date.

Create branch and push to origin:

    (other-branch)$ branch new my-new-cool-branch
    > git checkout -b my-new-cool-branch
    Switched to a new branch 'my-new-cool-branch'

    (my-new-cool-branch)$ branch push
    > git push origin test-branch
    Total 0 (delta 0), reused 0 (delta 0)
    To git@github.com:whatever
     * [new branch]      my-new-cool-branch -> my-new-cool-branch

Delete both local and remote versions of my-new-cool-branch:

    (my-new-cool-branch)$ branch rm my-new-cool-branch
    > git checkout master
    Switched to branch 'master'
    > git checkout -d my-new-cool-branch
    Deleted branch my-new-cool-branch (was 6036aa3).
    > git push origin :my-new-cool-branch
    To git@github.com:whatever
     - [deleted]         my-new-cool-branch


### Recommended aliases:

You should do your own aliases that work for you. With branch, you can write more accurate easy-to-type commands.

For example, in your `~/.zshrc`:

    # GIT ALIASES
    alias br='branch'
    alias pull='branch pull'
    alias push='branch push'
    alias st='git status -s'
    alias cm='git commit -a -m'

Now your usual git commands will look like this:

    (master)$ pull                   # pull changes from master
    (master)$ br new mybr            # create a new branch and checkout
    (mybr)$ touch x
    (mybr)$ git add x                # add a new file
    (mybr)$ st                       # check status
    (mybr)$ cm "added a new x file"  # commit
    (mybr)$ push                     # push changes to origin/mybr
    (mybr)$ br m[tab][enter]         # use autocomplete to change back to master
    (master)$
