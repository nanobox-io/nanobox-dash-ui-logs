The connection strings for the live and historic streams follow standard URI
scheme format:

`scheme:[//[user:password@]host[:port]][/]path[?query][#fragment]`

## Usage

```coffeescript

#
options = {
  liveURI:     "ws://127.0.0.1:8888/subscribe/websocket?x-auth-token=TOKEN",
  historicURI: "https://127.0.0.1:1234?x-auth-token=TOKEN",
  tags:        ["log"],
}

#
logs = new nanobox.Logs $(".logs"), options
logs.build()
```

#### Options
| Option=default | Description |
|---|---|
| logsEnabled=false | Is logging enabled (T/F) |
| logLevel="INFO" | Selected log level of [available levels](https://github.com/sdomino/dash/blob/master/src/dash.coffee#L8) |
| historicHost="" | The IP to `GET` historic logs from |
| historicToken="" | The token to use when requesting historic logs |
| liveHost="" | The IP to connect the live stream websocket too |
| liveToken="" | The token to use when connecting the live socket |
| tags="" | The tags to `subscribe` when connecting the live stream |

#### Notice
This component was specifically designed to work with [nanopack/mist](https://github.com/nanopack/mist) and [nanopack/logvac](https://github.com/nanopack/logvac) and therefore makes use of [nanopack/mist-client-js](https://github.com/nanopack/mist-client-js) and [nanopack/logvac-client-js](https://github.com/nanopack/logvac-client-js) for all connections to, and communication with, those services (please see their respective README's for any troubleshooting).
