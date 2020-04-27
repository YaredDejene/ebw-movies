#!/bin/bash
# 
# arg1: step_name
# arg2: code directory
# arg3: mq_write
# arg4: output directory
# arg5 ... : files to move

step_name=${1}
code_directory=${2}
mq_write=${3}
output_directory=${4}

# Remove the first four argument to make it easy to loop through files
shift 4

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

    # Write to message queue
    if [ "${mq_write}" != "-" ]; then
        echo "   Writing file url ${file_name} to a message queue ${mq_write}"
        result="$(python ${code_directory}/write_to_mq.py http://10.100.189.38:8080/ ${step_name} ${mq_write} ${file_name})"

        echo "   Result: ${result}"      
    fi   
    
done


