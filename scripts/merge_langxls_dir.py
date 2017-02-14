#!/usr/bin/env python
# -*- coding:utf-8 -*-
# File          : merge_langxls_dir.py
# Author        : bssthu
# Project       : eso_zh_ui
# Description   : 以目录1为基准，把目录2的文件导入目录1里
# 


import os
import sys

from utils.langxls_loader import get_filename_and_category
from merge_langxls import merge_translation_file


def usage():
    print('usage:')
    print('python merge_langxls_dir.py dest_dir src_dir diff_dir')
    print('by default keep dest if conflict')


def main():
    if len(sys.argv) not in (3, 4):
        usage()
        sys.exit(2)

    # init path
    dest_xls_path, src_xls_path = sys.argv[1], sys.argv[2]
    conflict_xls_path = None
    if len(sys.argv) == 4:
        conflict_xls_path = sys.argv[3]

    # check category
    print('-- dest dir')
    dest_filename_to_category = get_filename_and_category(dest_xls_path)
    print('-- src dir')
    src_filename_to_category = get_filename_and_category(src_xls_path)

    # match & merge
    print('-- match')
    conflict_filename = None
    for dest_filename, dest_category in sorted(dest_filename_to_category.items()):
        for src_filename, src_category in sorted(src_filename_to_category.items()):
            if dest_category == src_category:
                if conflict_xls_path is not None:
                    conflict_filename = 'diff_%s===%s.xlsx' % (os.path.splitext(os.path.basename(dest_filename))[0],
                                                        os.path.splitext(os.path.basename(src_filename))[0])
                    conflict_filename = os.path.join(conflict_xls_path, conflict_filename)
                print('%s X %s' % (dest_filename, src_filename))
                merge_translation_file(dest_filename, src_filename, conflict_filename)


if __name__ == '__main__':
    main()