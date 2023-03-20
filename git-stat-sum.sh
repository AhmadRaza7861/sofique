#!/bin/sh

echo "On average a developer code 100 lines of code per day."
git log --numstat --format="" "$@" | awk '{files += 1}{ins += $1}{del += $2} END{print "total: "files" files, "ins" insertions(+) "del" deletions(-)"}'
