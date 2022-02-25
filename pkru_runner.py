import os
import sys

import pkrudr as dromaeo
import pkrujs as jetstream
import pkrukr as kraken
import pkruoc as octane

# Check for 'data' directory
path = 'data'
if not os.path.exists(path):
    sys.exit("Missing 'data' directory. Failing early.")

# Create graph directory if not present
gpath = 'graphs'
if not os.path.exists(gpath):
    print("Creating 'graphs' directory.")
    os.makedirs(gpath)


# Generate each benchmark's graphs and print normalized tables
dromaeo.generate_dromaeo_plots()
jetstream.generate_jetstream_plots()
kraken.generate_kraken_plots()
octane.generate_octane_plots()