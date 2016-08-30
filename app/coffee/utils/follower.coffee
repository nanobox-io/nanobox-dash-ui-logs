module.exports = class Follower

  #
  _isFollowingLog: false

  #
  constructor : (@options) ->

    #
    @options.trigger.click (e) => @_toggleFollowLog()

    # unfollow if the user scrolls [100px] away from the bottom of the page
    $(window).scroll (e) =>
      @_unfollowLog() if ((window.innerHeight + window.scrollY) + 50) <= document.body.scrollHeight

  #
  _toggleFollowLog: () -> if @_isFollowingLog then @_unfollowLog() else @_followLog()

  #
  _followLog: () ->

    # immediately drop to the bottom of the log then every [100ms] drop again;
    # this should keep up with pretty rapid log entry
    window.scrollTo(0, document.body.scrollHeight)
    @follow ||= setInterval ( () =>
      window.scrollTo(0, document.body.scrollHeight)
    ), 100

    @options.trigger.addClass('active')
    @_isFollowingLog = true

  #
  _unfollowLog: () ->
    clearInterval @follow
    @options.trigger.removeClass('active')
    @_isFollowingLog = false
