# Branch: ZSH Plugin for GIT easy branch management

This is a zsh plugin to define the `branch` command. This is designed just to wrap the git commands that I most use, to let me work in a [gitflow](https://github.com/nvie/gitflow) way without hassle, without having to use a heavy plugin or other git commands.

In fact, any `branch` command will display the original git command that was used, so you don't forget about real git.


### Installation

  * Copy the branch folder to .oh-my-zsh/custom/plugins
  * Enable the plugin in your `.zshrc` file (add to the plugins list)
  * Type `source ~/.zshrc`, or just restart the terminal (to activate the plugin)

### Usage


In you shell, go to any git project:

    [zsh]project(master)$ _

See branches:

    [zsh]project(master)$ branch
    * master
      other-branch

Change branch:

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

And More ...

    [zsh]project(master)$ branch help



### Example

My git flow is usually something like this:

  * create a new branch
  * make changes and commit
  * push changes to origin
  * Change branch
  * pull changes from origin
  * make changes and commit
  * push changes to origin
  * go back to master
  * merge changes in master (preferably through a pull request)
  * remove branches

To achieve this, using plain git, I would type something liske this:

    (master)$ git checkout -b new-branch

    # make some changes
    (new-branch)$ git commit -a -m "chanegs done..."
    (new-branch)$ git push origin new-branch

    (new-branch)$ git branch
    (new-branch)$ git checkout other-branch
    (other-branch)$ git pull origin other-branch
    # make some changes
    (other-branch)$ git commit -a -m "chanegs done..."
    (other-branch)$ git push origin other-branch

    (other-branch)$ git checkout master

    (master)$ git merge other-branch
    (master)$ git branch -d other-branch
    (master)$ git push origin :other-branch

    (master)$ git merge new-branch
    (master)$ git branch -d new-branch
    (master)$ git push origin :new-branch

With the branch command, it will be simplified to:

    (master)$ branch new new-branch

    # make some changes
    (new-branch)$ git commit -a -m "chanegs done..."
    (new-branch)$ branch push

    (new-branch)$ branch
    (new-branch)$ branch other-branch
    (other-branch)$ branch pull
    # make some changes
    (other-branch)$ git commit -a -m "chanegs done..."
    (other-branch)$ branch push

    (other-branch)$ branch master
    (master)$ git merge other-branch
    (master)$ git merge new-branch

    (master)$ branch other-branch
    (other-branch)$ branch remove
    (master)$ branch remove new-branch
    (master)$