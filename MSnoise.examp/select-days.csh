#!/bin/csh
set ND = `pwd`
set lag1 = 0
set lag2 = 600
set threshold = 0.45
#foreach com1 ( EN EZ NE NN ZZ EE NZ ZE ZN )
foreach com1 ( Z1 Z2 12 )
#foreach com1 ( ZR ZT RZ TZ )
set com = $com1

#goto www
#---------------- select days -------------------
if ( ! -d $ND/lst ) mkdir $ND/lst
if ( -f badcc ) rm -f badcc
#################################
foreach stackfile ( `\ls $ND/STACKS/01/REF/$com1/*$com1*.SAC` )
set ST = `echo $stackfile | awk -F/ '{print $NF}' | awk -F. '{print $1}'`
foreach filterid ( 01 )
#foreach filterid ( 01 02 03 04 05 )
set sta1 = `echo $ST | awk -F- '{print $1}'`
set sta2 = `echo $ST | awk -F- '{print $2}'`
set STbug = ${sta1}_${sta2}
set used = $ND/lst/$ST.$com.$filterid.used_cc.lst
if ( -f $used ) rm -rf $used

set day_dir = $ND/STACKS/$filterid/001_DAYS/$com1/$STbug
set allday_dir = $ND/allday/$com-$ST/$filterid
if ( ! -d $allday_dir ) mkdir -p $allday_dir
set n = `\ls $allday_dir/ | wc -l`
if ( $n == 0 ) mv $day_dir/* $allday_dir/

#rm -f $day_dir/*
echo 'check if all moved, expect it is No match'
\ls $day_dir/*

set stack_dir = $ND/STACKS/$filterid/REF/$com1
set allstack_dir = $ND/allstack/$com-$ST/$filterid
if ( ! -d $allstack_dir ) mkdir -p $allstack_dir
set n = `\ls $allstack_dir/ | wc -l`
if ( $n == 0 ) mv $stack_dir/$ST.*.SAC $allstack_dir/

set allstack = $allstack_dir/${ST}.*.SAC  # all day stacked ccf
#\ls $allstack
if ( ! -f $allstack ) then
echo $allstack
exit
endif

set cor = $ND/lst/$ST.$com.$filterid.correlation_cc.lst
if ( -f $cor ) rm -rf $cor

cd $allday_dir
foreach dailycc ( `\ls *.SAC` )  # daily ccfs
#set mdate = `echo $dailycc | awk -F. '{print $3}'` # julian day

./sac_correlation << EOF >! /dev/null
$dailycc
$allstack
$lag1 $lag2
EOF

#echo $dailycc
if ( ! -f cor.out ) exit
set mat = `cat cor.out | awk -F= '/corval/{print $2}' | awk -v a=$threshold '($1>=a){print $0}' | wc -l`
set cc = `cat cor.out | awk -F= '/corval/{print $2}'`
echo $dailycc $cc >> $cor
rm -rf cor.out
if ( $mat == 0 ) goto cskip
echo "$com $cc $dailycc " >>! $used
cp $dailycc $day_dir/
cskip:
end ## dailycc

if ( ! -f $used ) then # no daily cc with correlation >= 0.5
echo "$ST-$com has no daily cc with correlation >= $threshold "
cp $dailycc $day_dir/
echo $filterid $ST >> badcc
goto NE
endif
set nxcc = `cat $used | awk '{print $3}' | wc -l `
if ( $nxcc == 0 ) then
rm -rf $used
goto NE
endif
echo "$ST $com cor>=threshold $nxcc"

NE:
# rstack by selected ccfs
cd $ND
end # filterid
end ## ST
end #com
#www:
exit

