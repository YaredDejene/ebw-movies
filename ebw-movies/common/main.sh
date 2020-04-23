#!/bin/bash
# arg1: running frequency
# arg2: code directory             
# arg3: input directory
# arg4: work directory
# arg5: output directory
# arg6: message queue read url
# arg7: message queue write url

# arg8 ... : application params

frequency=${1}
code_directory=${2}
input_directory=${3}
work_directory=${4}
output_directory=${5}
mq_read=${6}
mq_write=${7}

# Remove two first argument to make it easy to pass the remaining params
shift 1

echo "frequency: ${frequency} seconds"
echo "code_directory: ${code_directory}"
echo "input_directory: ${input_directory}"
echo "work_directory: ${work_directory}"
echo "output_directory: ${output_directory}"
echo "mq_read: ${mq_read}"
echo "mq_write: ${mq_write}"

echo '***'

echo '#'
echo '#   Starting: main'
echo '#'

# What files to look for ?
echo "Fetching file pattern from: ${code_directory}/get_input_file_spec.sh"
input_file_spec=$(${code_directory}/get_input_file_spec.sh)
echo "Got filepattern: ${input_file_spec}"

while :; do

    # Call script to find a file and process it 
    "${code_directory}/fetch_one_and_process.sh" "${input_file_spec}" "${code_directory}/process_job.sh" "$@"
    
    retn_code=$?
    echo "retn_code: ${retn_code}"

    if [ ${retn_code} -eq 0 ]; then
        # File processed ... try next  
        echo "File processed successfully"
    else
        # No file processed ... wait
        sleep ${frequency}     
    fi

done

