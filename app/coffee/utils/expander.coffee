module.exports = class Expander

  #
  _isFullScreen: false

  #
  constructor : (@options) ->
    @options.trigger.click (e) => if @_isFullScreen then @_collapse() else @_expand()

  #
  _expand: () ->
    @options.detachNode.detach()
    @options.attachNode.append(@options.detachNode)
    @options.detachNode.addClass("expanded")
    @_isFullScreen = true

  #
  _collapse: () ->
    @options.detachNode.detach()
    @options.reattachNode.append(@options.detachNode)
    @options.detachNode.removeClass("expanded")
    @_isFullScreen = false
