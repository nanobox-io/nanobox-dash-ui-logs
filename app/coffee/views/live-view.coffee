#
module.exports = class LiveView

  #
  constructor: (@$node, @options) ->

    #
    @options.main.update_status "connecting-live"
    @mist = new Mist({logsEnabled: true, logLevel: "INFO"})
    @mist.connect("ws://#{@options.liveHost}/subscribe/websocket?x-auth-token=#{@options.liveToken}")

    #
    @tags = @options.tags

    # subscribe once the socket is open
    # @mist.on "mist:_socket.onopen", () => @mist.subscribe(@tags)

    # load any logs that are published for the tags we're interested in
    @mist.on "mist:command.publish:[#{@tags.join()}]", (key, data) =>
      @options.main.clear_status()

      # @options.main.load_logs([{time: moment(), log: data.data}])
      for log in [data]
        # window.scrollTo(0, document.body.scrollHeight) if @following_log

        # this should stop any mist entriest that come across with rogue data that
        # we won't be able to format as a log
        try
          @addEntry(@options.main.format_entry({time: moment(), log: log.data}))

  # this may encounter a race condition with the socket connecting on intial load
  # if so, we'll have to change it
  load: () ->
    @options.main.update_status "awaiting-data"
    @mist.subscribe(@tags)

  #
  unload: () -> @mist.unsubscribe(@tags)

  #
  addEntry: (entry) =>

    #
    entry.log = "&nbsp;" if (entry.log.length == 0)

    #
    $entry = $(
      "<div class=entry style='#{entry.styles};'>
        <div class=time>#{entry.short_date_time}</div>
        <div class=service>#{entry.service}</div>
      </div>"
    )

    #
    $message = $("<span class='message' style='#{entry.styles};'></span>")
      .text(entry.message)
      .data('$entry', $entry)

    #
    @options.main.$entries?.append $entry
    @options.main.$stream?.append $message
