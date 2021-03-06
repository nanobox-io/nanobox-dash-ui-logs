module.exports = class LiveView

  #
  constructor: (@$node, @options={}, @main) ->

    # add events
    Eventify.extend(@)

    #
    @tags = @options.tags

    # create a new mist adapter
    @mist = new Mist({logging: @options.logging})

    # handle mist events
    @mist.on "mist:_socket.onopen", (key, data)    => @main.updateStatus "awaiting-data"
    @mist.on "mist:_socket.reconnect", (key, data) => @main.updateStatus "connecting-live"
    @mist.on "mist:_socket.onerror", (key, data)   => @main.updateStatus "communication-error"
    @mist.on "mist:_socket.onclose", (key, data)   => @main.updateStatus "communication-error"

    #
    @_handleDataPublish()

    # try to connect to mist; we do this once so that we only have a single
    # socket open. We'll connect after all handlers have been establed just to
    # make sure we don't miss any events.
    try
      @main.updateStatus "connecting-live"
      @mist.connect(@options.url)

      # subscribe right after connecting to ensure no messages are missed
      @_subscribe()
    catch
      @main.updateStatus "communication-error"

  # when this view is loaded...
  load: () ->
    @main.currentLog = "liveView"

    # check on the state of the socket before trying to subscribe; this helps more
    # accurately represent the state of the socket
    if @mist._socket.readyState != 1
      @main.updateStatus "communication-error"
      return

    # if the socket is connected, subscribe to messages
    @_subscribe()
    @main.updateStatus "awaiting-data"

  # when this view is unloaded...
  unload: () -> @_unsubscribe()

  #
  _subscribe: () -> @mist.subscribe(@tags);

  #
  _unsubscribe: () -> @mist.unsubscribe(@tags)

  # load any logs that are published for the tags we're interested in
  _handleDataPublish: () ->

    # because we're only subscribing to one tag the handler needs to be formatted
    # this way rather than "mist:command.publish:[tags]"; once we subscribe to
    # multiple tags we'll do it that way
    @mist.on "mist:command.publish:#{@tags.join()}", (key, data) =>
      @main.clearStatus()

      # this should stop any mist entriest that come across with rogue data that
      # we won't be able to format as a log
      try
        @_addEntry(@main.format_entry(JSON.parse(data.data)))
      catch
        console.error "Failed to parse data - #{data}"

  # this does the inserting of the HTML
  _addEntry : (entry) ->

    # if the log has no length add a space
    entry.log = "&nbsp;" if (entry.log.length == 0)

    # build the entry
    $entry = $(
      "<div class=entry style='#{entry.styles}; opacity:0;'>
        <div class=meta time>#{entry.short_date_time}&nbsp;&nbsp;::&nbsp;&nbsp;</div>
        <div class=meta id>#{entry.id}&nbsp;&nbsp;::&nbsp;&nbsp;</div>
        <div class=meta tag>#{entry.tag}</div>
      </div>"
    ).animate({opacity:1}, {duration:100})

    #
    $message = $("<span class='message' style='#{entry.styles}; opacity:0;'>#{entry.log}</span>")
      .data('$entry', $entry)
      .animate({opacity:1}, {duration:100})

    #
    @main.$entries?.append $entry
    @main.$stream?.append $message
