module.exports = class LiveView

  #
  constructor: (@$node, @options={}, @main) ->

    # add events
    Eventify.extend(@)

    #
    @tags = @options.tags

    # connect to mist; we connect on instantiation to only connect once, then we
    # subscribe/unsubscribe as we want to receive logs
    @mist = new Mist({logging: @options.logging})
    @mist.connect(@options.url)

    # handle mist events
    @mist.on "mist:_socket.onopen", (key, data)    => @main.updateStatus "awaiting-data"
    @mist.on "mist:_socket.reconnect", (key, data) => @main.updateStatus "connecting-live"
    @mist.on "mist:_socket.onerror", (key, data)   => @main.updateStatus "communication-error"
    @mist.on "mist:_socket.onclose", (key, data)   => @main.updateStatus "communication-error"
    @mist.on "mist:command.subscribe", (key, data) => @main.updateStatus "connecting-live"

    #
    @_handleDataPublish()

  # when this view is loaded...
  load: () ->
    @main.currentLog = "liveView"
    @mist.subscribe(@tags)

  # when this view is unloaded...
  unload: () -> @mist.unsubscribe(@tags)

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

  # this does the inserting of the HTML
  _addEntry : (entry, delay) ->

    # if the log has no length add a space
    entry.log = "&nbsp;" if (entry.log.length == 0)

    # build the entry
    $entry = $(
      "<div class=entry style='#{entry.styles}; opacity:0;'>
        <div class=meta time>#{entry.short_date_time}&nbsp;&nbsp;::&nbsp;&nbsp;</div>
        <div class=meta id>#{entry.id}&nbsp;&nbsp;::&nbsp;&nbsp;</div>
        <div class=meta tag>#{entry.tag}</div>
      </div>"
    ).delay(delay).animate({opacity:1}, {duration:100})

    #
    $message = $("<span class='message' style='#{entry.styles}; opacity:0;'>#{entry.log}</span>")
      .data('$entry', $entry)
      .delay(delay).animate({opacity:1}, {duration:100})

    # historic logs prepend entries so it looks like logs are streaming upwards;
    # we stagger prepending to give it a nice streaming effect
    setTimeout (=>
      @main.$entries?.append $entry
      @main.$stream?.append $message
    ), delay
