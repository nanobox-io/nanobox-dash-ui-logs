TestData = require './shim/test-data'
window.statsDataSimultor = new TestData()

window.init = () ->
  statsDataSimultor.createFakeLogProvider()

  # Live logs
  logs = new nanobox.Logs $(".logs")
  logs.build()
