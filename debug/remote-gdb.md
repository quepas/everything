# Remote GDB

It is possible to debug an application on a remote host (through ssh).

First, start SSH tunnel on selected port (the GDB remote debug TCP port is `2159`) with a redirection to another port.
In the example below, we will start a remote GDB session on port `2159`, but connect to it on port `8000` from the local machine.

```shell
# On local machine:
ssh -L 8000:0.0.0.0:2159 <REMOTE_HOST>
       |              |
  Target local port   |
                      |
             Source remote port
# Once connected, on remote machine:
gdbserver :2159 <EXEC>
```

Now, it's the connection time!

```shell
gdb
# Inside GDB:
target remote localhost:8000
```

## Connect to an ongoing GDBServer session

Not a problem! Just run a new SSH tunnel along side the ongoing SSH connection.
