"""
Yang Rong Individual Service
All Rights Reserved @2021

构建模块，将所有源代码一一对应的打成 so 文件。

@author: Yang Rong
@version 1.0
@email: samyang3125c@gmail.com
@create: 2021-02-21
"""

import os
from pathlib import Path
from distutils.core import setup
from Cython.Build import cythonize

# 定位 src 源代码目录。
base_dir = os.path.dirname(os.path.realpath(__file__))
source_code_path = f'{base_dir}/src'
source_code_files = []

# 遍历所有 py 源代码，将其绝对路径集合。
for real_path in Path(source_code_path).rglob('*.py'):
    source_code_files.append(str(real_path))

# 将所有 py 文件打成 so 文件。
setup(ext_modules=cythonize(source_code_files))
