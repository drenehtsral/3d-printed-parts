#!/bin/bash

if [ $# -eq 0 ]; then
    echo "Usage: $0 <infile>..."
    echo "Set the STL_XFORM variable if you want to transform the imported STL before projection and export."
    exit 1
fi

for f in "$@"; do
    file_dir="$(cd $(dirname ${f}) && pwd)"
    file_base="$(basename ${f})"
    from_file="${file_dir}/${file_base}"
    
    to_file="${from_file%%.stl}.dxf"
    tmp_file=$(mktemp)
    echo "projection(cut=true) ${STL_XFORM} import(\"${from_file}\");" > ${tmp_file}
    if openscad --render -o "${to_file}" ${tmp_file}; then
        echo "Converted ${from_file} to ${to_file}."
        rm ${tmp_file}
    else
        code=$?
        rm ${tmp_file}
        exit ${code}
    fi
done
