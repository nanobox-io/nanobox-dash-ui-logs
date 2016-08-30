module.exports = class Follower

  #
  _isFollowingLog: false

  #
  constructor : (@options) ->

    #
    @options.trigger.click (e) => @_toggleFollowLog()

    #
    $(window).scroll (e) =>

      # detach the follow link as it scrolls off the page
      @options.trigger.removeClass('locked').addClass('following') if (@options.approach - window.scrollY <= -50)

      # attach the follow link as it comes back into view
      @options.trigger.removeClass('following').addClass('locked') if (@options.approach - window.scrollY >= -50)

      # unfollow if the user scrolls [100px] away from the bottom of the page
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
