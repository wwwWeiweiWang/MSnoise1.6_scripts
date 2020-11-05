set -ex

rm -rf DTT
#:<<COMMENTBLOCK
rm -rf MWCS
#:<<COMMENTBLOCK
rm -rf db.ini msnoise.sqlite STACKS allday allstack
printf "1\n\n" | msnoise db init

#msnoise admin

./msnoise_config.sh

msnoise populate

msnoise scan_archive --init
#msnoise -t 8 scan_archive --init

#msnoise populate --fromDA

# sqlite3 msnoise.sqlite "DELETE FROM jobs"
# sqlite3 msnoise.sqlite "UPDATE data_availability SET flag='N'"
msnoise new_jobs

#COMMENTBLOCK
# filter
sqlite3 msnoise.sqlite "DELETE FROM filters"
#sqlite3 msnoise.sqlite "INSERT INTO filters (low, high, used, mwcs_low, mwcs_high, mwcs_wlen, mwcs_step) VALUES (0.4, 1, 1, 0.4, 1, 20, 2)"
#sqlite3 msnoise.sqlite "INSERT INTO filters (low, high, used, mwcs_low, mwcs_high, mwcs_wlen, mwcs_step) VALUES (0.166667, 0.4, 1, 0.166667, 0.4, 20, 2)"
#sqlite3 msnoise.sqlite "INSERT INTO filters (low, high, used, mwcs_low, mwcs_high, mwcs_wlen, mwcs_step) VALUES (0.1, 1, 1, 0.1, 1, 20, 2)"
sqlite3 msnoise.sqlite "INSERT INTO filters (low, high, used, mwcs_low, mwcs_high, mwcs_wlen, mwcs_step) VALUES (0.05, 0.4, 1, 0.05, 0.4, 20, 4)"
#sqlite3 msnoise.sqlite "INSERT INTO filters (low, high, used, mwcs_low, mwcs_high, mwcs_wlen, mwcs_step) VALUES (0.05, 1, 1, 0.05, 1, 20, 2)"

#rm -rf STACKS allday allstack
#sqlite3 msnoise.sqlite "DELETE FROM jobs WHERE Jobtype='DTT'"
#sqlite3 msnoise.sqlite "UPDATE jobs SET flag='T'"
msnoise compute_cc || true
#COMMENTBLOCK
#msnoise -t 8 compute_cc || true

echo All jobs finished.

#COMMENTBLOCK
#rm -rf allday allstack
#sqlite3 msnoise.sqlite "DELETE FROM jobs WHERE jobtype='DTT'"
#sqlite3 msnoise.sqlite "UPDATE config SET value = 'linear' WHERE name = 'stack_method'"
#msnoise stack -r # stack for ref only
msnoise stack -r
# select daily-ccf to stack according to correlation with all-day-stacked ccf
#csh select-days.csh
msnoise reset STACK
#msnoise stack -r
msnoise stack -m
#exit

# dv/v
#COMMENTBLOCK
# filter
#sqlite3 msnoise.sqlite "DELETE FROM filters"
#sqlite3 msnoise.sqlite "INSERT INTO filters (low, high, used, mwcs_low, mwcs_high, mwcs_wlen, mwcs_step) VALUES (0.05, 0.4, 1, 0.05, 0.4, 30, 2)"
#./msnoise_config.sh
sqlite3 msnoise.sqlite "UPDATE jobs SET flag='T' where Jobtype='DTT'"
#csh mvcc.csh
msnoise compute_mwcs
#msnoise -t 8 compute_mwcs
#COMMENTBLOCK
#./msnoise_config.sh
#sqlite3 msnoise.sqlite "UPDATE jobs SET flag='T' where Jobtype='DTT'"
msnoise compute_dtt
exit

# plot
#msnoise plot mwcs YH.LOBS8 YH.LOBS9 -m 10 -o ?
#MWCS Plot, will plot all this pair with the mov_stack = 10, output with default name (?=default)
# dv/v Plot
msnoise plot dvv -cEE -o ?
msnoise plot dvv -cEN -o ?
msnoise plot dvv -cNN -o ?
msnoise plot dvv -cZE -o ?
msnoise plot dvv -cZN -o ?
msnoise plot dvv -cZZ -o ?
#msnoise plot dtt Z7.HRIM Z7.LIND 2014-08-10 -f 14 -m 20 # dt/t Plot
