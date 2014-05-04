#!/bin/bash

    # find-out-what-is-using-your-swap.sh
    # -- Get current swap usage for all running processes
    # --
    # -- rev.0.3, 2012-09-03, Jan Smid          - alignment and intendation, sorting
    # -- rev.0.2, 2012-08-09, Mikko Rantalainen - pipe the output to "sort -nk3" to get sorted output
    # -- rev.0.1, 2011-05-27, Erik Ljungstrom   - initial version


SCRIPT_NAME=`basename $0`;
SORT="kb";                 # {pid|kB|name} as first parameter, [default: kb]
[ "$1" != "" ] && { SORT="$1"; }

[ ! -x `which mktemp` ] && { echo "ERROR: mktemp is not available!"; exit; }
MKTEMP=`which mktemp`;
TMP=`${MKTEMP} -d`;
[ ! -d "${TMP}" ] && { echo "ERROR: unable to create temp dir!"; exit; }

>${TMP}/${SCRIPT_NAME}.pid;
>${TMP}/${SCRIPT_NAME}.kb;
>${TMP}/${SCRIPT_NAME}.name;

SUM=0;
OVERALL=0;
    echo "${OVERALL}" > ${TMP}/${SCRIPT_NAME}.overal;

for DIR in `find /proc/ -maxdepth 1 -type d -regex "^/proc/[0-9]+"`;
do
    PID=`echo $DIR | cut -d / -f 3`
    PROGNAME=`ps -p $PID -o comm --no-headers`

    for SWAP in `grep Swap $DIR/smaps 2>/dev/null| awk '{ print $2 }'`
    do
        let SUM=$SUM+$SWAP
    done

    if (( $SUM > 0 ));
    then
        echo -n ".";
        echo -e "${PID}\t${SUM}\t${PROGNAME}" >> ${TMP}/${SCRIPT_NAME}.pid;
        echo -e "${SUM}\t${PID}\t${PROGNAME}" >> ${TMP}/${SCRIPT_NAME}.kb;
        echo -e "${PROGNAME}\t${SUM}\t${PID}" >> ${TMP}/${SCRIPT_NAME}.name;
    fi
    let OVERALL=$OVERALL+$SUM
    SUM=0
done
echo "${OVERALL}" > ${TMP}/${SCRIPT_NAME}.overal;
echo;
echo "Overall swap used: ${OVERALL} kB";
echo "========================================";
case "${SORT}" in
    name )
        echo -e "name\tkB\tpid";
        echo "========================================";
        cat ${TMP}/${SCRIPT_NAME}.name|sort -r;
        ;;

    kb )
        echo -e "kB\tpid\tname";
        echo "========================================";
        cat ${TMP}/${SCRIPT_NAME}.kb|sort -rh;
        ;;

    pid | * )
        echo -e "pid\tkB\tname";
        echo "========================================";
        cat ${TMP}/${SCRIPT_NAME}.pid|sort -rh;
        ;;
esac
rm -fR "${TMP}/";
