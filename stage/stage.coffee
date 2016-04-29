TestData = require './shim/test-data'
window.statsDataSimultor = new TestData()

window.init = () ->
  statsDataSimultor.createFakeLogProvider()

  # Live logs
  live = new nanobox.Logs "live", $(".live")
  live.build()

  # Historic
  historic = new nanobox.Logs "historic", $(".historic")
  historic.build()
