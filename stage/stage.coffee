window.init = () ->

  # scheme:[//[user:password@]host[:port]][/]path[?query][#fragment]

  #
  options = {
    liveURI:     "ws://127.0.0.1:8888/subscribe/websocket?x-auth-token=TOKEN"
    historicURI: "https://192.241.237.185:6361/logs?X-USER-TOKEN=dTV1hpXryUmeZf4vsxCtjigG3cBHz5YA608Mk2PSKOWIFwNQaE"
    tags:        ["log"],
  }

  #
  logs = new nanobox.Logs $(".logs"), options
  logs.build()
