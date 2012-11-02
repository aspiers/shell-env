#!/bin/bash

test_description=mv-merge

. ./test-lib.sh

here=`dirname $0`
cd "$here"

init () {
	VANILLA="$TEST_DIRECTORY/mv-merge/mv-merge-test.vanilla"
	fixtures="mv-merge-test"
	rm -rf "$fixtures"
	cp -a "$VANILLA" "$fixtures"
	src="$fixtures/src"
	dst="$fixtures/dst"
	find "$src" | grep 'newer-in-src' | xargs touch
	find "$dst" | grep 'older-in-src' | xargs touch
	# Ensure consistent results for 'same' file
	find "$src" | grep '/same'	  | xargs touch
}

run_mv_merge () {
	opts="$*"
	(
		cd "$src"
		echo "Running: mv-merge $opts a/b c ../dst"
		echo "-------------"
		mv-merge $opts a/b c ../dst
		echo "-------------"
		# mv-merge can remove files from src but is
		# not allowed to change contents
		diffs=$(
			diff -ur "$VANILLA/src" . |
			grep -v "^Only in $VANILLA/src"
		)
		if [ -n "$diffs" ]; then
			echo "BUG! mv-merge changed src:" >&2
			echo "$diffs" >&2
			return 1
		fi
	)
}

check_differences () {
	cat > expected-diffs
	diff -ur "$@" > actual-diffs
	if cmp expected-diffs actual-diffs >/dev/null; then
		echo "diff -ur $@ yielded expected results"
		return 0
	else
		echo "diff -ur $@ yielded unexpected results; expected:"
		cat expected-diffs
		echo
		echo "but actually got:"
		cat actual-diffs
		return 1
	fi
}

get_inode () {
	file="$1"
	stat -c %i "$file"
}

check_inode () {
	file="$1" expected_inode="$2"

	if ! actual_inode=$( get_inode "$file" ); then
		return 1
	fi
	if [ "$expected_inode" = "$actual_inode" ]; then
		echo "Yay, inode for $file was $actual_inode as expected"
		return 0
	else
		echo "$file had inode $actual_inode but expected $expected_inode" >&2
		return 1
	fi
}

test_expect_success 'mv-merge without overwrite' '
	init &&
	run_mv_merge &&
	check_differences "$VANILLA/src" "$src" <<-EOF &&
		Only in $VANILLA/src/a/b: only-src
		Only in $VANILLA/src/a/b: same
		Only in $VANILLA/src/c: only-src
		Only in $VANILLA/src/c: same
	EOF
	check_differences "$VANILLA/dst" "$dst" <<-EOF
		Only in $dst/a/b: only-src
		Only in $dst/c: only-src
	EOF
'

test_expect_success 'mv-merge -u - updating newer files only' '
	init &&
	i1=$( get_inode "$src/a/b/only-src" ) &&
	i2=$( get_inode "$src/c/only-src"   ) &&
	run_mv_merge -u &&
	check_differences "$VANILLA/src" "$src" <<-EOF &&
		Only in $VANILLA/src/a/b: newer-in-src
		Only in $VANILLA/src/a/b: only-src
		Only in $VANILLA/src/a/b: same
		Only in $VANILLA/src/c: newer-in-src
		Only in $VANILLA/src/c: only-src
		Only in $VANILLA/src/c: same
	EOF
	check_differences -x newer-in-src "$VANILLA/dst" "$dst" <<-EOF &&
		Only in $dst/a/b: only-src
		Only in $dst/c: only-src
	EOF
	[ "`cat $dst/a/b/newer-in-src`" = "newer" ] &&
	[ "`cat $dst/c/newer-in-src`"	= "newer" ] &&
	check_inode "$dst/a/b/only-src" "$i1" &&
	check_inode "$dst/c/only-src"	"$i2"
	# Note that rsync surprisingly causes a change in the
	# inodes of {a/b,c}/same
'

test_expect_success 'mv-merge -f - overwriting all files' '
	init &&
	i1=$( get_inode "$src/a/b/only-src" ) &&
	i2=$( get_inode "$src/c/only-src"   ) &&
	run_mv_merge -f &&
	check_differences "$VANILLA/src" "$src" <<-EOF &&
		Only in $VANILLA/src/a: b
		Only in $VANILLA/src: c
	EOF
	check_differences -x older-in-src -x newer-in-src "$VANILLA/dst" "$dst" <<-EOF &&
		Only in $dst/a/b: only-src
		Only in $dst/c: only-src
	EOF
	[ "`cat $dst/a/b/older-in-src`" = "older" ] &&
	[ "`cat $dst/c/older-in-src`"	= "older" ] &&
	[ "`cat $dst/a/b/newer-in-src`" = "newer" ] &&
	[ "`cat $dst/c/newer-in-src`"	= "newer" ] &&
	check_inode "$dst/a/b/only-src" "$i1" &&
	check_inode "$dst/c/only-src"	"$i2"
'

test_expect_success 'mv-merge without overwrite' '
	init &&
	run_mv_merge &&
	check_differences "$VANILLA/src" "$src" <<-EOF &&
		Only in $VANILLA/src/a/b: only-src
		Only in $VANILLA/src/a/b: same
		Only in $VANILLA/src/c: only-src
		Only in $VANILLA/src/c: same
	EOF
	check_differences "$VANILLA/dst" "$dst" <<-EOF
		Only in $dst/a/b: only-src
		Only in $dst/c: only-src
	EOF
'

for opts in '' '-u' '-f'; do
	test_expect_success "mv-merge --dry-run $opt" '
		init &&
		run_mv_merge --dry-run '"$opt"' &&
		check_differences "$VANILLA/src" "$src" <<-EOF &&
		EOF
		check_differences "$VANILLA/dst" "$dst" <<-EOF
		EOF
	'
done

test_done
