set -ex

sqlite3 msnoise.sqlite "UPDATE config SET value = '*' WHERE name = 'channels'"
sqlite3 msnoise.sqlite "UPDATE config SET value = 'Z1,Z2,12' WHERE name = 'components_to_compute'"
sqlite3 msnoise.sqlite "UPDATE config SET value = '2014-05-15' WHERE name = 'startdate'"
sqlite3 msnoise.sqlite "UPDATE config SET value = '2015-06-23' WHERE name = 'enddate'"
sqlite3 msnoise.sqlite "UPDATE config SET value = '300' WHERE name = 'maxlag'"
sqlite3 msnoise.sqlite "UPDATE config SET value = '2014-05-15' WHERE name = 'ref_begin'"
sqlite3 msnoise.sqlite "UPDATE config SET value = '2015-06-23' WHERE name = 'ref_end'"
#sqlite3 msnoise.sqlite "UPDATE config SET value = '2014-09-23' WHERE name = 'ref_end'"
#-------------------------

sqlite3 msnoise.sqlite "UPDATE config SET value = 'data' WHERE name='data_folder'"

# msnoise config --set data_folder=data/

sqlite3 msnoise.sqlite "UPDATE config SET value = 'ccf' WHERE name = 'output_folder'"
sqlite3 msnoise.sqlite "UPDATE config SET value = 'BUD' WHERE name = 'data_structure'"
# msnoise config --set network=""
#msnoise config --set startdate="2014-xx-xx"
#msnoise config --set enddate="2014-xx-xx"

# msnoise config --set analysis_duration=default,86400s
sqlite3 msnoise.sqlite "UPDATE config SET value = '20' WHERE name = 'cc_sampling_rate'"
sqlite3 msnoise.sqlite "UPDATE config SET value = 'Resample' WHERE name = 'resampling_method'"
# msnoise config --set decimation_factor=be ignored if you don't use decimate method # no this parameter in 1.5!!!
sqlite3 msnoise.sqlite "UPDATE config SET value = '2.0' WHERE name = 'preprocess_lowpass'"
sqlite3 msnoise.sqlite "UPDATE config SET value = '0.02' WHERE name = 'preprocess_highpass'"
# 50 s

sqlite3 msnoise.sqlite "UPDATE config SET value = 'N' WHERE name = 'remove_response'"
#msnoise config --set response_format=paz
#msnoise config --set response_path=data_folder/PZs
#msnoise config --set response_prefilt="(0.001,0.002,1.8,2)"
sqlite3 msnoise.sqlite "UPDATE config SET value = '14400' WHERE name = 'corr_duration'"
sqlite3 msnoise.sqlite "UPDATE config SET value = '0.7' WHERE name = 'overlap'" 
sqlite3 msnoise.sqlite "UPDATE config SET value = '3' WHERE name = 'windsorizing'" 
# windorizing at N time RMS, -1 means 1-bit 
sqlite3 msnoise.sqlite "UPDATE config SET value = 'A' WHERE name = 'whitening'"
#sqlite3 msnoise.sqlite "UPDATE config SET value = 'pws' WHERE name = 'stack_method'"
sqlite3 msnoise.sqlite "UPDATE config SET value = 'linear' WHERE name = 'stack_method'"
#sqlite3 msnoise.sqlite "UPDATE config SET value = '10.0' WHERE name = 'pws_timegate'"
#sqlite3 msnoise.sqlite "UPDATE config SET value = '2.0' WHERE name = 'pws_power'"

sqlite3 msnoise.sqlite "UPDATE config SET value = 'Y' WHERE name = 'autocorr'"
sqlite3 msnoise.sqlite "UPDATE config SET value = 'N' WHERE name = 'keep_all'"
sqlite3 msnoise.sqlite "UPDATE config SET value = 'Y' WHERE name = 'keep_days'"
# 
sqlite3 msnoise.sqlite "UPDATE config SET value = 'SAC' WHERE name = 'export_format'"
# msnoise config --set sac_format= ???

# for velocity changes
# msnoise config --set crondays=for velocity changes, ignore
sqlite3 msnoise.sqlite "UPDATE config SET value = '1,10,20,30' WHERE name = 'mov_stack'"
sqlite3 msnoise.sqlite "UPDATE config SET value = 'static' WHERE name = 'dtt_lag'"
#sqlite3 msnoise.sqlite "UPDATE config SET value = '0.2' WHERE name = 'dtt_v'"
sqlite3 msnoise.sqlite "UPDATE config SET value = '0' WHERE name = 'dtt_minlag'"
sqlite3 msnoise.sqlite "UPDATE config SET value = '70' WHERE name = 'dtt_width'"
sqlite3 msnoise.sqlite "UPDATE config SET value = 'both' WHERE name = 'dtt_sides'"
sqlite3 msnoise.sqlite "UPDATE config SET value = '0.88' WHERE name = 'dtt_mincoh'"
sqlite3 msnoise.sqlite "UPDATE config SET value = '0.1' WHERE name = 'dtt_maxerr'"
sqlite3 msnoise.sqlite "UPDATE config SET value = '0.2' WHERE name = 'dtt_maxdt'"

# msnoise config --set plugins=default

# msnoise 1.5
