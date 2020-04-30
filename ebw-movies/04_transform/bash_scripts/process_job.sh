#!/bin/bash
# arg1: work_path
# arg2: code directory
# arg3: input directory
# arg4: work directory
# arg5: output directory
# arg6: mq_read
# arg7: mq_write
# arg8: transformation_full_path

work_path=${1}
code_directory=${2}
input_directory=${3}
work_directory=${4}
output_directory=${5}
mq_write=${7}
transformation_full_path=${8}

echo '#'
echo '#  Cleaning using Graftenizer: ', ${work_path}
echo '#'

# Construct Paths
file_name=${work_path##*/}
file_name_no_ext=${file_name%.*}
file_name_transformed="${file_name_no_ext}-tr.csv"
work_path_transformed=${work_directory}/${file_name_transformed}


# Debug: Show Paths
echo "!! work_path_transformed", ${work_path_transformed}
python ${code_directory}/log.py "Info" "Started transforming a csv file ${file_name}" ${file_name} "$0" "$LINENO"

# Transforming
echo "   Transforming"
java -Xmx4g -jar ${transformation_full_path} \
    ${work_path} \
    ${work_path_transformed}

python ${code_directory}/log.py "Info" "Done transforming a csv file ${file_name} into ${file_name_transformed}" ${file_name} "$0" "$LINENO"

# Move the files to output and write the new url to the message queue
${code_directory}/move_to_output.sh ${code_directory} ${mq_write} ${output_directory} ${work_path_transformed}

echo '   Done'

