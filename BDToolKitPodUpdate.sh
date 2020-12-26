#!/bin/bash

git add -A

git commit -m 'Release 3.3.0'

git tag 3.3.0

git push --tags

git push origin master

pod trunk push BDToolKit.podspec --allow-warnings --verbose
