#!/bin/bash 
# arg1: work_path
# arg2: code directory
# arg3: input directory
# arg4: work directory
# arg5: output directory
# arg6: mq_read
# arg7: mq_write

work_path=${1}
code_directory=${2}
input_directory=${3}
work_directory=${4}
output_directory=${5}
mq_write=${7}

echo "work_path: ${work_path}"
echo "code_directory: ${code_directory}"
echo "work_directory: ${work_directory}"
echo "output_directory: ${output_directory}"
echo "mq_write: ${mq_write}"
echo '***'

echo '#'
echo '#  Starting Process: Read zip files'
echo '#'

file_name=${work_path##*/}

${code_directory}/log.sh "Info" "Started file processing: collect files from source directory" ${file_name} "$0" "$LINENO"

# Move the files to output and write the new url to the message queue
${code_directory}/move_to_output.sh ${code_directory} ${mq_write} ${output_directory} ${work_path}


${code_directory}/log.sh "Info" "Done file processing" ${file_name} "$0" "$LINENO"

echo '   Done'

