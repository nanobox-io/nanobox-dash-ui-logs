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
    url:        "https://127.0.0.1:1234?X-USER-TOKEN=TOKEN",
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

#### Usage with [nanobox](https://nanobox.io)

```
# start nanobox environment
nanobox run

# need to add user because logvac js client doesn't allow not setting user token
/data/bin/logvac -A boltdb:///tmp/auth.bolt add-token --token secret

# start a local mist and logvac
/data/bin/mist --server --listeners tcp://0.0.0.0:8888,ws://0.0.0.0:1445 &
sleep 1s # wait for mist to be running before starting logvac
/data/bin/logvac -p mist://localhost:8888 -P secret -d boltdb:///tmp/db.bolt -d boltdb:///tmp/db.bolt -A boltdb:///tmp/auth.bolt -i -s -a :6360 -u :6361 -t :6361 &

# prepare the dummy logs
sudo mkdir -p /var/log/gonano/logvac/
sudo mkdir -p /var/log/gonano/mist/
sudo chown gonano: /var/log/gonano/logvac/
sudo chown gonano: /var/log/gonano/mist/
touch /var/log/gonano/mist/current

# write dummy logs
while true; do echo $(date) >> /var/log/gonano/logvac/current; sleep 3s; done &

# start narc to process the logs
/opt/gonano/bin/narcd /data/etc/narc.conf &

# start the server at 8080
gulp
```

**Important!** Add the dns alias the app is using in [`stage/stage.coffee`](stage/stage.coffee).
```
# in another terminal
nanobox dns add local dashlog.dev
```
In order to use `dry-run`, you must remove the local dns entry and re-add for `dry-run`

#### Notice
This component was specifically designed to work with [nanopack/mist](https://github.com/nanopack/mist) and [nanopack/logvac](https://github.com/nanopack/logvac) and therefore makes use of [nanopack/mist-client-js](https://github.com/nanopack/mist-client-js) and [nanopack/logvac-client-js](https://github.com/nanopack/logvac-client-js) for all connections to, and communication with, those services (please see their respective README's for any troubleshooting).
