(function e(t,n,r){function s(o,u){if(!n[o]){if(!t[o]){var a=typeof require=="function"&&require;if(!u&&a)return a(o,!0);if(i)return i(o,!0);var f=new Error("Cannot find module '"+o+"'");throw f.code="MODULE_NOT_FOUND",f}var l=n[o]={exports:{}};t[o][0].call(l.exports,function(e){var n=t[o][1][e];return s(n?n:e)},l,l.exports,e,t,n,r)}return n[o].exports}var i=typeof require=="function"&&require;for(var o=0;o<r.length;o++)s(r[o]);return s})({1:[function(require,module,exports){
window.init = function() {
  var logs, options;
  options = {
    liveConfig: {
      url: "wss://proxy.nanobox.io/1c43fbab-8d75-4a38-b191-98d32ce4cb04/mist/subscribe/websocket?X-AUTH-TOKEN=eP524w9IpvfXQ8lRCcFBqLmdrMayUKOhHt3EAsuWojZiVJS7nz",
      tags: ["log"],
      logging: {
        enabled: true,
        level: "DEBUG"
      }
    },
    historicConfig: {
      url: "https://proxy.nanobox.io/1c43fbab-8d75-4a38-b191-98d32ce4cb04/logvac/logs?X-USER-TOKEN=01DifGBnr8xVjds4ACKY5oERTkc6gePMXuqZawtOLFIlpvUzym",
      type: "app",
      id: "",
      limit: 50,
      logging: {
        enabled: true,
        level: "DEBUG"
      }
    }
  };
  logs = new nanobox.Logs($("body"), $("#absolute-wrapper"), options);
  return logs.build();
};

},{}]},{},[1])
//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJzb3VyY2VzIjpbIi4uL25vZGVfbW9kdWxlcy9icm93c2VyLXBhY2svX3ByZWx1ZGUuanMiLCJzdGFnZS5jb2ZmZWUiXSwibmFtZXMiOltdLCJtYXBwaW5ncyI6IkFBQUE7QUNBQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBIiwiZmlsZSI6ImdlbmVyYXRlZC5qcyIsInNvdXJjZVJvb3QiOiIiLCJzb3VyY2VzQ29udGVudCI6WyIoZnVuY3Rpb24gZSh0LG4scil7ZnVuY3Rpb24gcyhvLHUpe2lmKCFuW29dKXtpZighdFtvXSl7dmFyIGE9dHlwZW9mIHJlcXVpcmU9PVwiZnVuY3Rpb25cIiYmcmVxdWlyZTtpZighdSYmYSlyZXR1cm4gYShvLCEwKTtpZihpKXJldHVybiBpKG8sITApO3ZhciBmPW5ldyBFcnJvcihcIkNhbm5vdCBmaW5kIG1vZHVsZSAnXCIrbytcIidcIik7dGhyb3cgZi5jb2RlPVwiTU9EVUxFX05PVF9GT1VORFwiLGZ9dmFyIGw9bltvXT17ZXhwb3J0czp7fX07dFtvXVswXS5jYWxsKGwuZXhwb3J0cyxmdW5jdGlvbihlKXt2YXIgbj10W29dWzFdW2VdO3JldHVybiBzKG4/bjplKX0sbCxsLmV4cG9ydHMsZSx0LG4scil9cmV0dXJuIG5bb10uZXhwb3J0c312YXIgaT10eXBlb2YgcmVxdWlyZT09XCJmdW5jdGlvblwiJiZyZXF1aXJlO2Zvcih2YXIgbz0wO288ci5sZW5ndGg7bysrKXMocltvXSk7cmV0dXJuIHN9KSIsIndpbmRvdy5pbml0ID0gZnVuY3Rpb24oKSB7XG4gIHZhciBsb2dzLCBvcHRpb25zO1xuICBvcHRpb25zID0ge1xuICAgIGxpdmVDb25maWc6IHtcbiAgICAgIHVybDogXCJ3c3M6Ly9wcm94eS5uYW5vYm94LmlvLzFjNDNmYmFiLThkNzUtNGEzOC1iMTkxLTk4ZDMyY2U0Y2IwNC9taXN0L3N1YnNjcmliZS93ZWJzb2NrZXQ/WC1BVVRILVRPS0VOPWVQNTI0dzlJcHZmWFE4bFJDY0ZCcUxtZHJNYXlVS09oSHQzRUFzdVdvalppVkpTN256XCIsXG4gICAgICB0YWdzOiBbXCJsb2dcIl0sXG4gICAgICBsb2dnaW5nOiB7XG4gICAgICAgIGVuYWJsZWQ6IHRydWUsXG4gICAgICAgIGxldmVsOiBcIkRFQlVHXCJcbiAgICAgIH1cbiAgICB9LFxuICAgIGhpc3RvcmljQ29uZmlnOiB7XG4gICAgICB1cmw6IFwiaHR0cHM6Ly9wcm94eS5uYW5vYm94LmlvLzFjNDNmYmFiLThkNzUtNGEzOC1iMTkxLTk4ZDMyY2U0Y2IwNC9sb2d2YWMvbG9ncz9YLVVTRVItVE9LRU49MDFEaWZHQm5yOHhWamRzNEFDS1k1b0VSVGtjNmdlUE1YdXFaYXd0T0xGSWxwdlV6eW1cIixcbiAgICAgIHR5cGU6IFwiYXBwXCIsXG4gICAgICBpZDogXCJcIixcbiAgICAgIGxpbWl0OiA1MCxcbiAgICAgIGxvZ2dpbmc6IHtcbiAgICAgICAgZW5hYmxlZDogdHJ1ZSxcbiAgICAgICAgbGV2ZWw6IFwiREVCVUdcIlxuICAgICAgfVxuICAgIH1cbiAgfTtcbiAgbG9ncyA9IG5ldyBuYW5vYm94LkxvZ3MoJChcImJvZHlcIiksICQoXCIjYWJzb2x1dGUtd3JhcHBlclwiKSwgb3B0aW9ucyk7XG4gIHJldHVybiBsb2dzLmJ1aWxkKCk7XG59O1xuIl19
