#
module.exports = class Historic

  #
  constructor: (@$node, @options={}, @main) ->

    #
    Eventify.extend(@)

    # parse the uri and build our connection credentials
    uri = new URI(@options.url);
    host = "#{uri.protocol()}://#{uri.host()}#{uri.path()}"
    auth = "X-USER-TOKEN=#{uri.query(true)["X-USER-TOKEN"]}"

    # perpare connection options
    @logvacOptions = {
      host:         host,
      auth:         auth,
      type:         @options.type  || "app"
      id:           @options.id    || ""
      limit:        @options.limit || 50
      logging:      @options.logging
    }

    # connect to logvac
    @logvac = new Logvac(@logvacOptions)

    # setup event handlers
    @_handleDataLoad()
    @_handleDataError()
    @_handleViewMoreLogs()

    # we don't need to call load here for the inital set of logs, thats done by
    # main

  # when this view is loaded...
  load: () -> @_loadHistoricalData()

  # when this view is unloaded...
  unload: () -> delete @lastEntry

  # handle data
  _handleDataLoad: () ->
    @logvac.on "logvac:_xhr.load", (key, data) =>

      #
      @main.update_status "loading-records"

      # parse log data
      try
        @logs = JSON.parse(data)
      catch
        console.error "Unable to parse data - #{data}"

      # get the last entry and format it
      @lastEntry = @logs[0]
      @lastEntry = @main.format_entry(@lastEntry)

      # we reverse the array here because the logs or ordered oldest to newest
      # and we want to build them from the bottom up, newest to oldest
      for log, i in @logs.reverse()
        @_addEntry(@main.format_entry(log), (1000/60)*i)

      # dont allow more logs to load until the current set has finished
      setTimeout (=> @_resetView() ), (1000/60)*@logs.length

  # handle error
  _handleDataError: () ->
    @logvac.on "logvac:_xhr.error", (key, data) =>
      @_resetView()
      @main.update_status "communication-error"

  # load more logs
  _handleViewMoreLogs: () -> @$node.find('#view-more-logs').click () => @_loadHistoricalData()

  # unless we're already loading log, get the next set of logs (based off the last
  # entry of the previous set)
  _loadHistoricalData: () ->
    unless @loading
      @loading = true
      @fire "historic.loading"

      #
      @main.update_status "retrieving-history-log"

      # get the next set of logs from the last time of the previous set
      @logvacOptions.start = (@lastEntry?.utime || 0)
      @logvac.get(@logvacOptions)

  # this does the inserting of the HTML
  _addEntry : (entry, delay) ->

    # if the log has no length add a space
    entry.log = "&nbsp;" if (entry.log.length == 0)

    # if the time of this entry is the same as the last entry then highlight it
    entry.styles += "background:#1D4856;" if (entry.utime == @lastEntry.utime)

    # build the entry
    $entry = $(
      "<div class=entry style='#{entry.styles}; opacity:0;'>
        <div class=meta time>#{entry.short_date_time}&nbsp;&nbsp;::&nbsp;&nbsp;</div>
        <div class=meta id>#{entry.id}&nbsp;&nbsp;::&nbsp;&nbsp;</div>
        <div class=meta tag>#{entry.tag}</div>
      </div>"
    ).delay(delay).animate({opacity:1}, {duration:250})

    #
    $message = $("<span class='message' style='#{entry.styles}; opacity:0;'>#{entry.log}</span>")
      .data('$entry', $entry)
      .delay(delay).animate({opacity:1}, {duration:250})

    #
    setTimeout (=>
      @main.$entries?.prepend $entry
      @main.$stream?.prepend $message
    ), delay

  #
  _resetView: () ->
    @fire "historic.loaded"
    @loading = false
    @main.update_status ""
