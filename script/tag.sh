#!/bin/sh
set -eu

version=0.1.0
GIT_COMMITTER_DATE=$(git log -n1 --pretty=%aD) git tag -a -m "Release $version" "v$version"
git push --tags
