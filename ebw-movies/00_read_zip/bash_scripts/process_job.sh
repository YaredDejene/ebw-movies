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


echo '#'
echo '#  Starting Process: Read zip files'
echo '#'

#import log util functions 
. ${code_directory}/log.sh

file_name=${work_path##*/}

log_info "Started file processing: collect files from source directory" "${file_name}" "$0"

# Move the files to output and write the new url to the message queue
${code_directory}/move_to_output.sh "${code_directory}" "${mq_write}" "${output_directory}" "${work_path}" \
    || handle_error "Error in collecting files from source directory" "${file_name}" "$0" "$LINENO"  

echo '   Done'



