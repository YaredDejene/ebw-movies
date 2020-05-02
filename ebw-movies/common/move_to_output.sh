#!/bin/bash
# 
# arg1: code directory
# arg2: mq_write
# arg3: output directory
# arg4 ... : files to move

code_directory=${1}
mq_write=${2}
output_directory=${3}

# Remove the first three argument to make it easy to loop through files
shift 3

echo "output_directory: ${output_directory}"
echo "mq_write: ${mq_write}"

echo '***'

echo '#'
echo '#   Starting: move_to_output and write to the message queue'
echo '#'


# Loop through all files in argument list
while [ "$1" ]
do
    from_file_path=${1}
    file_name=${from_file_path##*/}
    to_file_path=${output_directory}/${file_name}
    shift
    
    echo "   Moving file ${from_file_path} to ${to_file_path}"
    mv ${from_file_path} ${to_file_path}
    ${code_directory}/log.sh "Info" "File moved ${from_file_path} to ${to_file_path}" ${file_name} "$0" "$LINENO"

    # Write to message queue
    if [  "${mq_write}" != "-" ]; then
        echo "   Writing file name ${file_name} to a message queue ${mq_write}"
        result="$(${code_directory}/write_to_mq.sh ${mq_write} ${file_name})"

        if [ -n "${result}" ]; then
            ${code_directory}/log.sh "Info" "File name ${file_name} written to a message queue ${mq_write}" ${file_name} "$0" "$LINENO"
        else
            ${code_directory}/log.sh "Error" "Error in writing a file name ${file_name} to a message queue ${mq_write}" ${file_name} "$0" "$LINENO"   
        fi

        echo "   Result: ${result}"      
    fi   
    
done
