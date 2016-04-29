LiveView  = require 'views/live-view'
HistoricView  = require 'views/historic-view'

#
class Logs

  # constructor
  constructor: (@view, @$el, @id, metrics=["cpu", "ram", "swap", "disk"]) ->

    # provide default data
    # @stats = []
    # for metric in metrics
    #   @stats.push {metric: metric, value: 0}

    #
    # shadowIcons = new pxicons.ShadowIcons()

  # build creates a new component based on the @view that is passed in when
  # instantiated
  build : () ->
    switch @view
      when "live"    then @component = new LiveView @$el, @id, @stats
      when "historic" then @component = new HistoricView @$el, @id, @stats

#
window.nanobox ||= {}
nanobox.Logs = Logs


# class Dashboard.AppLogsView
#
#   @_processes:  []
#   @_colors:     ['#009484', '#99D0D3', '#707C87', '#D56D44', '#1F6367', '#62808B']
#
#   @$entries: undefined
#   @$stream: undefined
#
#   #
#   constructor: (@$node) ->
#     @constructor.$entries = @$node.find("tbody .entries")
#     @constructor.$stream = @$node.find("tbody .messages")
#
#     #
#     @render()
#
#   #
#   render: () ->
#     for toggle in @$node.find(".control-panel .toggles .toggle")
#       $(toggle).click (e) =>
#
#         @constructor.wipe()
#
#         log = $(e.currentTarget).data("toggle")
#
#         @$node.removeClass "live historical build"
#         @$node.addClass log
#
#         @constructor[_.capitalize(log)].load()
#
#     # load live by default
#     @constructor.Live.load()
#
#   #
#   @load_logs: (logs) ->
#     for log in logs
#       # window.scrollTo(0, document.body.scrollHeight) if @following_log
#       @add_entry("append", @format_entry(log))
#       # @filter_logs()
#
#   #
#   @add_entry: (method, entry) ->
#     entry.log = "&nbsp;" if (entry.log.length == 0)
#
#     # if entries.children().length && stream.children().length
#     #   _entries = entries.children().eq(entry.index)
#     #   _stream  = stream.children().eq(entry.index)
#     #   method  = 'after'
#     # else
#     #   _entries = entries
#     #   stream  = stream
#     #   method  = 'append'
#
#     $entry = $("<div class=entry style='#{entry.styles};'>
#         <div class=time>#{entry.short_date_time}</div>
#         <div class=service>#{entry.service}</div>
#       </div>")
#
#     $message = $("<span class='message' style='#{entry.styles};'></span>")
#       .text(entry.message)
#
#     $message.data '$entry', $entry
#
#     # last_entry = log.entries[log.entries.length - 1]
#     # last_entry.styles += " background:#1D4856;"
#
#     @$entries[method] $entry
#     @$stream[method] $message
#
#     # if @message_passes_filter(entry.message)
#     #   $entry.css(display: 'inline-block')
#     #     .animate({ opacity:1 }, { duration:250 })
#     #
#     #   $message.css(display: 'inline-block')
#     #     .animate({opacity:1}, {duration:250})
#     # else
#     #   $entry.css   display:'none', opacity:1
#     #   $message.css display:'none', opacity:1
#
#
#   #
#   @format_entry: (data) ->
#     entry = {}
#     entry.time = data.time
#     entry.short_date_time = moment(entry.time).format("DD MMM, h:mm a")
#     entry.log = data.log
#
#     ## example data streams parsed with regex ##
#     # data.log ~= web1.apache[access] 69.92.84.90 - - [03/Dec/2013:19:59:57 +0000] \"GET / HTTP/1.1\" 200 183 \"-\" \"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/31.0.1650.57 Safari/537.36\"\n"
#     # data.log ~= storage1.mycustomlog2 69.92.84.90 - - [03/Dec/2013:19:59:57 +0000] \"GET / HTTP/1.1\" 200 183 \"-\" \"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/31.0.1650.57 Safari/537.36\"\n"
#     # data.log ~= database1.my2[customlog2] 69.92.84.90 - - [03/Dec/2013:19:59:57 +0000] \"GET / HTTP/1.1\" 200 183 \"-\" \"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/31.0.1650.57 Safari/537.36\"\n"
#     # data.log ~= cache.[mycustomlog2] 69.92.84.90 - - [03/Dec/2013:19:59:57 +0000] \"GET / HTTP/1.1\" 200 183 \"-\" \"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/31.0.1650.57 Safari/537.36\"\n"
#     #
#     # match[1] = web1
#     # match[2] = apache[access]
#     # match[3] = 69.92.84.90 - - [03/Dec/2013:19:59:57 +0000] \"GET / HTTP/1.1\" 200 183 \"-\" \"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/31.0.1650.57 Safari/537.36\"\n"
#
#     match = data.log.replace(/(\n|\r)/gm,"").match(/^(\w+)\.(\S+)\s+(.*)$/)
#
#     entry.service = match[1]
#     entry.process = match[2]
#     entry.message = "#{entry.process} #{match[3]}\r\n"
#
#     # add any 'new' processes to an array
#     @_processes.push entry.process unless _.contains(@_processes, entry.process)
#
#     # set the entry color index to be (processes.length % colors.length)
#     entry.styles = "color:#{@_colors[(_.indexOf(@_processes, entry.process)%@_colors.length)]};"
#
#     # add the new entry to the logs entries
#     # order_and_add entry
#
#     entry
#
#   #
#   # order_and_add = (entry) ->
#   #   console.log "ORDER AND ADD", entry
#   #   i = (log.entries.length - 1)
#   #
#   #   i-- while log.entries.at(i)?.time > entry.time
#   #
#   #   entry.index = i
#   #
#   #   log.entries.insertWithIndexes([entry], [i + 1])
#
#     #
#     # @observeFireAndForget @AppLogsIndexView, 'current_log', (current, previous) =>
#     #
#     #   # hide previous log
#     #   if (log_name == previous) && previous != current
#     #     parent.hide()
#     #     @hide_view()
#     #
#     #   # show current log
#     #   if (log_name == current)
#     #     # Dashboard.navigator.pushState( {}, '', Dashboard.get('routes').apps(Dashboard.current_app.get('id')).logs().path() + "?log=#{current}#{window.location.hash}")
#     #     Dashboard.Controller.params.log = current
#     #     Dashboard.navigator.pushState( {}, '', Dashboard.get('routes').apps(Dashboard.current_app.get('id')).logs().path() + "?log=#{Dashboard.Controller.params.log}&deploy=#{Dashboard.Controller.params.deploy}&loc=#{Dashboard.Controller.params.loc}")
#     #     parent.fadeIn => @show_view()
#
#     #
#     # @observeFireAndForget @, 'filter', @filter_logs
#
#     # super
#
#   # disconnect all scrolling events when we leave this view
#   # viewDidDisappear : () -> @unfollow_log()
#
#   #
#   # filter_logs = () ->
#   #   for m in $('pre.messages').children()
#   #     $m = $ m
#   #     if @message_passes_filter($m.text())
#   #       $m.css display: 'inline-block'
#   #       $m.data('$entry').css display: 'inline-block'
#   #     else
#   #       $m.css display: 'none'
#   #       $m.data('$entry').css display: 'none'
#
#   #
#   # message_passes_filter = (message) ->
#   #   filter = @get('filter') || ''
#   #
#   #   message.indexOf(filter) >= 0
#
#   #
#   # follow_log = () ->
#   #
#   #   # we only need to setup the button once
#   #   unless @follow_setup
#   #     @following_log  = false
#   #     @$original_top  = parent.find('.follow-holder').offset().top
#   #     @$follow_log    = parent.find('.follow-log')
#   #
#   #     @follow_setup = true
#   #
#   #   # we only want one timeout so we set scroll to iteslf if its already been
#   #   # created.
#   #   @scroll ||= setInterval ( () =>
#   #     # detach the follow link as it scrolls off the page
#   #     if (@$original_top - window.scrollY < 0) then @$follow_log.removeClass('locked').addClass('following')
#   #     else @$follow_log.removeClass('following').addClass('locked')
#   #
#   #     # unfollow if the user scrolls away from the bottom of the page
#   #     unless ((window.innerHeight + window.scrollY) + 100) >= document.body.scrollHeight
#   #       @deactivate_follow()
#   #   ), 100
#
#   #
#   # unfollow_log = () -> clearInterval @scroll
#
#   #
#   # toggle_follow = () ->
#   #   if @following_log then @deactivate_follow()
#   #   else @activate_follow()
#
#   #
#   # activate_follow = () ->
#   #   window.scrollTo( 0, document.body.scrollHeight )
#   #   @$follow_log?.addClass('active')
#   #   @following_log = true
#
#   #
#   # deactivate_follow = () ->
#   #   @$follow_log?.removeClass('active')
#   #   @following_log = false
#
#   #
#   @clear: () -> @_processes = []
#
#   #
#   @empty: () ->
#     @$entries?.empty()
#     @$stream?.empty()
#
#   #
#   @wipe: () ->
#     @clear()
#     @empty()
#
#   #
#   # update_status = ( node, status ) ->
#   #   @clear_status node
#   #   node.addClass status
#   #   @currentStatus = status
#
#   #
#   # clear_status = ( node ) ->
#   #   node.removeClass @currentStatus
#   #   @currentStatus = ''
