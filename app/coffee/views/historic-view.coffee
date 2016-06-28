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

    # connect to logvac
    @logvac = new Logvac({logsEnabled: @options.logsEnabled, logLevel: @options.logLevel, host: "#{uri.host()}", auth: uri.query(true)["x-auth-token"]})

    # handle data load
    @logvac.on "logvac:_xhr.load", (key, data) =>

      #
      @main.update_status "loading-records"

      #
      try

        #
        @logs = JSON.parse(data)

        # get the last entry and convert it into a formatable entry
        @lastEntry = @logs[0]
        @lastEntry = @main.format_entry(time: moment(@lastEntry.time), log: @lastEntry.message)

        # we reverse the array here because the logs or ordered oldest to newest
        # and we want to build them from the bottom up newest to oldest
        for log, i in @logs.reverse()
          @addEntry(@main.format_entry({time: moment(log.time), log: log.message}), (1000/60)*i)

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

      # get logs; convert start time from milliseconds to nanoseconds
      @logvac.get({type: "log", start: ((@lastEntry?.time.valueOf()*1000000) || 0)})

  #
  resetView: () ->
    @fire "historic.loaded"
    @loading = false
    @main.update_status ""

  # this does the inserting of the HTML
  addEntry : (entry, delay) ->

    #
    entry.log = "&nbsp;" if (entry.log.length == 0)

    #
    if entry.time.isSame(@lastEntry.time)
      entry.styles += "background:#1D4856;"

    #
    $entry = $(
      "<div class=entry style='#{entry.styles}; opacity:0;'>
        <div class=time>#{entry.short_date_time}</div>
        <div class=service>#{entry.service}</div>
      </div>"
      )
      .delay(delay)
      .animate({opacity:1}, {duration:250})

    #
    $message = $("<span class='message' style='#{entry.styles}; opacity:0;'></span>")
      .text(entry.message)
      .data('$entry', $entry)
      .delay(delay)
      .animate({opacity:1}, {duration:250})

    #
    setTimeout (=>
      @main.$entries?.prepend $entry
      @main.$stream?.prepend $message
    ), delay
