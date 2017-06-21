window.init = () ->

  # scheme:[//[user:password@]host[:port]][/]path[?query][#fragment]

  #
  options = {
      liveConfig: {
        url:        "ws://dashlog.dev:1445/subscribe/websocket?X-AUTH-TOKEN=secret",
        tags:       ["log"],
        logging:    {enabled: true, level: "DEBUG"}
      },

      historicConfig: {
        url:        "http://dashlog.dev:6360/logs?X-USER-TOKEN=secret",
        type:       "app",
        id:         "",
        limit:      50,
        logging:    {enabled: true, level: "DEBUG"}
      },
    }

  #
  logs = new nanobox.Logs $("body"), $("#absolute-wrapper"), options
  logs.build()
