function blt() {
  if [ "`git rev-parse --show-cdup 2> /dev/null`" != "" ]; then
    GIT_ROOT=$(git rev-parse --show-cdup)
  else
    GIT_ROOT="."
  fi
  if [ -f "$GIT_ROOT/vendor/bin/blt" ]; then
    $GIT_ROOT/vendor/bin/blt "$@"
  else
    echo "You must run this command from within a BLT-generated project repository."
    return 1
  fi
}

function chrome(){
    /mnt/c/Program\ Files\ \(x86\)/Google/Chrome/Application/chrome.exe $@
}

# this should let you use drush that is in the repo you're working on
# should be better than a simple alias drush="./vendor/bin/drush"

function drush() {
  if [ "`git rev-parse --show-cdup 2> /dev/null`" != "" ]; then
    GIT_ROOT=$(git rev-parse --show-cdup)
  else
    GIT_ROOT="."
  fi
  if [ -f "$GIT_ROOT/vendor/bin/drush" ]; then
    $GIT_ROOT/vendor/bin/drush "$@"
  else
    echo "You must run this command from within a BLT-generated project repository."
    return 1
  fi
}
