#!/bin/bash
# arg1: input file spec              
# arg2: process_job              
# arg3: code directory
# arg4: input directory
# arg5: work directory
# arg6: output directory
# arg7: message queue read url
# arg8: message write read url
# arg9 ... : application params

input_file_spec=${1}
process_job=${2}
code_directory=${3}
input_directory=${4}
work_directory=${5}
output_directory=${6}
mq_read=${7}
mq_write=${8}

# Remove two first arguments to make it easy to pass the remaining params
shift 2

echo "input_file_spec: ${input_file_spec}"
echo "process_job: ${process_job}"
echo "code_directory: ${code_directory}"
echo "input_directory: ${input_directory}"
echo "work_directory: ${work_directory}"
echo "output_directory: ${output_directory}"
echo "mq_read: ${mq_read}"
echo "mq_write: ${mq_write}"
echo '***'

echo '#'
echo '#   Starting: fetch_one_and_process'
echo '#'

file_name="no"

if [ $mq_read == "-" ]; then
    # Check if there are files to process
    nfiles="$(find "${input_directory}" -name "${input_file_spec}" | wc -l)"
    echo "nfiles: ${nfiles}"
    if [ "${nfiles}" -gt "0" ]; then
        # Extract File Name in random pos
        file_num=`shuf -i1-${nfiles} -n1`
        input_path="$(find "${input_directory}" -name "${input_file_spec}" | head "-${file_num}" | tail -1)"
        file_name=${input_path##*/}
    fi
else
    # READ from Message Queue
    echo "Read from message queue"
    file_name="$(python ${code_directory}/read_from_mq.py http://10.100.189.38:8080/ random_client_id ${mq_read})"  
fi

if [ "${file_name}" != "no" ]; then

    echo "// File to process ${file_name}"

    # Construct Paths
    input_path=${input_directory}/${file_name}
    work_path=${work_directory}/${file_name}

    # Check if file already there
    found_existing="$(find "${work_directory}" -name "${file_name}" | wc -l)"
    #echo $found_existing
    if [ "${found_existing}" -eq "0" ]; then
        # Move to Workspace
        echo "  Moving to Workspace ${input_path} ${work_path}"
        mv ${input_path} ${work_path}
        
        # Run the job 
        ${process_job} "${work_path}" "$@"

        # Cleanup
        rm -rf $work_path

        exit 0
    else
        echo "// File ${file_name} already exists in working dir ... skipping operation"
        exit 1
    fi
else
    echo "// No file to process"
    exit 1
fi
