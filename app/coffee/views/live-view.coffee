#
module.exports = class LiveView

  #
  constructor: (@$node, @options) ->

    # add events
    Eventify.extend(@)

    #
    @main = @options.main
    @tags = @options.tags

    @mistOptions = {
      logsEnabled: @options.logsEnabled,
      logLevel:    @options.logLevel
    }

    # connect to mist
    @main.update_status "connecting-live"
    @mist = new Mist(@mistOptions)
    @mist.connect(@options.liveURI)

    # subscribe once the socket is open
    # @mist.on "mist:_socket.onopen", () => @mist.subscribe(@tags)
    @mist.on "mist:_socket.reconnect", (key, data) => @main.update_status "connecting-live"
    @mist.on "mist:_socket.onerror", (key, data) => @main.update_status "communication-error"
    @mist.on "mist:_socket.onclose", (key, data) => @main.update_status "communication-error"

    # load any logs that are published for the tags we're interested in
    @mist.on "mist:command.publish:[#{@tags.join()}]", (key, data) =>
      @main.clear_status()

      #
      for log in [data]

        #
        window.scrollTo(0, document.body.scrollHeight) if @main.following_log

        # this should stop any mist entriest that come across with rogue data that
        # we won't be able to format as a log
        try
          @addEntry(@main.format_entry({time: moment(), log: log.data}))

  # this may encounter a race condition with the socket connecting on intial load
  # if so, we'll have to change it
  load: () ->
    @main.update_status "awaiting-data"
    @mist.subscribe(@tags)

  #
  unload: () -> @mist.unsubscribe(@tags)

  #
  addEntry: (entry) ->

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
    $message = $("<span class='message' style='#{entry.styles};'>#{entry.log}</span>")
      .data('$entry', $entry)

    #
    @main.$entries?.append $entry
    @main.$stream?.append $message
