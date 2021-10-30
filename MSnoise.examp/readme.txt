1. change your data format according to http://msnoise.org/doc/workflow/002_populate.html
   there is a script MSnoise.data.examp/chname.csh to give you an idea to change your data name to data_structure['BUD'] = "NET/STA/STA.NET.LOC.CHAN.YEAR.DAY"

2. link your data folder to the current folder by link_dev.sh

3. change the station table MSnoise.data.examp/stations.txt; check the filename in custom.py
-----------------------------------------
Network station longtitude latitude altitude
YH LOBS6 178.796000 -38.977800 -1873.5
YH LOBS8 178.459400 -38.843200 -651.3
-----------------------------------------

4. change parameters in msnoise_config.sh, refer to http://msnoise.org/doc/workflow/001_msnoise_admin.html
   change filters in main script msnoise.sh

5. run main script msnoise.sh
   this script basically follows MSnoise workflow http://msnoise.org/doc/workflow/0000_intro.html

6. if you want to select days according to the correlation coefficient between daily cross-correlations and the reference stack, you can change select-days.csh, un-comment the 'csh select-days.csh' after msnoise stack -r in msnoise.sh, and also re-stack the reference stack.

7. plot according to http://www.msnoise.org/doc/plotting.html
