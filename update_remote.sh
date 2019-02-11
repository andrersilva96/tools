#!/bin/bash

# store the current dir
CUR_DIR=$(pwd)

# Find all git repositories and update it to the master latest revision
for i in $(find . -name ".git" | cut -c 3-); do
    echo "";
    echo "\033[33m"+$i+"\033[0m";

    # We have to go to the .git parent directory to call the pull command
    cd "$i";
    cd ..;

    # Clean and update
    git remote rename origin bitbucket;
#    git remote remove origin;

    parent_dir=$(basename "$PWD")

    git remote add origin git@github.com:ActualSales/$parent_dir.git
    git remote -v;

    git remote remove bitbucket;
    git fetch;
    git checkout master;
    git branch --set-upstream-to origin/master;

    # lets get back to the CUR_DIR
    cd $CUR_DIR
done

echo "\n\033[32mComplete!\033[0m\n"
