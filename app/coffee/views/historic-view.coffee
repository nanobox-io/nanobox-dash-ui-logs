historicView = require 'jade/historic-view'

#
module.exports = class Historic

  #
  constructor: ($el, id, @stats) ->
    @$node = $(historicView({labels:@stats}))
    $el.append @$node

    @build()
    @subscribeToLogsData(id)

  #
  build : () ->

  #
  updateLiveLogs : (data) =>
    self = @

  #
  subscribeToSLogsata : (id) ->
    PubSub.publish 'STATS.SUBSCRIBE.LIVE', {
      statProviderId : id
      callback       : @updateLiveStats
    }


#
# class Dashboard.AppLogsView.Historical
#
#   #
#   @load: () ->
#
#     # connect to live stream
#     stubs = [
#       {time: new Date(), log: "web2.apache[access] 69.92.84.90 - - [03/Dec/2013:19:59:57 +0000] \"GET / HTTP/1.1\" 200 183 \"-\" \"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/31.0.1650.57 Safari/537.36\"\n"},
#       {time: new Date(), log: "web2.apache[Access] 69.92.84.90 - - [03/Dec/2013:19:59:57 +0000] \"GET / HTTP/1.1\" 200 183 \"-\" \"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/31.0.1650.57 Safari/537.36\"\n"},
#       {time: new Date(), log: "web2.apache[aCcess] 69.92.84.90 - - [03/Dec/2013:19:59:57 +0000] \"GET / HTTP/1.1\" 200 183 \"-\" \"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/31.0.1650.57 Safari/537.36\"\n"},
#       {time: new Date(), log: "web2.apache[acCess] 69.92.84.90 - - [03/Dec/2013:19:59:57 +0000] \"GET / HTTP/1.1\" 200 183 \"-\" \"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/31.0.1650.57 Safari/537.36\"\n"},
#       {time: new Date(), log: "web2.apache[accEss] 69.92.84.90 - - [03/Dec/2013:19:59:57 +0000] \"GET / HTTP/1.1\" 200 183 \"-\" \"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/31.0.1650.57 Safari/537.36\"\n"},
#       {time: new Date(), log: "web2.apache[acceSs] 69.92.84.90 - - [03/Dec/2013:19:59:57 +0000] \"GET / HTTP/1.1\" 200 183 \"-\" \"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/31.0.1650.57 Safari/537.36\"\n"},
#       {time: new Date(), log: "web2.apache[accesS] 69.92.84.90 - - [03/Dec/2013:19:59:57 +0000] \"GET / HTTP/1.1\" 200 183 \"-\" \"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/31.0.1650.57 Safari/537.36\"\n"},
#       {time: new Date(), log: "web2.apache[access] 69.92.84.90 - - [03/Dec/2013:19:59:57 +0000] \"GET / HTTP/1.1\" 200 183 \"-\" \"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/31.0.1650.57 Safari/537.36\"\n"},
#       {time: new Date(), log: "web2.apache[Access] 69.92.84.90 - - [03/Dec/2013:19:59:57 +0000] \"GET / HTTP/1.1\" 200 183 \"-\" \"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/31.0.1650.57 Safari/537.36\"\n"},
#       {time: new Date(), log: "web2.apache[aCcess] 69.92.84.90 - - [03/Dec/2013:19:59:57 +0000] \"GET / HTTP/1.1\" 200 183 \"-\" \"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/31.0.1650.57 Safari/537.36\"\n"}
#     ]
#
#     # load logs
#     Dashboard.AppLogsView.load_logs(stubs)
#
# #   @_name = _name
# #   log_name : 'historical'
# #
# #   #
# #   viewDidAppear : () ->
# #     @$entries   = @$node.find('.entries')
# #     @$stream    = @$node.find('#history-stream')
# #     @$view_more = @$node.find('#view-more')
# #
# #   # anything unique to this view that needs to happen on show
# #   show_view : () ->
# #     @wipe_logs()
# #     @reset_view()
# #     @load_historical_data()
# #
# #   # anything unique to this view that needs to happen on hide
# #   hide_view : () ->
# #     @wipe_logs()
# #     @reset_view()
# #     delete @last_entry
# #     @$view_more.removeClass('no-historical')
# #
# #   # anything unique to this view that needs to be set/reset goes in here
# #   reset_view : () ->
# #     @loading = false
# #     @$view_more.removeClass('loading')
# #
# #   #
# #   load_historical_data : () ->
# #     unless @loading
# #       @loading = true
# #
# #       @$view_more.addClass('loading')
# #
# #       @update_status @$node, "retrieving-history-log"
# #
# #       #
# #       start = (@last_entry?.time - 1) || (new Date().getTime()*1000)
# #       url = if Dashboard.ENV == 'DEVELOPMENT'
# #         '/sample_logs'
# #       else
# #         "https://log.#{Dashboard.ROOT_DOMAIN}/app/#{Dashboard.current_app?.get('safe_id')}?start=#{start}"
# #
# #       # get logs
# #       $.ajax(
# #         type:     "GET"
# #         url: url
# #         headers:  'X-AUTH-TOKEN': Dashboard.current_user.get('logvac_token')
# #
# #       ).done( ( data, textStatus, jqXHR ) =>
# #         @update_status @$node, "loading-records"
# #
# #         # if there is data build the log
# #         if (data = JSON.parse(data)) && data.length
# #           @clear_status @$node
# #
# #           @add_entry(entry) for entry in data
# #
# #           @last_entry = @log.entries.get('first')
# #           @last_entry.styles += " background:#1D4856;"
# #
# #           # insert logs at 60fps, we do this to give it a nice streaming effect
# #           @print_last_log()
# #
# #         # no historical data
# #         else
# #           @reset_view()
# #           @clear_logs()
# #
# #           @update_status @$node, "no-historical"
# #           @$view_more.addClass('no-historical')
# #
# #       # api failed
# #       ).fail( ( jqXHR, textStatus, errorThrown ) =>
# #         @clear_status @$node
# #         @reset_view()
# #         switch textStatus
# #           when 'timeout', 'parsererror' then @update_status @$node, "communication-error"
# #           when 'error', 'abort' then @update_status @$node, "api-failed"
# #           else return
# #       )
# #
# #   # calls itself recursively until there are no more logs
# #   print_last_log : () =>
# #
# #     if @log.entries.length > 0
# #       entry = @log.entries.get('last')
# #       @log.entries.remove entry
# #
# #       # we only want to wait to print the next one if this one passes the filter
# #       # otherwise you get long pauses between entries as it's slowly looping
# #       # over ones that don't pass the filter
# #       if @message_passes_filter(entry.message)
# #         @prepend_entry(entry, true)
# #         setTimeout @print_last_log, 1000 / 60
# #       else
# #         @prepend_entry(entry, false)
# #         @print_last_log()
# #
# #     else
# #       @reset_view()
# #       @clear_logs()
# #
# #   # This does the inserting of the HTML
# #   prepend_entry : (entry, show) ->
# #     entry.log = "&nbsp;" if (entry.log.length == 0)
# #
# #     $entry = $("<div class=entry style='#{entry.styles}; opacity:0; display:none;'>
# #           <div class=time>#{entry.short_date_time}</div>
# #           <div class=service>#{entry.service}</div>
# #         </div>")
# #
# #
# #     $message = $("<span class='message' style='#{entry.styles}; opacity:0; display:none;'></span>")
# #       .text(entry.message)
# #       .css(display:'inline-block')
# #       .animate({ opacity:1 }, { duration:250 })
# #
# #     $message.data '$entry', $entry
# #
# #     @$entries?.prepend $entry
# #     @$stream?.prepend $message
# #     # if it doesn't match the filter we add it, but don't show it
# #     if show
# #       $entry.css(display: 'inline-block')
# #         .animate({ opacity:1 }, { duration:250 })
# #
# #       $message.css(display: 'inline-block')
# #         .animate({opacity:1}, {duration:250})
# #     else
# #       $entry.css   display:'none', opacity:1
# #       $message.css display:'none', opacity:1
