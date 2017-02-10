window.init = () ->

  # scheme:[//[user:password@]host[:port]][/]path[?query][#fragment]

  #
  options = {
      liveConfig: {
        url:        "wss://proxy.nanobox.io/1c43fbab-8d75-4a38-b191-98d32ce4cb04/mist/subscribe/websocket?X-AUTH-TOKEN=eP524w9IpvfXQ8lRCcFBqLmdrMayUKOhHt3EAsuWojZiVJS7nz",
        tags:       ["log"],
        logging:    {enabled: true, level: "DEBUG"}
      },

      historicConfig: {
        url:        "https://proxy.nanobox.io/1c43fbab-8d75-4a38-b191-98d32ce4cb04/logvac/logs?X-USER-TOKEN=01DifGBnr8xVjds4ACKY5oERTkc6gePMXuqZawtOLFIlpvUzym",
        type:       "app",
        id:         "",
        limit:      50,
        logging:    {enabled: true, level: "DEBUG"}
      },
    }

  #
  logs = new nanobox.Logs $("body"), $("#absolute-wrapper"), options
  logs.build()
