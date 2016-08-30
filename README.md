The connection strings for the live and historic streams follow standard URI
scheme format:

`scheme:[//[user:password@]host[:port]][/]path[?query][#fragment]`

## Usage

```coffeescript

#
options = {
  liveConfig: {
    url:        "wss://127.0.0.1:8888/subscribe/websocket?X-AUTH-TOKEN=TOKEN",
    tags:       ["log"],
    logging:    {enabled: true, level: "DEBUG"}
  },

  historicConfig: {
    url:        "https://127.0.0.1:1234?X-AUTH-TOKEN=TOKEN",
    type:       "app",
    id:         "",
    limit:      50,
    logging:    {enabled: true, level: "DEBUG"}
  },
}

#
logs = new nanobox.Logs $(".logs"), options
logs.build()
```

#### Notice
This component was specifically designed to work with [nanopack/mist](https://github.com/nanopack/mist) and [nanopack/logvac](https://github.com/nanopack/logvac) and therefore makes use of [nanopack/mist-client-js](https://github.com/nanopack/mist-client-js) and [nanopack/logvac-client-js](https://github.com/nanopack/logvac-client-js) for all connections to, and communication with, those services (please see their respective README's for any troubleshooting).
