
~function($, window, layer) {

    if (!Function.prototype.bind) {
        Function.prototype.bind = function() {
            var arguments = Array.prototype.slice.call(arguments),
                ctx = arguments[0] || window,
                args = arguments;
            _this = this.bounded || this;
            args.shift();
            if (this.args) {
                this.args = this.args.concat(Array.prototype.slice.call(args));
            }
            return function() {
                this.bounded = _this;
                this.args = this.args || args;
                _this.apply(ctx, this.args.concat(Array.prototype.slice.call(arguments)));
            }
        };
    }

    var MAX_DURATION = 60000,
        MAX_DRAW_TIMES = 5,
        TIME_VALIDATION_API = location.protocol + '//'
                + location.host	 + '/yingpu/pc/prize/time/check/json',
        isArray = function(obj) {
            return Object.prototype.toString.call(obj) == '[object Array]';
        };

    var Timer = function(c, i) {
        this.callback = c;
        this.interval = i;
        this.id = 0;
    };

    Timer.prototype = {
        constructor : Timer,
        start : function() {
            this.id = window.setInterval(this.callback, this.interval);
        },
        stop : function() {
            window.clearInterval(this.id);
        }
    };

    window.Timer = Timer;

    window.Countdown = (function() {
        var fields = {
            startTime : null,
            endTime : null,
            duration : 0,
            remainDuration : 0,
            timeInCount : 0,
            action : function() { },
            timeCountCallback : null,
            finishCallback : null,
            isActionDoing : false,
            timer : null,
            timeCountInterval : 1000,
            records : []
        },
        record = {
            phone : '',
            timestamp : ''
        },
        Countdown = function(start, end, action) {
            return new Countdown.prototype.init(start, end, action, fields);
        };

        Countdown.prototype = {
            MAX_DRAW_TIMES : MAX_DRAW_TIMES,
            constructor : Countdown,
            init : function(start, end, action, fields) {
                if (fields) {
                    for (var k in fields) {
                        this[k] = fields[k];
                    }
                }

                this.startTime = start;
                this.endTime = end;
                this.duration = Math.max((end.getTime() - start.getTime()), 0);
                var now = new Date();
                if (now.getTime() - start.getTime() > 1000) {
                    start = now;
                }

                this.readRecord(true);
                this.remainDuration = Math.max((end.getTime() - start.getTime()), 0);
                this.action = action;
                this.timer = new Timer((function ( obj ) {
                    return function() {
                        obj.timerTick();
                    };
                }) (this), this.timeCountInterval);
            },

            readRecord : function(clear) {
                var now = new Date().getTime();
                if (clear && now - localStorage.LAST_DRAW_TIME > this.duration) {
                    delete localStorage.records;
                    delete localStorage.LAST_DRAW_TIME;
                }

                if (!localStorage.LAST_DRAW_TIME) {
                    localStorage.LAST_DRAW_TIME = this.startTime.getTime();
                }
                this.records = JSON.parse(localStorage.records || '[]');
            },

            writeRecord : function(record) {
                this.records.push(record);
                localStorage.records = JSON.stringify(this.records);
            },

            getTimes : function(phone) {
                var times = 0;
                for (var i in this.records) {
                    var r = this.records[i];
                    if (r.phone == phone) {
                        times++;
                    }
                }

                return times;
            },

            startTimeCount : function() {
                this.timer.start();
                return this;
            },

            stopTimeCount : function() {
                this.timer.stop();
                return this;
            },

            timerTick : function() {
                var minus = 0, now = new Date().getTime(), _this = this;

                if (!this.isActionDoing) {
                    if ((minus = now - this.startTime.getTime()) >= 0 && minus < this.duration) {
                        $.get(TIME_VALIDATION_API, { time : now }, function(data) {
                            var usedTime = new Date().getTime() - now;
                            if (data.status == 'error' || usedTime >= this.remainDuration
                            /*|| new Date(data.data).getTime() > _this.endTime.getTime()*/) {
                                console.error('Timeout!');
                                _this.stopTimeCount();
                            }
                            else if (data.status == 'success') {
                                _this.doAction();
                            }
                        }, 'json');
                    }
                }
                else {
                    this.timeCount();
                }

                this.onTimeCount();
            },

            timeCount : function() {
                this.timeInCount++;
                if (this.timeInCount >= (this.remainDuration / 1000)) {
                    this.isActionDoing = false;
                    this.stopTimeCount();
                    this.onFinish();
                }
            },

            doAction : function() {
                if (typeof this.action == 'function') {
                    this.isActionDoing = true;
                    this.action.call(this);
                }
            },

            setTimeCountCallback : function(c) {
                if (c) {
                    this.timeCountCallback = c;
                }

                return this;
            },

            setFinishCallback : function(c) {
                if (c) {
                    this.finishCallback = c;
                }

                return this;
            },

            onFinish : function() {
                if (this.finishCallback) {
                    this.finishCallback.call(this);
                }
            },

            onTimeCount : function() {
                if (this.timeCountCallback) {
                    this.timeCountCallback.call(this);
                }
            }
        };

        Countdown.prototype.init.prototype = Countdown.prototype;
        return Countdown;
    })();


}(jQuery, window, layer);







