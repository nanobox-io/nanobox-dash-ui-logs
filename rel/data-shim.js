(function e(t,n,r){function s(o,u){if(!n[o]){if(!t[o]){var a=typeof require=="function"&&require;if(!u&&a)return a(o,!0);if(i)return i(o,!0);var f=new Error("Cannot find module '"+o+"'");throw f.code="MODULE_NOT_FOUND",f}var l=n[o]={exports:{}};t[o][0].call(l.exports,function(e){var n=t[o][1][e];return s(n?n:e)},l,l.exports,e,t,n,r)}return n[o].exports}var i=typeof require=="function"&&require;for(var o=0;o<r.length;o++)s(r[o]);return s})({1:[function(require,module,exports){
window.init = function() {
  var logs, options;
  options = {
    liveConfig: {
      url: "wss://192.241.237.185:1446/subscribe/websocket?X-AUTH-TOKEN=QPFBgYNe1mclW5Di6Vsh4ALyjHUMT7qSzCwJxu0fkbZOd8ERIv",
      tags: ["log"],
      logging: {
        enabled: true,
        level: "DEBUG"
      }
    },
    historicConfig: {
      url: "https://192.241.237.185:6361/logs?X-USER-TOKEN=dTV1hpXryUmeZf4vsxCtjigG3cBHz5YA608Mk2PSKOWIFwNQaE",
      type: "app",
      id: "",
      limit: 50,
      logging: {
        enabled: true,
        level: "DEBUG"
      }
    }
  };
  logs = new nanobox.Logs($(".logs"), options);
  return logs.build();
};

},{}]},{},[1])
//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJzb3VyY2VzIjpbIi4uL25vZGVfbW9kdWxlcy9ndWxwLWNvZmZlZWlmeS9ub2RlX21vZHVsZXMvYnJvd3NlcmlmeS9ub2RlX21vZHVsZXMvYnJvd3Nlci1wYWNrL19wcmVsdWRlLmpzIiwic3RhZ2UuY29mZmVlIl0sIm5hbWVzIjpbXSwibWFwcGluZ3MiOiJBQUFBO0FDQUE7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQSIsImZpbGUiOiJnZW5lcmF0ZWQuanMiLCJzb3VyY2VSb290IjoiIiwic291cmNlc0NvbnRlbnQiOlsiKGZ1bmN0aW9uIGUodCxuLHIpe2Z1bmN0aW9uIHMobyx1KXtpZighbltvXSl7aWYoIXRbb10pe3ZhciBhPXR5cGVvZiByZXF1aXJlPT1cImZ1bmN0aW9uXCImJnJlcXVpcmU7aWYoIXUmJmEpcmV0dXJuIGEobywhMCk7aWYoaSlyZXR1cm4gaShvLCEwKTt2YXIgZj1uZXcgRXJyb3IoXCJDYW5ub3QgZmluZCBtb2R1bGUgJ1wiK28rXCInXCIpO3Rocm93IGYuY29kZT1cIk1PRFVMRV9OT1RfRk9VTkRcIixmfXZhciBsPW5bb109e2V4cG9ydHM6e319O3Rbb11bMF0uY2FsbChsLmV4cG9ydHMsZnVuY3Rpb24oZSl7dmFyIG49dFtvXVsxXVtlXTtyZXR1cm4gcyhuP246ZSl9LGwsbC5leHBvcnRzLGUsdCxuLHIpfXJldHVybiBuW29dLmV4cG9ydHN9dmFyIGk9dHlwZW9mIHJlcXVpcmU9PVwiZnVuY3Rpb25cIiYmcmVxdWlyZTtmb3IodmFyIG89MDtvPHIubGVuZ3RoO28rKylzKHJbb10pO3JldHVybiBzfSkiLCJ3aW5kb3cuaW5pdCA9IGZ1bmN0aW9uKCkge1xuICB2YXIgbG9ncywgb3B0aW9ucztcbiAgb3B0aW9ucyA9IHtcbiAgICBsaXZlQ29uZmlnOiB7XG4gICAgICB1cmw6IFwid3NzOi8vMTkyLjI0MS4yMzcuMTg1OjE0NDYvc3Vic2NyaWJlL3dlYnNvY2tldD9YLUFVVEgtVE9LRU49UVBGQmdZTmUxbWNsVzVEaTZWc2g0QUx5akhVTVQ3cVN6Q3dKeHUwZmtiWk9kOEVSSXZcIixcbiAgICAgIHRhZ3M6IFtcImxvZ1wiXSxcbiAgICAgIGxvZ2dpbmc6IHtcbiAgICAgICAgZW5hYmxlZDogdHJ1ZSxcbiAgICAgICAgbGV2ZWw6IFwiREVCVUdcIlxuICAgICAgfVxuICAgIH0sXG4gICAgaGlzdG9yaWNDb25maWc6IHtcbiAgICAgIHVybDogXCJodHRwczovLzE5Mi4yNDEuMjM3LjE4NTo2MzYxL2xvZ3M/WC1VU0VSLVRPS0VOPWRUVjFocFhyeVVtZVpmNHZzeEN0amlnRzNjQkh6NVlBNjA4TWsyUFNLT1dJRndOUWFFXCIsXG4gICAgICB0eXBlOiBcImFwcFwiLFxuICAgICAgaWQ6IFwiXCIsXG4gICAgICBsaW1pdDogNTAsXG4gICAgICBsb2dnaW5nOiB7XG4gICAgICAgIGVuYWJsZWQ6IHRydWUsXG4gICAgICAgIGxldmVsOiBcIkRFQlVHXCJcbiAgICAgIH1cbiAgICB9XG4gIH07XG4gIGxvZ3MgPSBuZXcgbmFub2JveC5Mb2dzKCQoXCIubG9nc1wiKSwgb3B0aW9ucyk7XG4gIHJldHVybiBsb2dzLmJ1aWxkKCk7XG59O1xuIl19
