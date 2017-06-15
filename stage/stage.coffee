window.init = () ->

  # scheme:[//[user:password@]host[:port]][/]path[?query][#fragment]

  #
  options = {
      liveConfig: {
        url:        "ws://dashlog.dev:1445/subscribe/websocket?X-AUTH-TOKEN=secret",
        #url:        "wss://proxy.nanobox.io/83230d12-eb19-4451-9b00-4dde7df40b4b/mist/subscribe/websocket?X-AUTH-TOKEN=I6lxc8LdwzGWNZYBEQnsF1Dro4kea029V3MTpjPKuhJgmHOf7A",
        tags:       ["log"],
        logging:    {enabled: true, level: "DEBUG"}
      },

      historicConfig: {
        url:        "http://dashlog.dev:6360/logs?X-USER-TOKEN=secret",
        #url:        "https://proxy.nanobox.io/83230d12-eb19-4451-9b00-4dde7df40b4b/logvac/logs?X-USER-TOKEN=RU9MLGPxgcfpjs1hAtNuIQFTew4qOnJ6oEvdHi3BSYrz7yK05X",
        type:       "app",
        id:         "",
        limit:      50,
        logging:    {enabled: true, level: "DEBUG"}
      },
    }

  #
  logs = new nanobox.Logs $("body"), $("#absolute-wrapper"), options
  logs.build()
