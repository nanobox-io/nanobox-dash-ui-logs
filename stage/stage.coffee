window.init = () ->

  # scheme:[//[user:password@]host[:port]][/]path[?query][#fragment]

  #
  options = {
      liveConfig: {
        url:        "wss://192.241.237.185:1446/subscribe/websocket?X-AUTH-TOKEN=QPFBgYNe1mclW5Di6Vsh4ALyjHUMT7qSzCwJxu0fkbZOd8ERIv",
        tags:       ["log"],
        logging:    {enabled: true, level: "DEBUG"}
      },

      historicConfig: {
        url:        "https://192.241.237.185:6361/logs?X-USER-TOKEN=dTV1hpXryUmeZf4vsxCtjigG3cBHz5YA608Mk2PSKOWIFwNQaE",
        type:       "app",
        id:         "",
        limit:      50,
        logging:    {enabled: true, level: "DEBUG"}
      },
    }

  #
  logs = new nanobox.Logs $(".logs"), options
  logs.build()
