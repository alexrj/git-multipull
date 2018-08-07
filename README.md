# git-multipull

This script fetches multiple remote git repositories whose master branches are supposed to be identical. It checks that they are actually aligned, and then performs a merge of their history to the local master branch.

The purpose of such a pedantic tool is to enable secure, decentralised distribution of authoritative data. Many git hosting providers keep audit logs of force-pushes, so it's almost impossible to forge the history without leaving traces. In case a single repository is compromised, `git fetch` will complain and this script will refuse to pull the changes anyway.