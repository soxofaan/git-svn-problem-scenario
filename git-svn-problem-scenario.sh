#!/bin/bash

# Show all commands as we go allong.
set -x

# Clean up output from previous runs before we start.
rm -fr svn-repo svn-wc git-wc

# Get absulute path of current working directory.
root=$(pwd)

# Set up initial SVN repo.
svnadmin create svn-repo
svn checkout file://$root/svn-repo svn-wc
cd $root/svn-wc
# Create trunk/branches/tags layout.
svn mkdir trunk
svn mkdir branches
svn mkdir tags
svn commit -m "Repo layout"
# Create a readme file.
echo "Hello world" > trunk/readme.txt
svn add trunk/readme.txt
svn commit -m "Created readme.txt"
# Create a SVN-branch from trunk.
svn copy trunk branches/branch
svn commit -m "Created SVN branch"

# Git-svn clone/checkout.
cd $root
git svn clone -s --prefix=svn/ file://$root/svn-repo git-wc

# Work in git: create tracking branch.
cd $root/git-wc
git branch --track svn-branch svn/branch

# Work on master (aka trunk) and commit to SVN.
git checkout master
echo "this is from master" > frommaster.txt
git add frommaster.txt
git commit -m "added frommaster.txt"
git svn dcommit

# Work on svn-branch (SVN branch) and commit to SVN.
git checkout svn-branch
echo "this is from branch" > frombranch.txt
git add frombranch.txt
git commit -m "added frombranch.txt"
git svn dcommit

# Merge master in branch and commit to SVN.
git checkout svn-branch
git merge master
git svn dcommit

# Merge branch in master.
git checkout master
git merge svn-branch

# Work in master.
git checkout master
echo "more stuff from master" > morefrommaster.txt
git add morefrommaster.txt
git commit -m "more stuff from master"

# Try to commit from master to SVN trunk
# but this fails: commits to SVN branch instead.
git checkout master
git svn dcommit

# Check SVN wc.
cd $root/svn-wc
svn update


