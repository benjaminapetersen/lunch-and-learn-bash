## Socket

- [A reference on sockets](https://www.linux.com/training-tutorials/end-road-systemds-socket-units/)

Service and sockets typically match name with pattern:
- echo@.service
- echo.socket

A basic socket file

```bash
# echo.socket
[Unit]
Description = Echo server

# specify what to listen for
[Socket]
# stream, datagram, sequential packets, or other things
# numbers are ports, but could be full IP address,
# a file system socket, or something else
ListenStream = 4444
# Accept is false by default. toggle to true or yes
# AF_UNIX is AF_LOCAL, or a local listener, which
# AF_INET is for communcation with other machines
# AF_INET sits on top of TCP/IP, with traffic
# congestion algorithms, backoffs and the like to handle.
# AF_UNIX is on the local machine and needs none of this
Accept = yes

[Install]
WantedBy = sockets.target
```

## Service

A basic service file

Service and sockets typically match name with pattern:
- echo@.service
- echo.socket

```bash
# echo@.service
[Unit]
Description=Echo server service

[Service]
ExecStart=/path/to/socketthing.py
StandardInput=socket
```

A `socketthing.py` script referenced by this service
could look like this:

```python
#!/usr/bin/python
import sys
sys.stdout.write(sys.stdin.readline().strip().upper() + 'rn')
```

## Starting a socket unig

```bash
sudo systemctl start echo.socket
```

Socat or another program could be used to send a message
to this socket on this remote computer:

```bash
socat - TCP:server_IP_address:4444
hello computer
HELLO COMPUTER
```
