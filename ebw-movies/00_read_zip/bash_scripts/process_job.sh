#!/bin/bash
# arg1: step_name     
# arg2: work_path
# arg3: code directory
# arg4: input directory
# arg5: work directory
# arg6: output directory
# arg7: mq_read
# arg8: mq_write

step_name=${1}
work_path=${2}
code_directory=${3}
input_directory=${4}
work_directory=${5}
output_directory=${6}
mq_write=${8}

echo "work_path: ${work_path}"
echo "code_directory: ${code_directory}"
echo "work_directory: ${work_directory}"
echo "output_directory: ${output_directory}"
echo "mq_write: ${mq_write}"
echo '***'

echo '#'
echo '#  Starting Process: Read zip files'
echo '#'

# Move the files to output and write the new url to the message queue
${code_directory}/move_to_output.sh ${step_name} ${code_directory} ${mq_write} ${output_directory} ${work_path}

echo '   Done'

