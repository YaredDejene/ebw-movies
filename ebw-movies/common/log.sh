#!/bin/bash
# 


log(){
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
}


log_error()
{
    log "Error" "$@"
}

log_info()
{
    log "Info" "$@"
}

handle_error()
{
    log_error "$@"
    exit 1
}

