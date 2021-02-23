#!/bin/bash

# source code path
work_path=$(cd $(dirname $0); pwd)
source_src_path="${work_path}/src"

echo "[INFO] begin make so files..."
export PYTHONPATH=$work_path && python3 build.py build_ext
echo "[INFO] success make so files."

# compiled file path
compiled_src_path="$(find "${work_path}/build" -type d -name "lib*")/src"

echo "[INFO] begin handle main.pyc..."
export PYTHONPATH=$work_path && python3 -m compileall -b "${source_src_path}/main.py"
cp "${source_src_path}/main.pyc" "${compiled_src_path}/main.pyc"
echo "[INFO] succeed handle main.pyc."

echo "[INFO] begin merge deliverd src dir..."
find /Users/yangrong/Documents/Projects/OpenSource/cython-build-test/src -type d -name "__pycache__" -exec rm -rf {} \;
find /Users/yangrong/Documents/Projects/OpenSource/cython-build-test/src -type f -name "*.py" -exec rm -f {} \;
find /Users/yangrong/Documents/Projects/OpenSource/cython-build-test/src -type f -name "*.c" -exec rm -f {} \;
cp -r ${compiled_src_path}/* ${source_src_path}/
echo "[INFO] succeed merge deliverd src dir."

echo "[INFO] begin delete undeliverd files..."
del_dir_or_file=".git .idea .gitignore LICENSE venv test README.md requirements.txt build.py build.sh build"
for i in ${del_dir_or_file}
do
    rm -rf ${work_path}/$i
done
echo "[INFO] success delete undeliverd files."
