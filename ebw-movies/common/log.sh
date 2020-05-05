#!/bin/bash
# 


log()
{
    log_level=${1}
    msg=${2}
    input_file=${3}
    source_file=${4}
    line_no=${5}


    if [ $log_level == "Error" ]; then
        mq_log="Error"
    else
        mq_log="Log"
    fi


    # format message in json format    
    timestamp=$(date --utc +%FT%T.%3NZ)
    json_template='{"time":"%s","level":"%s","message":"%s","input_file":"%s","file":"%s","line":"%s","machine":"%s","step":"%s"}'
    message_formatted=$(printf "$json_template" "$timestamp" "$log_level" "$msg" "$input_file" "$source_file" "$line_no" "$HOSTNAME" "$STEP_NAME")

    # send it to the Error/Log message queue
    kubetools queue send "${mq_log}" "${message_formatted}"
}



log_error()
{
    log "Error" "$@"
}

log_warning()
{
    log "Warning" "$@"
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

