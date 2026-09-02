import {Socket} from "phoenix"

let socket = new Socket("/socket")
socket.connect()

window.productChannel = socket.channel("product:lobby", {})

window.productChannel.join()
  .receive("ok", resp => {
    console.log("Joined product channel", resp)
  })
  .receive("error", resp => {
    console.log("Unable to join product channel", resp)
  })

export default socket