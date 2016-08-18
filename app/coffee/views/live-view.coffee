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
    @mist.on "mist:command.publish:[#{@tags.join()}]", (key, data) =>
      @main.clear_status()

      #
      for log in [data]

        #
        window.scrollTo(0, document.body.scrollHeight) if @main.following_log

        # this should stop any mist entriest that come across with rogue data that
        # we won't be able to format as a log
        try
          @_addEntry(@main.format_entry({time: moment(), log: log.data}))

  #
  _addEntry: (entry) ->

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
