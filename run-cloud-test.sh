#!/bin/bash

 ######################################
# Script to run example test cases on  #
# testdroid cloud.                     #
# Requirements:                        #
#   - jq, zip, curl, bc, tr            #

DEVICE_GROUP_ID=$1
TD_API_TOKEN=$2
TD_PROJECT_NAME=$3
TEST_APP='example-debug.apk'
TD_RUN_NAME="td-ssa-examples test run"
FAILURES=0

function usage {
  echo -e "Usage:\n\t$0 <DEVICE_GROUP_ID> <API_KEY> <TD_PROJECT_NAME>"
  exit 1
}

function fail_step {
  echo "Failed step '$1'"
  FAILURES=$((FAILURES + 1))
}

function check_file_exist_and_not_empty {
  echo "Checking for file $1"
  if [ -f "$1" ]; then
    file_size=$(cat "$1" |wc -c |tr -d '[[:space:]]') #not a useless cat!
    if [ "$file_size" -lt 1 ]; then
      fail_step "File '$1' should size should be > 0"
    fi
  else
    fail_step "File '$1' should exist but does not"
  fi
}

if [ -z "${DEVICE_GROUP_ID}" ]; then usage ; fi
if [ -z "${TD_API_TOKEN}" ]; then usage ; fi
if [ -z "${TD_PROJECT_NAME}" ]; then usage ; fi

echo "Using device group with id='${DEVICE_GROUP_ID:?}'"

########################
## Run tests in cloud ##
########################
(
  rm -rf testdroid-ssa-client
  git clone https://github.com/Applifier/testdroid-ssa-client &&
  cd testdroid-ssa-client &&
  ./testdroid_cmdline.sh -u "$TD_API_TOKEN" \
                         -t "$TD_PROJECT_NAME" \
                         -a "../$TEST_APP" \
                         -r "$TD_RUN_NAME" \
                         -z ../tests/ \
                         -d "$DEVICE_GROUP_ID" \
                         -c SINGLE
) || fail_step "Run tests successfully"


###################
## Check results ##
###################
  # Results dir exist
  results_dir="testdroid-ssa-client/results"
  if [ ! -d "$results_dir" ]; then
    fail_step "results exist"
  fi
  # Check that result files exist
  check_file_exist_and_not_empty $results_dir/*_appium.log
  check_file_exist_and_not_empty $results_dir/*_console.log
  check_file_exist_and_not_empty $results_dir/*_logcat.txt
  check_file_exist_and_not_empty $results_dir/*_TEST-all.xml

if [ "$FAILURES" -gt 0 ]; then
  echo "Failed $FAILURES STEPS"
  exit $FAILURES
fi

exit 0
