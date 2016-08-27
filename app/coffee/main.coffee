component    = require 'jade/component'
LiveView     = require 'views/live-view'
HistoricView = require 'views/historic-view'

#
class Logs

  #
  _processes:  []
  _colors:     ['#009484', '#99D0D3', '#707C87', '#D56D44', '#1F6367', '#62808B']

  #
  constructor: ($el, @options={}) ->

    #
    @$node = $(component())
    $el.append @$node

  # build creates a new component based on the @view that is passed in when
  # instantiated
  build : () ->

    # get reusable nodes
    @$thing   = @$node.find(".log-display")
    @$entries = @$thing.find(".entries")
    @$stream  = @$thing.find(".messages")

    # add svg icons
    castShadows(@node)

    #
    @liveView = new LiveView @$node, @options.liveConfig, @
    @historicView = new HistoricView @$node, @options.historicConfig, @

    # setup event handlers
    @liveView.on "live.loading", () => @$thing.addClass("loading")
    @liveView.on "live.loaded", () => @$thing.removeClass("loading")
    @historicView.on "historic.loading", () => @$thing.addClass("loading")
    @historicView.on "historic.loaded", () => @$thing.removeClass("loading")

    #
    @_activateToggles()

    # load live by default
    @liveView.load()
    @currentLog = "liveView"

  # load_logs: (logs) =>
  #   window.scrollTo(0, document.body.scrollHeight) if @following_log
  #   @filter_logs()

  #
  # {
  #   "time": "2016-08-17T17:20:42.8182469Z",
  #   "utime": 1471454442818246900,
  #   "id": "worker.sequences",
  #   "tag": "app[daemon]",
  #   "type": "app",
  #   "priority": 4,
  #   "message": "2016-08-17T17:20:42.81737 2016-08-17T17:20:42.817Z 148 TID-11sjmo Sequenceable::Workers::ResumeWorker JID-fee63832a025ed302317e962 INFO: done: 0.101 sec"
  # }
  format_entry: (entry) =>

    entry.short_date_time = moment(entry.time).format("DD MMM, h:mm a")
    entry.log = "#{entry.message}".replace(/\s?\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}.\d+Z|\s?\d{4}-\d{2}-\d{2}[_T]\d{2}:\d{2}:\d{2}.\d{5}|\s?\d{4}-\d{2}-\d{2}\s\d{2}:\d{2}:\d{2}/gm, "")#.replace(/(\r\n|\n|\r)/gm,"\r\n");

    # add any 'new' processes to an array
    @_processes.push entry.tag unless _.includes(@_processes, entry.tag)

    # set the entry color index to be (processes.length % colors.length)
    entry.styles = "color:#{@_colors[(_.indexOf(@_processes, entry.tag)%@_colors.length)]};"

    #
    entry

  #
  # follow_log = () ->
  #
  #   # we only need to setup the button once
  #   unless @follow_setup
  #     @following_log  = false
  #     @$original_top  = parent.find('.follow-holder').offset().top
  #     @$follow_log    = parent.find('.follow-log')
  #
  #     @follow_setup = true
  #
  #   # we only want one timeout so we set scroll to iteslf if its already been
  #   # created.
  #   @scroll ||= setInterval ( () =>
  #     # detach the follow link as it scrolls off the page
  #     if (@$original_top - window.scrollY < 0) then @$follow_log.removeClass('locked').addClass('following')
  #     else @$follow_log.removeClass('following').addClass('locked')
  #
  #     # unfollow if the user scrolls away from the bottom of the page
  #     unless ((window.innerHeight + window.scrollY) + 100) >= document.body.scrollHeight
  #       @deactivate_follow()
  #   ), 100

  #
  # unfollow_log = () -> clearInterval @scroll

  #
  # toggle_follow = () ->
  #   if @following_log then @deactivate_follow()
  #   else @activate_follow()

  #
  # activate_follow = () ->
  #   window.scrollTo( 0, document.body.scrollHeight )
  #   @$follow_log?.addClass('active')
  #   @following_log = true

  #
  # deactivate_follow = () ->
  #   @$follow_log?.removeClass('active')
  #   @following_log = false

  #
  update_status: (status) =>
    @$thing.removeClass @currentStatus
    @$thing.addClass status

    @currentStatus = status

  #
  clear_status: =>
    @$thing.removeClass @currentStatus
    @currentStatus = ''

  # _activateToggles
  _activateToggles: =>
    @$node.find(".logs-panel .toggle").change (e) =>

      # reset the view
      @_processes = []
      @$entries?.empty()
      @$stream?.empty()

      #
      log = $(e.currentTarget).data("toggle")
      @$thing.removeClass "live historic"
      @$thing.addClass log

      #
      @[@currentLog].unload()
      @currentLog = "#{log}View"
      @[@currentLog].load()

#
window.nanobox ||= {}
nanobox.Logs = Logs
