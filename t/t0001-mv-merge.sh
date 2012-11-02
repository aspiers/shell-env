#!/bin/bash

test_description=mv-merge

. ./test-lib.sh

here=`dirname $0`
cd "$here"

test_expect_success 'setup' '
    cp -a $TEST_DIRECTORY/mv-merge/mv-merge-test.vanilla mv-merge-test
'

run_mv_merge () {
    (
        cd mv-merge-test/src
        echo "Running: mv-merge $opts a/b c ../dst"
        mv-merge $opts a/b c ../dst
    )
}

test_expect_success 'mv-merge without overwrite' '
    opts=
    run_mv_merge
'

diff -ur $here/mv-merge-test{.vanilla,}
# for opts in '' '-u' '-f'; do
#     )

