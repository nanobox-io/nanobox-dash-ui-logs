window.init = () ->

  #
  options = {
    liveHost:       "127.0.0.1:8888" ,
    liveToken:      "TOKEN",
    tags:           ["log"],
    historicHost:   "127.0.0.1:1234",
    historicToken:  "TOKEN"
  }

  #
  logs = new nanobox.Logs $(".logs"), options
  logs.build()
