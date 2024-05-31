#!/bin/bash


# provisioner.sh
echo "Provisioning environment"
./instance.sh nyc 33                         # _We can pass arguments and run commands normally, using files that are in other locations
./dns.sh myhome.com
echo "Provisioning  complete!"

# instance.sh
region=$1
size=$2

# dns.sh
domain=$1



# NOTE: we can do this in two ways: by sourcing or running the script naturally:

. ./script.sh  # Will dump all of script 2 into script 1

#VS

./script.sh    # Note, if script 2 is run and ite depends on variables from 1, it will fail (TEST THIS). Meaning: we might need to re-dechare variables


