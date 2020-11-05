# this file is for data structure & station table population
import fileinput

def populate(data_folder):
    # Get more station info after upgrading to msnoise 1.5
    # see: http://msnoise.org/doc/master/workflow/002_populate.html
    stationdict = {}
    for line in fileinput.input('./data/stations.txt'):
        [
            network,
            station,
            longtitude,
            latitude,
            elevation
            ] = line.split(' ')[0:5]
        stationdict[network + "_" + station] = [
            network, 
            station,
            longtitude,
            latitude,
            elevation,
            'DEG',
            'N/A'
        ]
    return stationdict

print(populate("."))
