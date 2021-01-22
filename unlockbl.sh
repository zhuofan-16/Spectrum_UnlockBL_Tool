#!/bin/bash
#
# Author: shijiu.ren@spreadtrum.com
#
# secureboot avb2.0: sign identifier
#
# Need environment
# bash
# awk
#
# Command usage:
#./unlockbl.sh IDENTIFIER PRIVATE_KEY SIGNATURE
#
# **************** #
# input parameters #
# **************** #
IDENTIFIER=$1
PRIVATE_KEY=$2
SIGNATURE=$3


# *************** #
# var declaration #
# *************** #
IDENTIFIER_TXT=identifier.txt
IDENTIFIER_BIN=identifier.bin
PADDING_BIN=padding.bin
IDENTIFIER_BIN_MAX_SIZE=64


# *************** #
#    functions    #
# *************** #
doInit()
{
	if [ $# -ne 3 ]; then
		echo "Parameter input error"
		echo "Usage:"
		echo "./unlockbl.sh identifier private_key signature"
		return 1
	fi

	if [ ! -f $PRIVATE_KEY ]; then
		echo "Private key file is not existed"
		return 1
	fi

	if [ "$IDENTIFIER" = "" ]; then
		echo "Identifier empty"
		return 1
	fi

	if [ "$SIGNATURE" = " " ]; then
		echo "Not specify file that save signature"
		return 1
	fi

	if [ -f $SIGNATURE ]; then
		rm -rf $SIGNATURE
	fi
}

doStringToBinary()
{
	if [ -f $IDENTIFIER_TXT ]; then
		rm -rf  $IDENTIFIER_TXT
	fi

	if [ -f $IDENTIFIER_BIN ]; then
		rm -rf  $IDENTIFIER_BIN
	fi

	echo $IDENTIFIER > $IDENTIFIER_TXT

	while read line
	do
		#echo "line:$(line)"
		echo -e -n "`echo "${line}" | cut -d: -f 2 | sed 's/ //g' | sed 's/../\\\x&/g'`\c" >> $IDENTIFIER_BIN
	done < $IDENTIFIER_TXT

	identifier_bin_size=`ls -l $IDENTIFIER_BIN | awk '{print $5}'`

	if [ $identifier_bin_size -gt $IDENTIFIER_BIN_MAX_SIZE ]; then
		echo "Identifier string too long"
		return 1
	fi

	let padding_len=$IDENTIFIER_BIN_MAX_SIZE-$identifier_bin_size

	dd if=/dev/zero of=$PADDING_BIN bs=$padding_len count=1
	cat $PADDING_BIN >> $IDENTIFIER_BIN
}

doIdentifierSign()
{
	openssl dgst -sha256 -out $SIGNATURE -sign $PRIVATE_KEY $IDENTIFIER_BIN
	if [ $? -ne 0 ]; then
		echo "Call openssl to sign failure"
		return 1
	fi
	rm -rf $IDENTIFIER_BIN $IDENTIFIER_TXT $PADDING_BIN
}

doMain()
{
	echo "Identifier sign script, ver 0.10"

	doInit $@
	if [ $? -ne 0 ]; then
		echo "doInit execute error"
		exit 1
	fi

	doStringToBinary
	if [ $? -ne 0 ]; then
		echo "doStrintToBinary execute error"
		exit 1
	fi

	doIdentifierSign
	if [ $? -ne 0 ]; then
		echo "Identifier sign fail"
		exit 1
	fi

	echo "Identifier sign successfully"
}

# ************* #
# main function #
# ************* #
doMain $@

#test command
#./unlockbl.sh 30313233343536303839414243444546 sign.pem signature.bin
