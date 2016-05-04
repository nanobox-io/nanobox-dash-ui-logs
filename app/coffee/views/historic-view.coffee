#
module.exports = class Historic

  #
  constructor: (@$node, @options) ->

  #
  load: () ->

    #
    @$viewMore = @$node.find('#view-more')

    #
    @$viewMore.click () => @loadHistoricalData()

    #
    @loadHistoricalData()

  #
  unload: () -> delete @lastEntry

  #
  loadHistoricalData: () ->
    # @$viewMore.removeClass('empty')
    unless @loading
      @loading = true

      #
      @$viewMore.addClass('loading')

      #
      @options.main.update_status "retrieving-history-log"

      # convert the time from milliseconds to nanoseconds
      start = (@lastEntry?.time.valueOf()*1000000) || 0

      #
      $.ajax(
        type: "GET"
        url:  "https://#{@options.historicHost}?auth=#{@options.historicToken}&type=log&start=#{start}"
      ).done( (data, status, xhr) =>

        #
        @options.main.update_status "loading-records"

        #
        try

          #
          @logs = JSON.parse(data)
          @lastEntry = @logs[0]
          @lastEntry = @options.main.format_entry(time: moment(@lastEntry.time), log: @lastEntry.message)

          # we reverse the array here because the logs or ordered oldest to newest
          # and we want to build them from the bottom up newest to oldest
          for log, i in @logs.reverse()
            @addEntry(@options.main.format_entry({time: moment(log.time), log: log.message}), (1000/60)*i)

          # dont allow more logs to load until the current set has finished
          setTimeout (=>
            @loading = false
            @$viewMore.removeClass('loading')
            @options.main.update_status ""
          ), (1000/60)*@logs.length

        catch
          console.error "Unable to parse data - #{data}"

      # api failed
      ).fail( (xhr, status, error) =>

        #
        @options.main.wipe()

        #
        switch status
          when 'timeout', 'parsererror' then @options.main.update_status "communication-error"
          when 'error', 'abort' then @options.main.update_status "api-failed"
          else return
      )

  # This does the inserting of the HTML
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
      # .css(display:"flex")

    #
    $message = $("<span class='message' style='#{entry.styles}; opacity:0;'></span>")
      .text(entry.message)
      .data('$entry', $entry)
      .delay(delay)
      .animate({opacity:1}, {duration:250})
      # .css(display:"flex")

    #
    setTimeout (=>
      @options.main.$entries?.prepend $entry
      @options.main.$stream?.prepend $message
    ), delay
