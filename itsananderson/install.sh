#/bin/bash

script_dir=$(pushd `dirname $0` > /dev/null && pwd -P)

$script_dir/../install.sh

# User specific install steps

git config --global format.pretty format:"%C(auto)%h %d%Creset %s%n%Cgreen%ad%Creset %aN <%aE>%n"

echo "Customizing KDiff3 settings"

if [[ ! -e "~/.kdiff3rc" ]]
then
    cp $script_dir/.kdiff3rc-base ~/.kdiff3rc
fi

$script_dir/apply-kdiff3rc.sh $script_dir/.kdiff3rc ~/.kdiff3rc

echo "Creating 'hub' alias"

git config --global alias.hub \!"sh -c 'git clone git@github.com:\$1.git \${@:2}' -"

$script_dir/../ensure-script.sh vso-alias "$(<$script_dir/git-scripts/vso-alias.sh)"
$script_dir/../ensure-script.sh email-guess "$(<$script_dir/git-scripts/email-guess.sh)"

gvimpath=`which gvim`
if [[ -n $gvimpath ]]; then
  echo "Fixing GVIM script"
  cp $script_dir/fixed-gvim.sh "$gvimpath"
fi

git config --global rerere.enabled true

git config --global alias.vsoc \!". ~/.git-scripts/vso-alias.sh; clone" ""
git config --global alias.vsor \!". ~/.git-scripts/vso-alias.sh; remote" ""
git config --global alias.email-guess \!". ~/.git-scripts/email-guess.sh" ""
git config --global alias.cara "commit --amend --reset-author"
