#!/bin/bash

git add -A

git commit -m 'Release 3.2.3'

git tag 3.2.3

git push --tags

git push origin master

pod trunk push BDToolKit.podspec --allow-warnings
