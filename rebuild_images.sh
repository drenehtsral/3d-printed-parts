#!/bin/bash

tmp_file=$(mktemp)
echo "#Contents" > ${tmp_file}

find . -type f -name '*.scad' | (while read model; do
    model_name="$(basename ${model%%.scad})"
    model_dir="$(dirname ${model})"
    img_dir="./images/${model_dir#./}"
    img_out="${img_dir}/${model_name}.png"
    if [ ! -d "${img_dir}" ]; then
        mkdir -p "${img_dir}" || exit 1
    fi
    
    if [ "${model}" -nt "${img_out}" ]; then
        if openscad --render --projection=p --viewall --autocenter --imgsize 320,240 -o "${img_out}" "${model}"; then
            echo "Rendered ${model} to ${img_out}."
            echo "[![${model}](${img_out})](${model})" >> ${tmp_file}
        else
            code=$?
            echo "Cannot create image of ${model}."
            exit ${code}
        fi
    else
        echo "${model} older than ${img_out} ... skipping."
        echo "[![${model}](${img_out})](${model})" >> ${tmp_file}
    fi
done; )

mv ${tmp_file} CONTENTS.md