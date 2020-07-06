#!/bin/bash

git add -A

git commit -m 'Release 3.1.2'

git tag 3.1.2

git push --tags

git push origin master

pod trunk push BDToolKit.podspec --allow-warnings
