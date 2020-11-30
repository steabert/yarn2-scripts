#!/usr/bin/env bash

function usage {
  cat <<EOF
  Usage: $(basename $0) [level]

  Generate a commit with a new version computed from the current
  version in package.json upgraded with the provided level (using
  semver versioning rules).

  All workspaces are upgraded to the same version, which is the one
  in the package.json file of the root workspace.

  If no level is given, `patch` is used as default level.

  Examples:
    $(basename $0) prepatch
    $(basename $0) minor

EOF
}

if [[ -z "$1" ]]; then
	level="patch"
else
	level="$1"
fi


# upgrade all workspaces and apply
yarn workspaces foreach version $level --deferred
yarn version apply --all

# update changelog and commit new version
NEW_VERSION="v$(jq -r .version package.json)"
yarn changelog -u ${NEW_VERSION} || echo "no changelog script, CHANGELOG.md generation skipped"

# commmit changes
git add -u
git commit -m ${NEW_VERSION}
git tag -a -m ${NEW_VERSION} ${NEW_VERSION}
