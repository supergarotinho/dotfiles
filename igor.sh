#!/usr/bin/env bash
cd
mkdir Projects

git config --global user.email "igor@borges.me"
git config --global user.name "Igor1201"
git config --global user.signingkey "7AD24624"

curl https://install.meteor.com/ | sh
