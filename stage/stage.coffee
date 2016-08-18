window.init = () ->

  # scheme:[//[user:password@]host[:port]][/]path[?query][#fragment]

  #
  options = {
      liveConfig: {
        url:        "wss://proxy.nanobox.io/100a4410-53e9-4913-a0eb-589a367c4d95/mist/subscribe/websocket?X-AUTH-TOKEN=QPFBgYNe1mclW5Di6Vsh4ALyjHUMT7qSzCwJxu0fkbZOd8ERIv",
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
  logs = new nanobox.Logs $(".logs"), options
  logs.build()
