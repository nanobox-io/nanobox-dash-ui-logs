#
module.exports = class LiveView

  #
  constructor: (@$node, @options={}, @main) ->

    # add events
    Eventify.extend(@)

    #
    @tags = @options.tags

    #
    @mistOptions = {
      logging: @options.logging
    }

    # connect to mist
    @main.update_status "connecting-live"
    @mist = new Mist(@mistOptions)
    @mist.connect(@options.url)

    # subscribe once the socket is open
    # @mist.on "mist:_socket.onopen", () => @mist.subscribe(@tags)
    @mist.on "mist:_socket.reconnect", (key, data) => @main.update_status "connecting-live"
    @mist.on "mist:_socket.onerror", (key, data) => @main.update_status "communication-error"
    @mist.on "mist:_socket.onclose", (key, data) => @main.update_status "communication-error"

    window.mist = @mist

    #
    @_handleDataPublish()

  # NOTE: this may encounter a race condition with the socket connecting on intial
  # load if so, we'll have to change it
  # when this view is loaded...
  load: () ->
    @main.update_status "awaiting-data"
    @mist.subscribe(@tags)

  # when this view is unloaded...
  unload: () -> @mist.unsubscribe(@tags)

  # load any logs that are published for the tags we're interested in
  _handleDataPublish: () ->
    # because we're only subscribing to one tag the handler needs to be formatted
    # this way rather than "mist:command.publish:[tags]"; once we subscribe to
    # multiple tags we'll do it that way
    @mist.on "mist:command.publish:#{@tags.join()}", (key, data) =>
      @main.clear_status()

      log = JSON.parse(data.data)

      window.scrollTo(0, document.body.scrollHeight) if @main.following_log

      # this should stop any mist entriest that come across with rogue data that
      # we won't be able to format as a log
      try
        @_addEntry(@main.format_entry(log))

  # this does the inserting of the HTML
  _addEntry : (entry, delay) ->

    # if the log has no length add a space
    entry.log = "&nbsp;" if (entry.log.length == 0)

    # build the entry
    $entry = $(
      "<div class=entry style='#{entry.styles};'>
        <div class=meta time>#{entry.short_date_time}&nbsp;&nbsp;::&nbsp;&nbsp;</div>
        <div class=meta id>#{entry.id}&nbsp;&nbsp;::&nbsp;&nbsp;</div>
        <div class=meta tag>#{entry.tag}</div>
      </div>"
    )

    #
    $message = $("<span class='message' style='#{entry.styles};'>#{entry.log}</span>")
      .data('$entry', $entry)

    #
    @main.$entries?.prepend $entry
    @main.$stream?.prepend $message
