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
echo '#  TSV to CSV ', ${work_path}
echo '#'

# Construct Paths
file_name=${work_path##*/}
file_name_no_ext=${file_name%.*}
file_name_csv="${file_name_no_ext}.csv"
work_path_csv=${work_directory}/${file_name_csv}


echo "!! work_path_csv", ${work_path_csv}
${code_directory}/log.sh "Info" "Started converting a tsv file ${file_name} into csv" ${file_name} "$0" "$LINENO"

# Converting TSV -> CSV
echo "   Converting TSV > CSV"
tr '\t' , < ${work_path} > ${work_path_csv}

${code_directory}/log.sh "Info" "Done converting a tsv file ${file_name} into ${file_name_csv}" ${file_name} "$0" "$LINENO"

# Move the files to output and write the new url to the message queue
${code_directory}/move_to_output.sh ${code_directory} ${mq_write} ${output_directory} ${work_path_csv}


echo '   Done'

