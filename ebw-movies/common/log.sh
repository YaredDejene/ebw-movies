#!/bin/bash

# arg1: work_path
# arg2: code directory
# arg3: log level ... possible values: Critical, Error, Warning, Info
# arg4: message           
# arg5: error_in
# arg6: line_no

work_path=${1}
code_directory=${2}
log_level=${3}
message=${4}
error_in=${5}
line_no=${6}

# Get step name from get_step_name.sh
step_name=$(${code_directory}/get_step_name.sh)

# Call log api 
python ${code_directory}/log.py ${work_path} ${log_level} ${message} ${error_in} ${line_no}