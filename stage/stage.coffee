window.init = () ->

  # scheme:[//[user:password@]host[:port]][/]path[?query][#fragment]

  #
  options = {
      liveConfig: {
        url:        "wss://proxy.nanobox.io/632831e2-b8f9-4f18-8e95-36bd7d4e3970/mist/subscribe/websocket?X-AUTH-TOKEN=J9C30jTkFo5arNWvtxQiOwKIeuMEh81H2fpg6Ls7lG4nyPcqdZ",
        tags:       ["log"],
        logging:    {enabled: true, level: "DEBUG"}
      },

      historicConfig: {
        url:        "https://proxy.nanobox.io/100a4410-53e9-4913-a0eb-589a367c4d95/logvac/logs?X-USER-TOKEN=dTV1hpXryUmeZf4vsxCtjigG3cBHz5YA608Mk2PSKOWIFwNQaE",
        type:       "app",
        id:         "",
        limit:      50,
        logging:    {enabled: true, level: "DEBUG"}
      },
    }

  #
  logs = new nanobox.Logs $("body"), $("#absolute-wrapper"), options
  logs.build()
