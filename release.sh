#!/bin/sh

RELEASE_VERSION=$1

usage() {
    echo "*************************************************************************************************************"
    echo "usage: "
    echo "  $0 release_version"
    echo ""
    echo " To create a release, first checkout the git branch from where you want to create the release."
    echo ""
    echo "What does it do?"
    echo "- Changes pom version to release_version"
    echo "- Creates branch release/release_version"
    echo "- Creates tag release_version"
    echo "- Pushes everything to origin"
    echo "*************************************************************************************************************"
}

# $1 new version
# $2 file
replace_first_version() {
  sed -i "0,/<version>.*<\/version>/s//<version>${1}<\/version>/" $2
}

# $1 pom file
get_current_version() {
    grep -Po -m1 '(?<=<version>).*(?=</version>)' $1
}

if [ $# -lt 1 ]
then
    usage
    exit 1
fi

SCRIPT=$(readlink -f "$0")
BASEDIR=$(dirname "$SCRIPT")


# create release branch
git checkout -b release/$RELEASE_VERSION

echo $RELEASE_VERSION >> README.md
echo $RELEASE_VERSION >> community/README.md

# Commit and tag
git commit -a -m "[RELEASE] Create release $RELEASE_VERSION"
git tag -a $RELEASE_VERSION -m 'Release $RELEASE_VERSION'

# Push branch and tag
git push origin release/$RELEASE_VERSION
git push origin $RELEASE_VERSION

###################################################################################################
#  Pushing to subtree repo
###################################################################################################
SUBTREE_REPO=git@github.com:cpuy/subtree-child.git

# remove previously created local tag
git tag -d $RELEASE_VERSION
# splitting subtree, create a branch containing only subtree code
git subtree split --prefix=community -b community/release/$RELEASE_VERSION
git checkout community/release/$RELEASE_VERSION

# tag and push branch + tag to subtree
git tag -a $RELEASE_VERSION -m 'Release $RELEASE_VERSION'
git push $SUBTREE_REPO community/release/$RELEASE_VERSION:release/$RELEASE_VERSION
git push $SUBTREE_REPO $RELEASE_VERSION
