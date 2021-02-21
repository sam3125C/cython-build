#!/bin/bash

# Yang Rong Individual Service
# All Rights Reserved @2021
#
# 构建脚本，处理构建脚本的调用、源代码和不交付内容的删除、交付内容的合并。
#
# @author: Yang Rong
# @version 1.01
# @email: samyang3125c@gmail.com
# @create: 2021-02-21

# variable define
work_path=$(cd $(dirname $0); pwd)
relative_source_src="/src"
absolute_source_src="${work_path}${relative_source_src}"
relative_so_src="/build/lib.linux-x86_64-3.6/src"
absolute_so_src="${work_path}${relative_so_src}"

echo "[INFO] begin make so files..."
export PYTHONPATH=$work_path && python3 build.py build_ext
echo "[INFO] success make so files."

echo "[INFO] begin handle main.pyc..."
export PYTHONPATH=$work_path && python3 -m compileall -b "${absolute_source_src}/main.py"
cp "${absolute_source_src}/main.pyc" "${absolute_so_src}/main.pyc"
echo "[INFO] succeed handle main.pyc."

echo "[INFO] begin merge deliverd src dir..."
find ${absolute_source_src} -type d -name "__pycache__" -exec rm -rf {} \;
find ${absolute_source_src} -type f -name "*.py" -exec rm {} -f \;
find ${absolute_source_src} -type f -name "*.c" -exec rm {} -f \;
cp -r ${absolute_so_src}/* ${absolute_source_src}/
echo "[INFO] succeed merge deliverd src dir."

echo "[INFO] begin delete undeliverd files..."
del_dir_or_file=".git .idea .gitignore venv tmp test tests README.md requirements.txt build.py build.sh build"
for i in ${del_dir_or_file}
do
    rm ${work_path}/$i -rf
done
echo "[INFO] success delete undeliverd files."
