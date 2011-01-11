
Git-svn problem scenario
=========================

Git-svn provides bidirectional operation between a Subversion repository and git,
which can be very handy in various scenarios.

However, the manual page of git-svn states the following

    ..., it is recommended that all git svn users clone, fetch and 
    dcommit directly from the SVN server, and avoid all git clone/pull/merge/push 
    operations between git repositories and branches. The recommended method of 
    exchanging code between git branches and users is git format-patch and git am, 
    or just 'dcommit'ing to the SVN repository.

    Running git merge or git pull is NOT recommended on a branch you plan to dcommit from. 
    Subversion does not represent merges in any reasonable or useful fashion; 
    so users using Subversion cannot see any merges you've made.
    Furthermore, if you merge or pull from a git branch that is a mirror of an 
    SVN branch, dcommit may commit to the wrong branch.

These extra constrains harm the usefulness of git-svn unfortunately.

The script ``git-svn-problem-scenario.sh`` illustrates the problem the man page is referring to.


