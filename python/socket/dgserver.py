import socket
port=9001 
s=socket.socket(socket.AF_INET,socket.SOCK_DGRAM)

s.bind(('',port))
print('pending...')
count =0
while True:
    data,addr=s.recvfrom(1024)
#    print('Received:',data,'from',addr)
    count+=1
    print('Received:',count,'from',addr)
