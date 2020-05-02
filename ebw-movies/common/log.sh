#!/bin/bash
# 
# arg1: log_level
# arg2: message
# arg3: work_path
# arg4: source_file
# arg5: line_no

log_level=${1}
message=${2}
work_path=${3}
source_file=${4}
line_no=${5}


if [ $log_level == "Error" ]; then
    mq_write="Error"
else
    mq_write="Log"
fi


# format message in json format    
timestamp=$(date)
json_template='{"time":"%s","level":"%s","message":"%s","work_path":"%s","file":"%s","line":"%s","machine":"%s","step":"%s"}'
message_formatted=$(printf "$json_template" "$timestamp" "$log_level" "$message" "$work_path" "$source_file" "$line_no" "$HOSTNAME" "$STEP_NAME")

# send it to the Error/Log message queue
kubetools queue send "${mq_write}" "${message_formatted}"


