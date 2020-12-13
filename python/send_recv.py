import socket
from struct import unpack
import sys

flag=1

f1 = open('change_circuit_1_x.dat','r')
f2 = open('change_circuit_1.dat','r')
fw = open('send.dat','w')
for li in f1:
    d = int(li)
    if d>=0:
        s = '{0:0>32}'.format(bin(int(d))[2:])
    else:
        s = '{0:0>32}'.format(bin(abs((int(d)^0xffffffff)+1))[2:])
    if not flag:
        fw.write(32*'1'+s) # 二进制
    else:
        fw.write(8*'f'+'{0:0>8}'.format(hex(int(s,2))[2:]))
    fw.write('\n')
for li in f2:
    a, b, c = li.split(' ')
    if not flag:
        fw.write('{0:0>16}{1:0>16}'.format(bin(int(a))[2:],bin(int(b))[2:]))
    else:
        fw.write('{0:0>4}{1:0>4}'.format(hex(int(a))[2:],hex(int(b))[2:]))
    d = int(c)
    if d>=0:
        s = '{0:0>32}'.format(bin(int(d))[2:])
    else:
        s = '{0:0>32}'.format(bin(abs((int(d)^0xffffffff)+1))[2:])
    if not flag:
        fw.write(s) # 二进制
    else:
        fw.write('{0:0>8}'.format(hex(int(s,2))[2:]))
    fw.write('\n')

f1.close()
f2.close()
fw.close()

def chunks(lst, n):
    for i in range(0, len(lst), n):
        yield lst[i:i + n]

with open('send.dat','r') as fr, socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s, open('ans.txt', 'w') as ans:
    print("Connecting")
    s.connect((sys.argv[1], int(sys.argv[2])))
    print("sending")
    rd = fr.readlines()
    for i in rd:
        for j in range(8):
            s.send(int(i[2*j:2*j+2],16).to_bytes(1,'little'))
    recv = bytearray()
    while True:
        buf = s.recv(1024)
        if not buf:
            break
        recv.extend(buf)
    print("{} bytes received".format(len(recv)))
    import sys

    for x in chunks(recv, 8):
        print(unpack('>q', x)[0], file=ans)

