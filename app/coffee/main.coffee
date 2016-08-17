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

    # set defaults
    if !@options.logsEnabled then @options.logsEnabled = false
    if !@options.loglevel then @options.logLevel = "INFO"

    #
    @$node = $(component())
    $el.append @$node

  # build creates a new component based on the @view that is passed in when
  # instantiated
  build : () ->

    # set this as the parent
    @options.main = @

    # get reusable nodes
    @$table   = @$node.find("table")
    @$entries = @$table.find("tbody .entries")
    @$stream  = @$table.find("tbody .messages")

    # add svg icons
    castShadows($(".shadow-parent"))

    #
    @liveView = new LiveView @$node, @options
    @historicView = new HistoricView @$node, @options

    # setup event handlers
    @liveView.on "live.loading", () => @$table.addClass("loading")
    @liveView.on "live.loaded", () => @$table.removeClass("loading")
    @historicView.on "historic.loading", () => @$table.addClass("loading")
    @historicView.on "historic.loaded", () => @$table.removeClass("loading")

    #
    @_activateToggles()

    # load live by default
    @liveView.load()
    @currentLog = "liveView"

  # load_logs: (logs) =>
  #     # window.scrollTo(0, document.body.scrollHeight) if @following_log
  #     # @filter_logs()

  #
  format_entry: (entry) =>

    entry.short_date_time = moment(entry.time).format("DD MMM, h:mm a")
    entry.log = "#{entry.tag} #{entry.message}\r\n"

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

    $target = @$node.find("table")

    $target.removeClass @currentStatus
    $target.addClass status

    @currentStatus = status

  #
  clear_status: =>
    @$node.find("table").removeClass @currentStatus
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
      @$table.removeClass "live historic"
      @$table.addClass log

      #
      @[@currentLog].unload()
      @currentLog = "#{log}View"
      @[@currentLog].load()

#
window.nanobox ||= {}
nanobox.Logs = Logs
