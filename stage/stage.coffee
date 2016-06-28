window.init = () ->

  # scheme:[//[user:password@]host[:port]][/]path[?query][#fragment]

  #
  options = {
    liveURI:     "ws://127.0.0.1:8888/subscribe/websocket?x-auth-token=TOKEN"
    historicURI: "https://127.0.0.1:1234?x-auth-token=TOKEN"
    tags:        ["log"],
  }

  #
  logs = new nanobox.Logs $(".logs"), options
  logs.build()
