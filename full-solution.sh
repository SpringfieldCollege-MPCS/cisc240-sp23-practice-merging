#!/bin/bash
# delete old git repo
# delete previous work
rm -rf .git
rm -rf practice

# Configure git settings
git config --global core.editor "nano"
git config --global alias.log1 'log --oneline'
git config --global alias.log-graph '!git --no-pager log --graph --abbrev-commit --decorate --date=relative --all'

# Create a git repository in a sub dir
mkdir practice
cd practice
echo "Creating git repository and configuring user"
git init --quiet
git config user.email "Jeremy Castagno" # Change this to yours....
git config user.name "jsdf@gmail.com"

# Make some files
echo "Adventures:" >> home.txt

# add and commit changes
git add home.txt
git add .gitignore
git commit -m "C0 - Initial Commit"
# Show the git status
git status

# Make some more changes
echo "1. Dog Walking" >> home.txt
echo "2. Hiking" >> home.txt

git commit -am "C1 - Added more adventures on walking and hiking"
git log1


# Make some more changes
echo "3. Dancing" >> home.txt
echo "4. Cooking" >> home.txt

git commit -am "C2 - Added more adventures on dancing and cooking"
git log1


# Demonstrate making a feature branch

# Lets make another branch
git branch feature
git switch feature # might need to use: git checkout feature
git log1

echo "Notice that the HEAD points to the feature and master branch. This is because **right now** they are the same thing."

echo "Lets create a new file"
echo "Recipes:" >> recipes.txt
git add recipes.txt
git commit -m "F1 - Added a recipe page"
git log1

read -p "Press any key to continue... " -n1 -s


echo "Lets look at the git graph:"
git log-graph
echo "Notice that it is showing our new commit on branch feature comes *after*"


echo "Lets try to now merge our feature changes back into your master branch"
echo "First we checkout our master branch"

git checkout master
git status
echo "If you look now you will see that the working directory does not have the file recipes.txt. Lets change by merging the feature branch."

git merge feature
git log-graph


git checkout feature
echo "1. Ratatouille" >> recipes.txt
git commit -am "F2 - Added the Ratatouille recipe"


# In the mean time someone else, or your self, needs to make a quick change to the master branch. 
git checkout master
echo -e "Welcome to my awesome website!\n$(cat home.txt)" > home.txt
# echo "Please checkout my recipes website" >> home.txt
git commit -am "C3 - Updated home.txt to talk about my recipe website"


git checkout feature
echo "2. Eggs Benedict" >> recipes.txt
git commit -am "F3 - Added the another recipe"

echo "Now lets see what the graph looks like"
git log-graph

echo "Notice that there is a divergence between both branches now -> It has the / symbol on the last commit for the master"

read -p "Press any key to continue... " -n1 -s

echo "Now we will go ahead and try to merge these changes with master"
git checkout master
git merge feature -m "M1 - We have merged our feature branch into master"

git log-graph


echo "Now lets cause a merge conflict!"
read -p "Press any key to continue... " -n1 -s