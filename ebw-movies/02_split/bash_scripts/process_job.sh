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
echo '#  Splitting ', ${work_path}
echo '#'

# Construct Paths
file_name=${work_path##*/}
file_name_no_ext=${file_name%.*}
extract_directory=${work_directory}/${file_name_no_ext}

split_file_suffix="${work_directory}/${file_name_no_ext}/${file_name_no_ext}-"

# Debug: Show Paths
echo "!! work_path", ${work_path}
echo "!! extract_directory", ${extract_directory}
echo "!! split_file_suffix", ${split_file_suffix}


# Split files
mkdir ${extract_directory}

# Debug: Show Paths
echo "!! extract_directory", ${extract_directory}
python ${code_directory}/log.py "Info" "Started splitting file into ${extract_directory}" ${file_name} "$0" "$LINENO"

echo "   Split file int work directory"
split -l 800000 --additional-suffix=.tsv ${work_path}  ${split_file_suffix}

python ${code_directory}/log.py "Info" "Done splitting file into" ${file_name} "$0" "$LINENO"

# Move the files to output and write the new url to the message queue
${code_directory}/move_to_output.sh ${code_directory} ${mq_write} ${output_directory} ${extract_directory}/*

# Cleanup
rm -rf $extract_directory
python ${code_directory}/log.py "Info" "Removed temporary working directory: ${extract_directory}" ${file_name} "$0" "$LINENO"

echo '   Done'

