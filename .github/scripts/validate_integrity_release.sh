#!/bin/bash

# Enhanced print function
pretty_print(){
    len=${#1}
    line_separator=$(printf "%-${len}s" ' ')
    echo
    echo "${line_separator// /-}"
    printf "$1\n"
    echo "${line_separator// /-}"
    echo
}

echo -e "\nCheck if there are no conflicts and changes can be merged to release\n"
git checkout release
git merge --ff-only develop
if [[ $? != 0 ]]; then
    echo -e "Cannot execute Fast-Forward merge"
    pretty_print "Executing TRUE MERGE"
    git merge --no-edit --strategy ort -X theirs develop

    # Below commented at least for now untill we see how merge strategy with THEIRS option works
    # git checkout --theirs version.env
    # git add .

    if [[ $? != 0 ]];then
        echo "Changes cannot be merged to release, please check out existing conflicts!"
        exit 1
    else
        pretty_print "Update ORIGIN Release branch"
        git push
    fi

else
    pretty_print "Updating ORIGIN Release branch"
    git push
fi