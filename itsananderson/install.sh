#!/bin/bash

script_dir=$(pushd `dirname $0` > /dev/null && pwd -P)

$script_dir/../install.sh

# User specific install steps

git config --global format.pretty format:"%C(yellow)%h%Creset %s%n%Cgreen%ad%Creset %aN <%aE>%n"

echo "Customizing KDiff3 settings"

if [ ! -e "~/.kdiff3rc" ]
then
    cp $script_dir/.kdiff3rc-base ~/.kdiff3rc
fi

$script_dir/apply-kdiff3rc.sh $script_dir/.kdiff3rc ~/.kdiff3rc

echo "Creating 'hub' alias"

git config --global alias.hub \!"sh -c 'git clone git@github.com:\$1.git \${@:2}' -"

echo "Creating 'vso' alias"

$script_dir/../ensure-script.sh vso-alias "$(<$script_dir/git-scripts/vso-alias.sh)"

git config --global alias.vso \!"$HOME/.git-scripts/vso-alias.sh"\ ""

#!sh -c '/c/Users/Will/.git-scripts/vso-alias.sh $"@"' -
