#!/bin/bash

git add -A

git commit -m 'Release 3.4.4'

git tag 3.4.4

git push --tags

git push origin master

pod trunk push BDToolKit.podspec --allow-warnings
