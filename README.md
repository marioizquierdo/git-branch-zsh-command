# Branch: ZSH Plugin for GIT easy branch management

This is a zsh plugin to define the `branch` command. This is designed just to wrap the git commands that I most use, to let me work in a [gitflow](https://github.com/nvie/gitflow) way without hassle, without having to use a heavy plugin or other git commands.

In fact, any `branch` command will display the original git command that was used, so you don't forget about real git.


### Installation

  * Copy the branch folder to .oh-my-zsh/custom/plugins
  * Enable the plugin in your `.zshrc` file (add to the plugins list)
  * Type `source ~/.zshrc`, or just restart the terminal (to activate the plugin)


### Usage

Help:

  branch -h

#### Example usage:

In you shell, go to any git project, for example 'project' in branch master:

    [zsh]project(master)$ _

See branches:

    [zsh]project(master)$ branch
    * master
      other-branch

Change branch (note that branch [tab] ):

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

More examples:

    $ branch help

### Write more aliases to make it better:

You should do your own aliases that work for you, but here you are an example of what I use in my shell,

in my ~/.zshrc

    # GIT ALIASES
    alias st='git status -s'
    alias commit='git commit -a -m'
    alias cm='commit'
    alias pull='branch pull'
    alias push='branch push'

So now my usual git flow can be like this:

    (master)$ pull  # pull changes from master
    (master)$ branch new new-branch  # create a new branch and checkout
    (new-branch)$ touch x
    (new-branch)$ git add x  # add a new file
    (new-branch)$ st  # check status
    (new-branch)$ cm "added a new x file"  # commit
    (new-branch)$ push  # push changes to origin/new-branch
    (new-branch)$ branch m[tab][enter]  # use autocomplete to change back to master
    (master)$
