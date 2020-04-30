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
echo '#  Unzipping ', ${work_path}
echo '#'

# Construct Paths
file_name=${work_path##*/}
file_name_no_ext=${file_name%.*}
extract_directory=${work_directory}/${file_name_no_ext}


# Debug: Show Paths
echo "!! extract_directory", ${extract_directory}
python ${code_directory}/log.py "Info" "Started extracting into ${extract_directory}" ${file_name} "$0" "$LINENO"

# Extract Zip
echo "   Extracting without folder structure"
unzip -j ${work_path} -d ${extract_directory}

python ${code_directory}/log.py "Info" "Done extracting without folder structure" ${file_name} "$0" "$LINENO"

# Move the files to output and write the new url to the message queue
${code_directory}/move_to_output.sh ${code_directory} ${mq_write} ${output_directory} ${extract_directory}/*

echo '   Done'

