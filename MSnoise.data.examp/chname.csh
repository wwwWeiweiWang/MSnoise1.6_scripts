set NET = YH
foreach file ( `\ls *.sac` )
set sta = `echo $file | awk -F. '{print $1}'`
set year = `echo $file | awk -F. '{print $2}'`
set day = `echo $file | awk -F. '{print $3}'`
set chan = `echo $file | awk -F. '{print $4}'`
set name = $sta.$NET.NZ.$chan.$year.$day
mv $file $name
end
