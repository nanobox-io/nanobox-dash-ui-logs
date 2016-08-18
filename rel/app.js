!function t(s,i,e){function n(a,r){if(!i[a]){if(!s[a]){var l="function"==typeof require&&require;if(!r&&l)return l(a,!0);if(o)return o(a,!0);var c=new Error("Cannot find module '"+a+"'");throw c.code="MODULE_NOT_FOUND",c}var d=i[a]={exports:{}};s[a][0].call(d.exports,function(t){var i=s[a][1][t];return n(i?i:t)},d,d.exports,t,s,i,e)}return i[a].exports}for(var o="function"==typeof require&&require,a=0;a<e.length;a++)n(e[a]);return n}({1:[function(t,s,i){var e,n,o,a,r=function(t,s){return function(){return t.apply(s,arguments)}};a=t("jade/component"),n=t("views/live-view"),e=t("views/historic-view"),o=function(){function t(t,s){this.options=null!=s?s:{},this._activateToggles=r(this._activateToggles,this),this.clear_status=r(this.clear_status,this),this.update_status=r(this.update_status,this),this.format_entry=r(this.format_entry,this),this.$node=$(a()),t.append(this.$node)}return t.prototype._processes=[],t.prototype._colors=["#009484","#99D0D3","#707C87","#D56D44","#1F6367","#62808B"],t.prototype.build=function(){return this.$table=this.$node.find("table"),this.$entries=this.$table.find("tbody .entries"),this.$stream=this.$table.find("tbody .messages"),castShadows($(".shadow-parent")),this.liveView=new n(this.$node,this.options.liveConfig,this),this.historicView=new e(this.$node,this.options.historicConfig,this),this.liveView.on("live.loading",function(t){return function(){return t.$table.addClass("loading")}}(this)),this.liveView.on("live.loaded",function(t){return function(){return t.$table.removeClass("loading")}}(this)),this.historicView.on("historic.loading",function(t){return function(){return t.$table.addClass("loading")}}(this)),this.historicView.on("historic.loaded",function(t){return function(){return t.$table.removeClass("loading")}}(this)),this._activateToggles(),this.liveView.load(),this.currentLog="liveView"},t.prototype.format_entry=function(t){return t.short_date_time=moment(t.time).format("DD MMM, h:mm a"),t.log=t.tag+" "+t.message+"\r\n",_.includes(this._processes,t.tag)||this._processes.push(t.tag),t.styles="color:"+this._colors[_.indexOf(this._processes,t.tag)%this._colors.length]+";",t},t.prototype.update_status=function(t){var s;return s=this.$node.find("table"),s.removeClass(this.currentStatus),s.addClass(t),this.currentStatus=t},t.prototype.clear_status=function(){return this.$node.find("table").removeClass(this.currentStatus),this.currentStatus=""},t.prototype._activateToggles=function(){return this.$node.find(".logs-panel .toggle").change(function(t){return function(s){var i,e,n;return t._processes=[],null!=(e=t.$entries)&&e.empty(),null!=(n=t.$stream)&&n.empty(),i=$(s.currentTarget).data("toggle"),t.$table.removeClass("live historic"),t.$table.addClass(i),t[t.currentLog].unload(),t.currentLog=i+"View",t[t.currentLog].load()}}(this))},t}(),window.nanobox||(window.nanobox={}),nanobox.Logs=o},{"jade/component":4,"views/historic-view":2,"views/live-view":3}],2:[function(t,s,i){var e;s.exports=e=function(){function t(t,s,i){var e,n,o;this.$node=t,this.options=null!=s?s:{},this.main=i,Eventify.extend(this),o=new URI(this.options.url),n=o.protocol()+"://"+o.host()+o.path(),e="X-USER-TOKEN="+o.query(!0)["X-USER-TOKEN"],this.logvacOptions={host:n,auth:e,type:this.options.type||"app",id:this.options.id||"",limit:this.options.limit||50,logging:this.options.logging},this.logvac=new Logvac(this.logvacOptions),this._handleDataLoad(),this._handleDataError(),this._handleViewMoreLogs()}return t.prototype.load=function(){return this._loadHistoricalData()},t.prototype.unload=function(){return delete this.lastEntry},t.prototype._handleDataLoad=function(){return this.logvac.on("logvac:_xhr.load",function(t){return function(s,i){var e,n,o,a,r;t.main.update_status("loading-records");try{t.logs=JSON.parse(i)}catch(l){console.error("Unable to parse data - "+i)}for(t.lastEntry=t.logs[0],t.lastEntry=t.main.format_entry(t.lastEntry),r=t.logs.reverse(),e=n=0,o=r.length;o>n;e=++n)a=r[e],t._addEntry(t.main.format_entry(a),1e3/60*e);return setTimeout(function(){return t._resetView()},1e3/60*t.logs.length)}}(this))},t.prototype._handleDataError=function(){return this.logvac.on("logvac:_xhr.error",function(t){return function(s,i){return t._resetView(),t.main.update_status("communication-error")}}(this))},t.prototype._handleViewMoreLogs=function(){return this.$node.find("#view-more-logs").click(function(t){return function(){return t._loadHistoricalData()}}(this))},t.prototype._loadHistoricalData=function(){var t;return this.loading?void 0:(this.loading=!0,this.fire("historic.loading"),this.main.update_status("retrieving-history-log"),this.logvacOptions.start=(null!=(t=this.lastEntry)?t.utime:void 0)||0,this.logvac.get(this.logvacOptions))},t.prototype._addEntry=function(t,s){var i,e;return 0===t.log.length&&(t.log="&nbsp;"),t.utime===this.lastEntry.utime&&(t.styles+="background:#1D4856;"),i=$("<div class=entry style='"+t.styles+"; opacity:0;'> <div class=time>"+t.short_date_time+"</div> <div class=service>"+t.id+"</div> </div>").delay(s).animate({opacity:1},{duration:250}),e=$("<span class='message' style='"+t.styles+"; opacity:0;'>"+t.log+"</span>").data("$entry",i).delay(s).animate({opacity:1},{duration:250}),setTimeout(function(t){return function(){var s,n;return null!=(s=t.main.$entries)&&s.prepend(i),null!=(n=t.main.$stream)?n.prepend(e):void 0}}(this),s)},t.prototype._resetView=function(){return this.fire("historic.loaded"),this.loading=!1,this.main.update_status("")},t}()},{}],3:[function(t,s,i){var e;s.exports=e=function(){function t(t,s,i){this.$node=t,this.options=null!=s?s:{},this.main=i,Eventify.extend(this),this.tags=this.options.tags,this.mistOptions={logging:this.options.logging},this.main.update_status("connecting-live"),this.mist=new Mist(this.mistOptions),this.mist.connect(this.options.url),this.mist.on("mist:_socket.reconnect",function(t){return function(s,i){return t.main.update_status("connecting-live")}}(this)),this.mist.on("mist:_socket.onerror",function(t){return function(s,i){return t.main.update_status("communication-error")}}(this)),this.mist.on("mist:_socket.onclose",function(t){return function(s,i){return t.main.update_status("communication-error")}}(this)),this._handleDataPublish()}return t.prototype.load=function(){return this.main.update_status("awaiting-data"),this.mist.subscribe(this.tags)},t.prototype.unload=function(){return this.mist.unsubscribe(this.tags)},t.prototype._handleDataPublish=function(){return this.mist.on("mist:command.publish:["+this.tags.join()+"]",function(t){return function(s,i){var e,n,o,a,r;for(t.main.clear_status(),a=[i],r=[],e=0,n=a.length;n>e;e++){o=a[e],t.main.following_log&&window.scrollTo(0,document.body.scrollHeight);try{r.push(t._addEntry(t.main.format_entry({time:moment(),log:o.data})))}catch(l){}}return r}}(this))},t.prototype._addEntry=function(t){var s,i,e,n;return 0===t.log.length&&(t.log="&nbsp;"),s=$("<div class=entry style='"+t.styles+";'> <div class=time>"+t.short_date_time+"</div> <div class=service>"+t.service+"</div> </div>"),i=$("<span class='message' style='"+t.styles+";'>"+t.log+"</span>").data("$entry",s),null!=(e=this.main.$entries)&&e.append(s),null!=(n=this.main.$stream)?n.append(i):void 0},t}()},{}],4:[function(t,s,i){s.exports=function(t){var s=[];return s.push('<div class="nanobox-dash-ui-logs"><table class="log-display live"><thead><tr class="logs-panel"><td class="placeholder"></td><td class="shadow-parent"><div data-toggle="live" class="toggle input radio_buttons"><label for="log-live"><img data-src="live" class="shadow-icon"/><span>Live Stream</span></label><input type="radio" name="log" id="log-live" value="live" checked="checked"/></div><div data-toggle="historic" class="toggle input radio_buttons"><label for="log-historic"><img data-src="historical" class="shadow-icon"/><span>Historical</span></label><input type="radio" name="log" id="log-historic" value="historic"/></div><p class="description live">Application logs such as stdout, stderr, etc., emitted from your application; The primary source for troubleshooting your application.</p><p class="description historic">A historic representation of the streaming log. Anything not seen during a stream can be found here.</p></td></tr><tr class="log-panel"><td class="placeholder"></td><td class="shadow-parent"><div id="follow-logs" class="locked"><img data-src="log-eye" class="shadow-icon"/></div><div id="view-more-logs"></div></td></tr></thead><tbody><tr><td><div class="entries"></div></td><td><div id="status"></div><pre class="messages selectable"></pre></td></tr></tbody></table></div>'),s.join("")}},{}]},{},[1]);var pxSvgIconString=pxSvgIconString||"";pxSvgIconString+='<g id="live" data-size="27x39" class="logs-svg-svg ">	<path class="st0" d="M4.211,18.848C-0.07,23.129-0.071,30.069,4.21,34.35c4.281,4.281,11.223,4.281,15.504,0		c4.28-4.281,4.281-11.222,0-15.503L1.573,0.707"/><path class="st0" d="M7.251,21.888c-2.602,2.601-2.602,6.819,0,9.421c2.602,2.602,6.82,2.602,9.422,0		c2.601-2.602,2.601-6.82,0-9.422L1.007,6.221"/><path class="st0" d="M10.329,24.966c-0.902,0.902-0.902,2.364,0,3.266c0.902,0.902,2.363,0.902,3.266,0		c0.902-0.902,0.902-2.364,0-3.266L1.502,12.873"/><path class="st0" d="M13.809,9.249"/><path class="st0" d="M16.85,12.29"/><path class="st0" d="M19.928,15.367"/><line class="st0" x1="13.809" y1="9.249" x2="18.849" y2="4.209"/><line class="st0" x1="16.85" y1="12.29" x2="25.829" y2="3.309"/><line class="st0" x1="23.184" y1="12.111" x2="19.928" y2="15.367"/></g><g id="deploy" data-size="37x24" class="logs-svg-svg ">	<line class="st0" x1="0" y1="1" x2="28.949" y2="1"/><line class="st0" x1="0" y1="5.385" x2="36.953" y2="5.385"/><line class="st0" x1="0" y1="9.769" x2="20.85" y2="9.769"/><line class="st0" x1="0" y1="14.154" x2="28.949" y2="14.154"/><line class="st0" x1="0" y1="18.539" x2="35.158" y2="18.539"/><line class="st0" x1="0" y1="22.924" x2="21.855" y2="22.924"/></g><g id="historical" data-size="45x33" class="logs-svg-svg ">	<rect x="12.96" y="13.427" class="st0" width="30.342" height="17.579"/><polyline class="st0" points="8.853,26.768 8.853,9.189 39.195,9.189 	"/><polyline class="st0" points="4.688,22.51 4.688,4.931 35.03,4.931 	"/><polyline class="st0" points="1,18.579 1,1 31.342,1 	"/><line class="st0" x1="17.185" y1="18.145" x2="38.309" y2="18.145"/><line class="st0" x1="17.185" y1="22.322" x2="38.309" y2="22.322"/><line class="st0" x1="17.185" y1="26.5" x2="38.309" y2="26.5"/></g><g id="log-eye" data-size="22x10" class="logs-svg-svg ">	<path class="st1" d="M21.088,6.066C18.764,2.995,15.09,1,10.942,1C6.795,1,3.121,2.995,0.798,6.066"/><path class="st1" d="M4.835,8.253C3.255,7.382,1.88,6.185,0.798,4.754"/><path class="st1" d="M21.088,4.754c-1.161,1.535-2.661,2.802-4.389,3.685"/><path class="st1" d="M15.735,2.335c0,2.648-2.146,4.794-4.793,4.794S6.149,4.982,6.149,2.335"/><circle class="st2" cx="10.943" cy="2.853" r="1.863"/></g><g id="log-x" data-size="12x12" class="logs-svg-svg ">	<path class="st2" d="M11.436,9.54c0.127,0.136,0.221,0.284,0.281,0.444c0.061,0.159,0.09,0.325,0.09,0.498		c0,0.172-0.029,0.34-0.09,0.504s-0.154,0.313-0.281,0.45c-0.137,0.119-0.289,0.214-0.457,0.281		c-0.168,0.068-0.336,0.103-0.504,0.103c-0.343,0-0.656-0.128-0.935-0.384L5.903,7.812l-3.636,3.624		c-0.112,0.119-0.252,0.214-0.42,0.281C1.68,11.786,1.504,11.82,1.319,11.82c-0.16,0-0.323-0.034-0.491-0.103		C0.66,11.65,0.52,11.555,0.407,11.436c-0.136-0.137-0.237-0.286-0.306-0.45S0,10.654,0,10.482c0-0.173,0.033-0.339,0.102-0.498		c0.068-0.16,0.17-0.309,0.306-0.444l3.589-3.636L0.407,2.268C0.271,2.148,0.17,2.006,0.102,1.842S0,1.512,0,1.344		S0.033,1.01,0.102,0.846c0.068-0.164,0.17-0.31,0.306-0.438C0.535,0.272,0.682,0.17,0.846,0.102C1.01,0.034,1.176,0,1.344,0		s0.334,0.034,0.498,0.102c0.164,0.068,0.306,0.17,0.426,0.306l3.636,3.588L9.54,0.408C9.668,0.272,9.813,0.17,9.978,0.102		C10.142,0.034,10.309,0,10.481,0s0.34,0.034,0.504,0.102c0.164,0.068,0.314,0.17,0.451,0.306c0.127,0.128,0.221,0.274,0.281,0.438		c0.061,0.164,0.09,0.33,0.09,0.498s-0.029,0.334-0.09,0.498s-0.154,0.306-0.281,0.426L7.812,5.904L11.436,9.54z"/></g><g id="log-magnify" data-size="16x16" class="logs-svg-svg ">	<path class="st3" d="M10.352,0c0.736,0,1.432,0.142,2.088,0.424c0.656,0.283,1.229,0.669,1.72,1.16		c0.491,0.491,0.88,1.064,1.168,1.72c0.288,0.656,0.432,1.357,0.432,2.104c0,0.757-0.144,1.464-0.432,2.12		c-0.288,0.655-0.678,1.229-1.168,1.72s-1.064,0.875-1.72,1.152c-0.656,0.277-1.352,0.416-2.088,0.416		c-0.534,0-1.038-0.067-1.512-0.2c-0.475-0.134-0.915-0.322-1.32-0.568l-5.616,5.616L0,13.776l5.648-5.633		C5.435,7.728,5.264,7.296,5.136,6.848C5.008,6.4,4.944,5.92,4.944,5.408c0-0.747,0.142-1.448,0.424-2.104		c0.282-0.656,0.669-1.229,1.16-1.72c0.491-0.49,1.064-0.877,1.72-1.16C8.904,0.142,9.605,0,10.352,0z M10.352,8.192		c0.384,0,0.744-0.075,1.08-0.225c0.336-0.149,0.629-0.349,0.88-0.6c0.25-0.25,0.448-0.544,0.592-0.88		c0.144-0.336,0.216-0.696,0.216-1.08s-0.072-0.741-0.216-1.072c-0.144-0.331-0.341-0.622-0.592-0.872		c-0.251-0.25-0.544-0.445-0.88-0.584s-0.696-0.208-1.08-0.208S9.608,2.742,9.272,2.88S8.64,3.214,8.384,3.464		c-0.256,0.25-0.456,0.542-0.6,0.872S7.568,5.024,7.568,5.408s0.072,0.744,0.216,1.08s0.344,0.629,0.6,0.88		c0.256,0.251,0.552,0.451,0.888,0.6C9.608,8.117,9.968,8.192,10.352,8.192z"/></g>';var pxSvgIconString=pxSvgIconString||"";pxSvgIconString+="";