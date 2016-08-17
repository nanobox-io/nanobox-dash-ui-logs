#
module.exports = class Historic

  #
  constructor: (@$node, @options) ->

    #
    Eventify.extend(@)

    #
    @main = @options.main

    # parse the uri
    uri = new URI(@options.historicURI);

    # perpare connection options
    @lvOptions = {
      logsEnabled:  @options.logsEnabled,
      logLevel:     @options.logLevel,
      host:         "#{uri.protocol()}://#{uri.host()}#{uri.path()}",
      auth:         "X-USER-TOKEN=#{uri.query(true)["X-USER-TOKEN"]}"
      type:         @options.type || "app"
      id:           @options.id || "" # used for filtering by component logs
      limit: 3
    }

    # connect to logvac
    @logvac = new Logvac(@lvOptions)

    # handle data load
    @logvac.on "logvac:_xhr.load", (key, data) =>

      #
      @main.update_status "loading-records"

      #
      try

        #
        @logs = JSON.parse(data)

        # this is what a single entry might look like
        # {
        #   "time": "2016-08-17T17:20:42.8182469Z",
        #   "utime": 1471454442818246900,
        #   "id": "worker.sequences",
        #   "tag": "app[daemon]",
        #   "type": "app",
        #   "priority": 4,
        #   "message": "2016-08-17T17:20:42.81737 2016-08-17T17:20:42.817Z 148 TID-11sjmo Sequenceable::Workers::ResumeWorker JID-fee63832a025ed302317e962 INFO: done: 0.101 sec"
        # }

        # get the last entry and convert it into a formatable entry
        @lastEntry = @logs[0]
        console.log "LAST", @lastEntry
        @lastEntry = @main.format_entry(@lastEntry)

        # we reverse the array here because the logs or ordered oldest to newest
        # and we want to build them from the bottom up newest to oldest
        for log, i in @logs.reverse()
          @addEntry(@main.format_entry(log), (1000/60)*i)

        # dont allow more logs to load until the current set has finished
        setTimeout (=> @resetView() ), (1000/60)*@logs.length

      #
      catch
        console.error "Unable to parse data - #{data}"

    # handle error
    @logvac.on "logvac:_xhr.error", (key, data) =>
      @resetView()
      @main.update_status "communication-error"

  #
  load: () ->

    # load more logs
    @$node.find('#view-more-logs').click () => @loadHistoricalData()

    # load initial logs
    @loadHistoricalData()

  #
  unload: () -> delete @lastEntry

  #
  loadHistoricalData: () ->
    unless @loading
      @loading = true
      @fire "historic.loading"

      #
      @main.update_status "retrieving-history-log"

      ## update options
      # get the next set of logs from the last time of the previous set; convert
      # start time from milliseconds to nanoseconds
      @lvOptions.start = (@lastEntry?.utime || 0)

      # get logs
      @logvac.get(@lvOptions)

  #
  resetView: () ->
    @fire "historic.loaded"
    @loading = false
    @main.update_status ""

  # this does the inserting of the HTML
  addEntry : (entry, delay) ->

    # if the log has no length add a space
    entry.log = "&nbsp;" if (entry.log.length == 0)

    # if the time of this entry is the same as the last entry then highlight it
    entry.styles += "background:#1D4856;" if (entry.utime == @lastEntry.utime)

    # build the entry
    $entry = $(
      "<div class=entry style='#{entry.styles}; opacity:0;'>
        <div class=time>#{entry.short_date_time}</div>
        <div class=service>#{entry.id}</div>
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
