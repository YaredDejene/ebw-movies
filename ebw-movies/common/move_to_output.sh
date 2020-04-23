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

    # Write to message queue
    if [ "${mq_write}" != "-" ]; then
        echo "   Writing file url ${file_name} to a message queue ${mq_write}"
        result="$(python ${code_directory}/write_to_mq.py http://10.100.189.38:8080/ random_client_id ${mq_write} ${file_name})"

        echo "   Result: ${result}"      
    fi   
    
done


