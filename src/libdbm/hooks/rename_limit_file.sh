#!/bin/bash -f

ISO=$1
OUTPUT=$2

TMPDIR="/tmp/deepin-boot-make/.cache/tmp-$(date +%s%N)"
STRCNT=$(expr length $TMPDIR)
mkdir $TMPDIR -p
mount -o loop -t iso9660 $ISO $TMPDIR
file_list=$(find $TMPDIR -name "*.deb")

for file in $file_list;
do
	subdir=$file
	subdir=$(dirname $subdir)
	subdir=${subdir:${STRCNT}}
	cnt=$(basename $file | wc -L)
	if [ $cnt -gt 64 ];then
		sources_file_md5=$(md5sum $file | awk '{print $1}')
		for error_file in $(ls $OUTPUT/$subdir)
		do
			dist_file_md5=$(md5sum $OUTPUT/$subdir/$error_file  | awk '{print $1}')
			if [ "$sources_file_md5" == "$dist_file_md5" ];then
				rm -fr $OUTPUT/$subdir/$error_file
			fi
		done
		cp $file $OUTPUT/$subdir -fr
	fi
done

umount $TMPDIR
rm -fr $TMPDIR

