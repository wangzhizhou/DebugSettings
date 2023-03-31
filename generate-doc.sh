# !/usr/bin/env bash
# -*- coding: utf-8 -*-

set -eu

# Use git worktree to checkout the gh-pages branch of this repository in a gh-pages sub-directory
git fetch
git worktree add --checkout gh-pages origin/gh-pages

xcodebuild docbuild -scheme DebugSettings \
    -destination generic/platform=iphoneos \
    OTHER_DOCC_FLAGS="--transform-for-static-hosting \
    --hosting-base-path DebugSettings --output-path docs"

if [ $? -ne 0 ]; then
  git worktree remove gh-pages
  echo compile docc failed!
  exit 1
fi

if [ -d "gh-pages/docs" ]; then
  rm -rf gh-pages/docs
fi

if [ -d "docs" ]; then
  mv -f docs/  gh-pages/
fi

# Save the current commit we've just built documentation from in a variable
CURRENT_COMMIT_HASH=`git rev-parse --short HEAD`

# Commit and push our changes to the gh-pages branch
cd gh-pages
git add docs

if [ -n "$(git status --porcelain)" ]; then
    echo "Documentation changes found. Commiting the changes to the 'gh-pages' branch and pushing to origin."
    git commit -m "Update GitHub Pages documentation site to '$CURRENT_COMMIT_HASH'."
    git push origin HEAD:gh-pages
else
  # No changes found, nothing to commit.
  echo "No documentation changes found."
fi

# Delete the git worktree we created
cd ..
git worktree remove gh-pages
