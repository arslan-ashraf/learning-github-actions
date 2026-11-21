#!/usr/bin/bash

COMMIT_MESSAGE="${1:-changes}"

git add .
git commit -m "$COMMIT_MESSAGE"
git push