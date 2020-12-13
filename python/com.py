# com.py

import sys
import difflib

def read_file(filename):
    try:
        with open(filename, 'r') as f:
            return f.readlines()
    except IOError:
        print("ERROR: 没有找到文件:%s或读取文件失败！" % filename)
        sys.exit(1)

def compare_file(file1, file2, out_file):
    file1_content = read_file(file1)
    file2_content = read_file(file2)
    d = difflib.HtmlDiff()
    result = d.make_file(file1_content, file2_content)
    with open(out_file, 'w') as f:
        f.writelines(result)

if __name__ == '__main__':
    compare_file(r'decode_receive.dat', r'verilog_should_outdata.dat', r'compare_result.html')

# ————————————————
# 版权声明：本文为CSDN博主「FLPython」的原创文章，遵循CC 4.0 BY-SA版权协议，转载请附上原文出处链接及本声明。
# 原文链接：https://blog.csdn.net/weixin_36485376/java/article/details/80042227