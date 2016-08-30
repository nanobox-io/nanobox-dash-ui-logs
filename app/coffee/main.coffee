LiveView      = require 'views/live-view'
HistoricView  = require 'views/historic-view'
Expander      = require 'utils/expander'
Follower      = require 'utils/follower'

#
component    = require 'jade/component'

#
class Logs

  #
  _processes:    []
  _colors:       ['#009484', '#99D0D3', '#707C87', '#D56D44', '#1F6367', '#62808B']

  #
  constructor: (@$el, @$attachNode, @options={}) ->
    @$node = $(component())
    @$el.append @$node

  # build creates a new component based on the @view that is passed in when
  # instantiated
  build : () ->

    # add svg icons
    castShadows(@node)

    #
    @$panel    = @$node.find(".log-panel")
    @$output   = @$node.find(".log-output")
    @$controls = @$output.find(".controls")
    @$entries  = @$output.find(".entries")
    @$stream   = @$output.find(".messages")

    # create our live and historic views
    @liveView = new LiveView @$node, @options.liveConfig, @
    @historicView = new HistoricView @$node, @options.historicConfig, @

    # create a log foller
    @follower = new Follower
      trigger:  @$controls.find('#follow-logs'),
      approach: @$controls.offset().top

    # create a log expander
    @expander = new Expander
      trigger:      @$controls.find('#fullscreen-toggle'),
      detachNode:   @$node,
      attachNode:   @$attachNode,
      reattachNode: @$el

    # load live by default
    @liveView.load()

    #
    @_activateToggles()

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
  updateStatus: (status) =>
    @$node.removeClass @currentStatus
    @$node.addClass status
    @currentStatus = status

  #
  clearStatus: =>
    @$node.removeClass @currentStatus
    @currentStatus = ''

  # _activateToggles
  _activateToggles: =>
    @$node.find(".log-panel .toggle").change (e) =>

      # reset the view
      @_resetView()

      #
      log = $(e.currentTarget).data("toggle")
      @$node.removeClass "live historic"
      @$node.addClass log

      #
      @[@currentLog].unload()
      @currentLog = "#{log}View"
      @[@currentLog].load()

  #
  _resetView: () =>
    @_processes = []
    @$entries?.empty()
    @$stream?.empty()

#
window.nanobox ||= {}
nanobox.Logs = Logs
