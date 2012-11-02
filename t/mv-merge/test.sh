#!/bin/bash

here=`dirname $0`
cd "$here"

rm -rf mv-merge-test
cp -a mv-merge-test{.vanilla,}

for opts in '' '-u' '-f'; do
    (
        cd mv-merge-test/src
        echo "Testing: mv-merge $opts a/b c ../dst"
        mv-merge $opts a/b c ../dst && \
        diff -ur $here/mv-merge-test{.vanilla,}
    )

    div
done
