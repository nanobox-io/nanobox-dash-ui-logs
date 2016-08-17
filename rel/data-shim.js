(function e(t,n,r){function s(o,u){if(!n[o]){if(!t[o]){var a=typeof require=="function"&&require;if(!u&&a)return a(o,!0);if(i)return i(o,!0);var f=new Error("Cannot find module '"+o+"'");throw f.code="MODULE_NOT_FOUND",f}var l=n[o]={exports:{}};t[o][0].call(l.exports,function(e){var n=t[o][1][e];return s(n?n:e)},l,l.exports,e,t,n,r)}return n[o].exports}var i=typeof require=="function"&&require;for(var o=0;o<r.length;o++)s(r[o]);return s})({1:[function(require,module,exports){
window.init = function() {
  var logs, options;
  options = {
    liveURI: "wss://192.241.237.185:1446/subscribe/websocket?X-AUTH-TOKEN=QPFBgYNe1mclW5Di6Vsh4ALyjHUMT7qSzCwJxu0fkbZOd8ERIv",
    historicURI: "https://192.241.237.185:6361/logs?X-USER-TOKEN=dTV1hpXryUmeZf4vsxCtjigG3cBHz5YA608Mk2PSKOWIFwNQaE",
    tags: ["log"]
  };
  logs = new nanobox.Logs($(".logs"), options);
  return logs.build();
};

},{}]},{},[1])
//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJzb3VyY2VzIjpbIi4uL25vZGVfbW9kdWxlcy9ndWxwLWNvZmZlZWlmeS9ub2RlX21vZHVsZXMvYnJvd3NlcmlmeS9ub2RlX21vZHVsZXMvYnJvd3Nlci1wYWNrL19wcmVsdWRlLmpzIiwic3RhZ2UuY29mZmVlIl0sIm5hbWVzIjpbXSwibWFwcGluZ3MiOiJBQUFBO0FDQUE7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQSIsImZpbGUiOiJnZW5lcmF0ZWQuanMiLCJzb3VyY2VSb290IjoiIiwic291cmNlc0NvbnRlbnQiOlsiKGZ1bmN0aW9uIGUodCxuLHIpe2Z1bmN0aW9uIHMobyx1KXtpZighbltvXSl7aWYoIXRbb10pe3ZhciBhPXR5cGVvZiByZXF1aXJlPT1cImZ1bmN0aW9uXCImJnJlcXVpcmU7aWYoIXUmJmEpcmV0dXJuIGEobywhMCk7aWYoaSlyZXR1cm4gaShvLCEwKTt2YXIgZj1uZXcgRXJyb3IoXCJDYW5ub3QgZmluZCBtb2R1bGUgJ1wiK28rXCInXCIpO3Rocm93IGYuY29kZT1cIk1PRFVMRV9OT1RfRk9VTkRcIixmfXZhciBsPW5bb109e2V4cG9ydHM6e319O3Rbb11bMF0uY2FsbChsLmV4cG9ydHMsZnVuY3Rpb24oZSl7dmFyIG49dFtvXVsxXVtlXTtyZXR1cm4gcyhuP246ZSl9LGwsbC5leHBvcnRzLGUsdCxuLHIpfXJldHVybiBuW29dLmV4cG9ydHN9dmFyIGk9dHlwZW9mIHJlcXVpcmU9PVwiZnVuY3Rpb25cIiYmcmVxdWlyZTtmb3IodmFyIG89MDtvPHIubGVuZ3RoO28rKylzKHJbb10pO3JldHVybiBzfSkiLCJ3aW5kb3cuaW5pdCA9IGZ1bmN0aW9uKCkge1xuICB2YXIgbG9ncywgb3B0aW9ucztcbiAgb3B0aW9ucyA9IHtcbiAgICBsaXZlVVJJOiBcIndzczovLzE5Mi4yNDEuMjM3LjE4NToxNDQ2L3N1YnNjcmliZS93ZWJzb2NrZXQ/WC1BVVRILVRPS0VOPVFQRkJnWU5lMW1jbFc1RGk2VnNoNEFMeWpIVU1UN3FTekN3Snh1MGZrYlpPZDhFUkl2XCIsXG4gICAgaGlzdG9yaWNVUkk6IFwiaHR0cHM6Ly8xOTIuMjQxLjIzNy4xODU6NjM2MS9sb2dzP1gtVVNFUi1UT0tFTj1kVFYxaHBYcnlVbWVaZjR2c3hDdGppZ0czY0JIejVZQTYwOE1rMlBTS09XSUZ3TlFhRVwiLFxuICAgIHRhZ3M6IFtcImxvZ1wiXVxuICB9O1xuICBsb2dzID0gbmV3IG5hbm9ib3guTG9ncygkKFwiLmxvZ3NcIiksIG9wdGlvbnMpO1xuICByZXR1cm4gbG9ncy5idWlsZCgpO1xufTtcbiJdfQ==
