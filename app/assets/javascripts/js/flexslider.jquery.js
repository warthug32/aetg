/* Simple JavaScript Inheritance
 * By John Resig http://ejohn.org/
 * MIT Licensed.
 */
// Inspired by base2 and Prototype
if (typeof Class === "undefined") {
    (function(){
        var initializing = false, fnTest = /xyz/.test(function(){
            xyz;
        }) ? /\b_super\b/ : /.*/;

        // The base Class implementation (does nothing)
        this.Class = function(){};

        // Create a new Class that inherits from this class
        Class.extend = function(prop) {
            var _super = this.prototype;

            // Instantiate a base class (but only create the instance,
            // don't run the init constructor)
            initializing = true;
            var prototype = new this();
            initializing = false;

            // Copy the properties over onto the new prototype
            for (var name in prop) {
                // Check if we're overwriting an existing function
                prototype[name] = typeof prop[name] == "function" &&
                typeof _super[name] == "function" && fnTest.test(prop[name]) ?
                (function(name, fn){
                    return function() {
                        var tmp = this._super;

                        // Add a new ._super() method that is the same method
                        // but on the super-class
                        this._super = _super[name];

                        // The method only need to be bound temporarily, so we
                        // remove it when we're done executing
                        var ret = fn.apply(this, arguments);
                        this._super = tmp;

                        return ret;
                    };
                })(name, prop[name]) :
                prop[name];
            }

            // The dummy class constructor
            function Class() {
                // All construction is actually done in the init method
                if ( !initializing && this.init )
                    this.init.apply(this, arguments);
            }

            // Populate our constructed prototype object
            Class.prototype = prototype;

            // Enforce the constructor to be what we expect
            Class.prototype.constructor = Class;

            // And make this class extendable
            Class.extend = arguments.callee;

            return Class;
        };
    })();
}
/*
---
name: FlexSlider
script: flexslider.js
version : 3.8
license: Commercial and DonateWare for personnal usage - Please donate, I need coffee u_u or buy at code-canyon
description: Create a multi layers easily configurable slideShow to make great presentation
copyright: Copyright (c) 2010, Joffrey Gohin <gohin.j@gmail.com>, FreeLance Web Developper - http://www.agence-flex.com/slider/jquery/
authors: [Joffrey Gohin, http://codecanyon.net/user/Huitre/profile?ref=Huitre]

provides: [Effect, FlexSlider, AnimatedDiv, LoaderLayer]
...
*/
(function(){
    var thisBody = document.body || document.documentElement,
    thisStyle = thisBody.style;
    // Insired by the work of Ben Barnett http://www.benbarnett.net
    var CSSUtils = Class.extend({
        _css3Events : (thisStyle.WebkitTransition !== undefined) ? "webkitTransitionEnd" : (thisStyle.OTransition !== undefined) ? "oTransitionEnd" : "transitionend",
        _hasCSS3 : thisStyle.WebkitTransition !== undefined || thisStyle.MozTransition !== undefined || thisStyle.OTransition !== undefined || thisStyle.transition !== undefined,
        _has3d : ('WebKitCSSMatrix' in window && 'm11' in new WebKitCSSMatrix()),
        _easings : {
            bounce: 'cubic-bezier(0.0, 0.35, .5, 1.3)',
            linear: 'linear',
            swing: 'ease-in-out',

            // Penner equation approximations from Matthew Lein's Ceaser: http://matthewlein.com/ceaser/
            easeInQuad:     'cubic-bezier(0.550, 0.085, 0.680, 0.530)',
            easeInCubic:    'cubic-bezier(0.550, 0.055, 0.675, 0.190)',
            easeInQuart:    'cubic-bezier(0.895, 0.030, 0.685, 0.220)',
            easeInQuint:    'cubic-bezier(0.755, 0.050, 0.855, 0.060)',
            easeInSine:     'cubic-bezier(0.470, 0.000, 0.745, 0.715)',
            easeInExpo:     'cubic-bezier(0.950, 0.050, 0.795, 0.035)',
            easeInCirc:     'cubic-bezier(0.600, 0.040, 0.980, 0.335)',
            easeOutQuad:    'cubic-bezier(0.250, 0.460, 0.450, 0.940)',
            easeOutCubic:   'cubic-bezier(0.215, 0.610, 0.355, 1.000)',
            easeOutQuart:   'cubic-bezier(0.165, 0.840, 0.440, 1.000)',
            easeOutQuint:   'cubic-bezier(0.230, 1.000, 0.320, 1.000)',
            easeOutSine:    'cubic-bezier(0.390, 0.575, 0.565, 1.000)',
            easeOutExpo:    'cubic-bezier(0.190, 1.000, 0.220, 1.000)',
            easeOutCirc:    'cubic-bezier(0.075, 0.820, 0.165, 1.000)',
            easeInOutQuad:  'cubic-bezier(0.455, 0.030, 0.515, 0.955)',
            easeInOutCubic: 'cubic-bezier(0.645, 0.045, 0.355, 1.000)',
            easeInOutQuart: 'cubic-bezier(0.770, 0.000, 0.175, 1.000)',
            easeInOutQuint: 'cubic-bezier(0.860, 0.000, 0.070, 1.000)',
            easeInOutSine:  'cubic-bezier(0.445, 0.050, 0.550, 0.950)',
            easeInOutExpo:  'cubic-bezier(1.000, 0.000, 0.000, 1.000)',
            easeInOutCirc:  'cubic-bezier(0.785, 0.135, 0.150, 0.860)'
        },
        init : function () {
            this.prefix = this.getPrefix();
        },
        redirect : function () {
        /*
            if (window.location.host != 'www.agence-flex.com')
                    window.location = 'http://www.agence-flex.com/slider/jquery/';
            */
        },
        getPrefix : function () {
            if (this.prefix)
                return this.prefix;
            return $.browser.webkit ? '-webkit-' :
            $.browser.mozilla ? '-moz-' :
            $.browser.msie ? '-ms-' : '-o-';
        },
        getCSS3Events : function () {
            return this._css3Events;
        },
        has3d : function () {
            return this._has3d;
        },
        hasCSS3 : function () {
            return this._hasCSS3;
        },
        CSSeasing : function (easing) {
            return this._easings[easing];
        }
    });
    var Element = Class.extend({
        x : null,
        a : null,
        init : function (t, o) {
            this.a = document.createElement(t);
            this.x = $(this.a);
            if (o['class'])
                this.x.addClass(o['class']);
            if (o['rel'] !== 'undefined')
                this.x.attr('rel', o['rel']);
            if (o['id'])
                this.x.attr('id', o['id']);
            if (o['href'])
                this.x.attr('href', o['href']);
            if (o['html'])
                this.x.html(o['html']);
            if (o['events'])
                this.addEvents(o['events']);
        },
        addEvents : function (e) {
            for (type in e) {
                this.x.bind(type, e[type]);
            }
        },
        tojQuery : function () {
            return this.x;
        }
    }),
    EffectFactory = Class.extend({
        init : function () {},
        create : function (type, o) {
            try {
                switch (type.toString().toLowerCase()) {
                    case 'fade' :
                        return new Fade(o);
                        break;
                    case 'fadeout' :
                        return new FadeOut(o);
                        break;
                    case 'slide' :
                        return new Slide(o);
                        break;
                    case 'slideout' :
                        return new SlideOut(o);
                        break;
                    case 'height' :
                        return new Height(o);
                        break;
                    case 'width' :
                        return new Width(o);
                        break;
                    case 'move' :
                        return new Move(o);
                        break;
                    case 'zoom' :
                        return new Zoom(o);
                        break;
                    case 'rotate' :
                        return new Rotate(o);
                        break;
                    case 'square' :
                        return new Square(o);
                        break;
                }
            } catch (e) {
                return new None(o);
            }
            return new None(o);
        }
    })

    effectFactory = new EffectFactory();
    utils = new CSSUtils();
    var Effect = Class.extend({
        div : null,
        dir : 1,
        delay : 5000,
        fn : null,
        where : null,
        init: function () {},
        animate : function () {},
        run : function () {},
        initFrame : function () {},
        clearTimers : function () {
            //console.log('clearTimers');
            this.pause = true;
            $(this.div).unbind(utils.getCSS3Events());
            window.clearTimeout(this.fdelay);
            this.div.css(utils.getPrefix() + 'transition-duration', '');
            this.div.css(utils.getPrefix() + 'transform', '');
            this.div.css(utils.getPrefix() + 'transition-property');
            this.div.css(utils.getPrefix() + 'transition-duration', '');
            this.div.css(utils.getPrefix() + 'transition-timing-function', '');
            this.div.css(utils.getPrefix() + 'transition-delay', '');
        },
        addCSSEvents : function () {
            var self = this;
            $(this.div).bind(utils.getCSS3Events(), function () {
                if (!self.pause || 1) {
                    $(self.div).trigger('Effect.complete');
                    $(self.div).unbind(utils.getCSS3Events());
                }
            });
        },
        cleanCSS : function (prefix) {}
    }),
    None = Effect.extend({
        init: function (obj) {
            this.div = obj.div;
        },
        animate : function () {
            this.div.trigger('Effect.complete');
        },
        initFrame : function () {}
    }),
    Rotate = Effect.extend({
        init: function (obj) {
            this.div = obj.div;
            this.left = this.div.css('left');
            this.top = this.div.css('top');
            this.delay = this.div.attr('data-delay') ? this.div.attr('data-delay') : '0';
            this.angle = this.div.attr('data-angle') ? this.div.attr('data-angle') : '0';
            this.origin = this.div.attr('data-origin') ? this.div.attr('data-origin') : 'center center';
            if (utils.hasCSS3()) {
                this.run = this.run3d;
            }
        },
        animate : function () {
            this.initFrame();
            var self = this, p = function () {
                self.run(self)
            }
            this.fdelay = setTimeout(p, this.delay);
        },
        run3d : function (o) {
            this.addCSSEvents();
            var x, y;
            x = this.origin.split(new RegExp("[ ]+", "g"));
            y = x[1];
            x = x[0];
            if (utils.has3d())
                this.div.css(utils.getPrefix() + 'transform', 'rotate3d(0, 0, 0, '+this.angle+'deg)');
            else
                this.div.css(utils.getPrefix() + 'transform', 'rotate('+this.angle+'deg)');
            this.div.css(utils.getPrefix() + 'transition-duration',
                parseInt(this.div.attr('data-time')) ? parseInt(this.div.attr('data-time')) + 'ms' : 1000 + 'ms'
                );
            this.div.css(utils.getPrefix() + 'transition-timing-function',
                this.div.attr('data-easing') ? utils.CSSeasing(this.div.attr('data-easing')) : 'linear'
                );
            this.div.css(utils.getPrefix() + 'transform-origin', x + ' ' + y);
        }
    }),
    Move = Effect.extend({
        init: function (obj) {
            this.div = obj.div;
            this.left = this.div.css('left');
            this.top = this.div.css('top');
            this.delay = this.div.attr('data-delay') ? this.div.attr('data-delay') : '0';
            this.offset = this.div.attr('data-offset') ? this.div.attr('data-offset') : "0 0";
            if (utils.hasCSS3()) {
                this.run = this.run3d;
            }
        },
        animate : function () {
            this.initFrame();
            var self = this, p = function () {
                self.run(self)
            }
            this.fdelay = setTimeout(p, this.delay);
        },
        run : function (o) {
            var self = this, x, y;
            x = this.offset.split(new RegExp("[ ]+", "g"));
            y = x[1];
            x = x[0];
            this.div.animate({
                'left' : '+=' + x,
                'top' : '+=' + y
            }, parseInt(self.div.attr('data-time')) ? parseInt(self.div.attr('data-time')) : 1000 ,
                self.div.attr('data-easing') ? self.div.attr('data-easing') : 'linear',
                function () {
                    if (!self.pause)
                        o.div.trigger('Effect.complete');
                }); 
        },
        run3d : function (o) {
            this.addCSSEvents();
            var self = this, x, y, t, l;
            x = this.offset.split(new RegExp("[ ]+", "g"));
            y = x[1];
            x = x[0];
            t = parseInt(this.top);
            t = t ? (l + y) + 'px' : y + 'px';
            l = parseInt(this.left);
            l = l ? (l + x) + 'px' : x + 'px';
            if (utils.has3d()) {
                this.div.css(utils.getPrefix() + 'transform', 'translate3d('+ x +'px, '+ y +'px, 0)');
            } else {
                /*this.div.css(utils.getPrefix() + 'transition-property', 'left, top');
                this.div.css({
                    'left' : l,
                    'top' : t
                });*/
                this.div.css(utils.getPrefix() + 'transform', 'translate('+ x +'px, '+ y +'px)');
                //console.log('transform', 'translate('+ x +', '+ y +')');
            }
            this.div.css(utils.getPrefix() + 'transition-duration', 
                parseInt(self.div.attr('data-time')) ? parseInt(self.div.attr('data-time')) + 'ms' : 1000 + 'ms'
                );
            this.div.css(utils.getPrefix() + 'transition-timing-function',
                this.div.attr('data-easing') ? utils.CSSeasing(this.div.attr('data-easing')) : 'linear'
                );
        },
        initFrame : function () {
            this.clearTimers();
            this.pause = false;
            this.div.css({
                'left': this.left,
                'top' : this.top
            });
        }
    }),
    Zoom = Effect.extend({
        init: function (obj) {
            this.div = obj.div;
            this.height = this.div.height();
            this.width = this.div.width();
            this.delay = this.div.attr('data-delay') ? this.div.attr('data-delay') : '0';
            this.pc = this.div.attr('data-percentage') ? parseInt(this.div.attr('data-percentage')) : 150;
            if (utils.hasCSS3()) {
                this.run = this.run3d;
            }
        },
        animate : function () {
            this.initFrame();
            var self = this, p = function () {
                self.run(self)
            }
            this.fdelay = setTimeout(p, this.delay);
        },
        run : function (o) {
            var self = this;
            this.div.animate({
                'height' : (self.height * this.pc / 100),
                'width' : (self.width * this.pc / 100)
            }, parseInt(self.div.attr('data-time')) ? parseInt(self.div.attr('data-time')) : 3000 ,
                self.div.attr('data-easing') ? self.div.attr('data-easing') : 'linear',
                function () {
                    if (!self.pause)
                        o.div.trigger('Effect.complete');
                }
                );
        },
        run3d : function (o) {
            this.addCSSEvents();
            var self = this, pc = this.pc/100;
            if (utils.has3d()) {
                this.div.css(utils.getPrefix() + 'transform', 'Scale3d(' + pc + ', ' + pc + ', 1)');
            } else {
                this.div.css(utils.getPrefix() + 'transition-property', 'height, width');
                this.div.css({
                    'left' : (this.height * this.pc / 100),
                    'top' : (this.width * this.pc / 100)
                    });
            }
            this.div.css(utils.getPrefix() + 'transition-duration',
                parseInt(this.div.attr('data-time')) ? parseInt(this.div.attr('data-time')) + 'ms' : 1000 + 'ms'
                );
            this.div.css(utils.getPrefix() + 'transition-timing-function',
                this.div.attr('data-easing') ? utils.CSSeasing(this.div.attr('data-easing')) : 'linear'
                );
        },
        initFrame : function () {
            this.clearTimers();
            this.pause = false;
            this.div.css('height', this.height);
            this.div.css('width', this.width);
        }
    }),
    Square = Effect.extend({
        init: function (obj) {
            this.div = obj.div;
        },
        animate : function () {
            this.div.trigger('Effect.complete');
        },
        initFrame : function () {}
    })
    Height = Effect.extend({
        init: function (obj) {
            this.div = obj.div;
            this.div.data('old-height', obj.div.css('height'));
            this.delay = this.div.attr('data-delay') ? this.div.attr('data-delay') : '0';
            if (utils.hasCSS3()) {
                this.run = this.run3d;
            }
        },
        animate : function () {
            this.initFrame();
            var self = this, p = function () {
                self.run(self)
            }
            this.fdelay = setTimeout(p, this.delay);
        },
        run3d : function (o) {
            this.addCSSEvents();
            this.div.css(utils.getPrefix() + 'transition-property', 'all');
            this.div.css('opacity', 1);
            this.div.css('height', this.div.data('old-height'));
            this.div.css(utils.getPrefix() + 'transition-duration',
                parseInt(this.div.attr('data-time')) ? parseInt(this.div.attr('data-time')) + 'ms' : 1000 + 'ms'
            );
            this.div.css(utils.getPrefix() + 'transition-timing-function',
                this.div.attr('data-easing') ? utils.CSSeasing(this.div.attr('data-easing')) : utils.CSSeasing['easeOutExpo']
                );
        },
        run : function (o) {
            var self = this;
            this.div.css('opacity', 1);
            this.div.animate({
                'height' : this.div.data('old-height'),
                useTranslate3d: true,
                leaveTransforms : false
            }, parseInt(self.div.attr('data-time')) ? parseInt(self.div.attr('data-time')) : 1000 ,
                self.div.attr('data-easing') ? self.div.attr('data-easing') : 'linear',
                function () {
                    if (!self.pause)
                        o.div.trigger('Effect.complete');
                }
                );
        },
        initFrame : function () {
            this.clearTimers();
            this.pause = false;
            this.div.css({
                'opacity': 0,
                'height' : 0,
                'overflow' : 'hidden',
                'word-wrap': 'normal'
            });
            this.div.stop();
        }
    }),
    Width = Effect.extend({
        init: function (obj) {
            this.div = obj.div;
            this.div.data('old-width', obj.div.css('width'));
            this.delay = this.div.attr('data-delay') ? this.div.attr('data-delay') : '0';
            if (utils.hasCSS3()) {
                this.run = this.run3d;
            }
        },
        animate : function () {
            this.initFrame();
            var self = this, p = function () {
                self.run(self)
            }
            this.fdelay = setTimeout(p, this.delay);
        },
        run3d : function (o) {
            this.addCSSEvents();
            this.div.css('opacity', 1);
            this.div.css(utils.getPrefix() + 'transition-property', 'all');
            this.div.css('width', this.div.data('old-width'));
            this.div.css(utils.getPrefix() + 'transition-duration',
                parseInt(this.div.attr('data-time')) ? parseInt(this.div.attr('data-time')) + 'ms' : 1000 + 'ms'
            );
            this.div.css(utils.getPrefix() + 'transition-timing-function',
                this.div.attr('data-easing') ? utils.CSSeasing(this.div.attr('data-easing')) : utils.CSSeasing['easeOutExpo']
                );
        },
        run : function (o) {
            var self = this;
            this.div.css('opacity', 1);
            this.div.animate({
                'width' : this.div.data('old-width'),
                useTranslate3d: true,
                leaveTransforms : false
            }, parseInt(self.div.attr('data-time')) ? parseInt(self.div.attr('data-time')) : 1000 ,
                self.div.attr('data-easing') ? self.div.attr('data-easing') : 'linear',
                function () {
                    o.div.trigger('Effect.complete');
                }
                );
        },
        initFrame : function () {
            this.clearTimers();
            this.pause = false;
            this.div.css({
                'opacity': 0,
                'width' : 0
            });
            this.div.stop();
        }
    }),
    Slide = Effect.extend({
        init: function (obj) {
            this.width = obj.w;
            this.height = obj.h;
            this.div = obj.div;
            this.dir = 1;
            this.pause = false;
            this.where = this.div.attr('data-direction') ? this.div.attr('data-direction') : 'left';
            this.delay = this.div.attr('data-delay') ? this.div.attr('data-delay') : '0';
            this.div.data('old-left', this.div.css('left'));
            this.div.data('old-top', this.div.css('top'));
            this.div.data('old-bottom', this.div.css('bottom'));
            this.div.data('old-right', this.div.css('right'))
            if (utils.hasCSS3()) {
                this.run = this.run3d;
            }
        },
        animate : function () {
            this.initFrame();
            var self = this, p = function () {
                self.run(self)
            }
            this.fdelay = setTimeout(p, this.delay);
        },
        run : function (o) {
            var self = this;
            this.div.animate(
                this.getDisplacement(),
                parseInt(self.div.attr('data-time')) ? parseInt(self.div.attr('data-time')) : 1000 ,
                self.div.attr('data-easing') ? self.div.attr('data-easing') : 'easeOutExpo',
                function () {
                    if (!self.pause)
                        self.div.trigger('Effect.complete');
                }
                );
        },
        run3d : function (o) {
            this.addCSSEvents();
            var l = this.div.data('old-left'), t = this.div.data('old-top');
            l = l === 'auto' ? 0 : parseInt(l.replace('px', ''));
            t = t === 'auto' ? 0 : parseInt(t.replace('px', ''));
            if (utils.has3d()) {    
               this.div.css(utils.getPrefix() + 'transform', 
               'translate3d(' + (l - parseInt(this.div.css('left').replace('px', '').replace('auto', '0'))) + 'px,'
                   + (t - parseInt(this.div.css('top').replace('px', '').replace('auto', '0'))) + 'px,0)');
            } else {
                this.div.css(utils.getPrefix() + 'transition-property', 'left,top');
                if (l != 'undefined')
                    this.div.css('left', l);
                if (t != 'undefined')
                    this.div.css('top', t);
            }
            this.div.css(utils.getPrefix() + 'transition-duration',
                parseInt(this.div.attr('data-time')) ? parseInt(this.div.attr('data-time')) + 'ms' : 1000 + 'ms'
                );
            this.div.css(utils.getPrefix() + 'transition-timing-function',
                this.div.attr('data-easing') ? utils.CSSeasing(this.div.attr('data-easing')) : utils.CSSeasing['easeOutExpo']
                );
        },
        getDisplacement : function () {
            switch (this.where) {
                case 'right':
                case 'left':
                    return {
                        'left' : this.div.data('old-left')
                    };
                    break;
                case 'up':
                case 'down':
                    return {
                        'top' : this.div.data('old-top')
                    };
                    break;
            }
        },
        initFrame : function () {
            this.clearTimers();
            this.pause = false;
            var oldPos, l, r, t, b;
            r = parseInt(this.div.data('old-right'));
            r = !isNaN(r) ? r : 0;
            l = parseInt(this.div.data('old-left'));
            l = !isNaN(l)? l : 0;
            t = parseInt(this.div.data('old-top'));
            t = !isNaN(t) ? t : 0;
            b = parseInt(this.div.data('old-bottom'));
            b = !isNaN(b) ? b : 0;            
            switch (this.where) {
                case 'left':
                    oldPos = parseInt(this.div.data('old-left'));
                    oldPos = oldPos ? oldPos : (this.width - r - this.div.width()) + 'px';
                    this.div.data('old-left', '' + oldPos);
                    this.div.css('left', this.width + 'px');
                    break;
                case 'right':
                    oldPos = r;
                    oldPos = oldPos ? (this.width - r - this.div.width()) + 'px' : l;
                    this.div.data('old-left', '' + oldPos);
                    this.div.css('left', -this.div.width());
                    break;
                case 'up':
                    oldPos = parseInt(this.div.data('old-top'));
                    oldPos = oldPos ? oldPos : (this.height - b - this.div.outerHeight()) + 'px';
                    this.div.data('old-top', '' + oldPos);
                    this.div.css('top', this.height + 'px');
                    break;
                case 'down':
                    oldPos = parseInt(this.div.data('old-top'));
                    oldPos = oldPos ? oldPos : (this.height - b - this.div.outerHeight()) + 'px';
                    this.div.data('old-top', '' + oldPos);
                    this.div.css('top', -this.div.outerHeight());
                    break;
            }
            this.div.stop();
        }        
    }),
    SlideOut = Effect.extend({
        init: function (obj) {
            this.width = obj.w;
            this.height = obj.h;
            this.div = obj.div;
            this.dir = 1;
            this.pause = false;
            this.where = this.div.attr('data-direction') ? this.div.attr('data-direction') : 'left';
            this.delay = this.div.attr('data-delay') ? this.div.attr('data-delay') : '0';
            this.div.data('old-left', this.div.css('left'));
            this.div.data('old-top', this.div.css('top'));
            this.div.data('old-bottom', this.div.css('bottom'));
            this.div.data('old-right', this.div.css('right'))
            if (utils.hasCSS3()) {
                this.run = this.run3d;
            }
        },
        animate : function () {
            this.initFrame();
            var self = this, p = function () {
                self.run(self)
            }
            this.fdelay = setTimeout(p, this.delay);
        },
        run : function (o) {
            var self = this;
            this.div.animate(
                this.getDisplacement()
                , parseInt(self.div.attr('data-time')) ? parseInt(self.div.attr('data-time')) : 1000 ,
                self.div.attr('data-easing') ? self.div.attr('data-easing') : 'easeOutExpo',
                function () {
                    if (!self.pause)
                        self.div.trigger('Effect.complete');
                }
                );
        },
        run3d : function (o) {
            this.addCSSEvents();
            var t;
            if (utils.has3d()) {
              t = {
                  'left' : 'translate3d(' + (-this.width) + 'px,0px,0)',
                  'right' : 'translate3d(' + (this.width) + 'px,0px,0)',
                  'top' : 'translate3d(0px,' + (-this.height) + 'px,0)',
                  'bottom' : 'translate3d(0px,' + (this.height) + 'px,0)'
              };
               this.div.css(utils.getPrefix() + 'transform', t[this.where]);
            } else {
                t = {
                  'left' : 'translate(' + (-this.width) + 'px,0px)',
                  'right' : 'translate(' + (this.width) + 'px,0px)',
                  'top' : 'translate(0px,' + (-this.height) + 'px)',
                  'bottom' : 'translate(0px,' + (this.height) + 'px)'
              };
                this.div.css(utils.getPrefix() + 'transform', t[this.where]);
            }
            this.div.css(utils.getPrefix() + 'transition-duration',
                parseInt(this.div.attr('data-time')) ? parseInt(this.div.attr('data-time')) + 'ms' : 1000 + 'ms'
                );
            this.div.css(utils.getPrefix() + 'transition-timing-function',
                this.div.attr('data-easing') ? utils.CSSeasing(this.div.attr('data-easing')) : 'linear'
                );
        },
        getDisplacement : function () {
            switch (this.where) {
                case 'left':
                    return {
                        'left' : '-=' + (this.width)
                    };
                    break;
                case 'right':
                    return {
                        'right' : '-=' + (this.width)
                    };
                    break;
                case 'up':
                    return {
                        'top' : '-=' + (this.height)
                    };
                    break;
                case 'down':
                    return {
                        'bottom' : '-=' + (this.height)
                    };
                    break;
            }
        },
        initFrame : function () {
            this.clearTimers();
            this.pause = false;
            switch (this.where) {
                case 'left':
                    this.div.css('left', this.div.data('old-left'));
                    break;
                case 'right':
                    this.div.css('right', this.div.data('old-right') );
                    break;
                case 'up':
                    this.div.css('top',  this.div.data('old-top'));
                    break;
                case 'down':
                    this.div.css('bottom',  this.div.data('old-bottom'));
                    break;
            }
            this.div.stop();
        }
    }),
    Fade = Effect.extend({
        init: function (obj) {
            this.div = obj.div;
            this.div.data('old-opacity', obj.div.css('opacity'));
            this.delay = this.div.attr('data-delay') ? this.div.attr('data-delay') : '0';
            if (utils.hasCSS3()) {
                this.run = this.run3d;
            }
        },
        run3d : function (o) {
            this.addCSSEvents();
            this.div.css(utils.getPrefix() + 'transition-property', 'all');
            this.div.css('opacity', this.div.data('old-opacity'));
            this.div.css(utils.getPrefix() + 'transition-duration',
                parseInt(this.div.attr('data-time')) ? parseInt(this.div.attr('data-time')) + 'ms' : 1000 + 'ms'
            );
            this.div.css(utils.getPrefix() + 'transition-timing-function',
                this.div.attr('data-easing') ? utils.CSSeasing(this.div.attr('data-easing')) : 'linear'
                );
        },
        animate : function () {
            this.initFrame();
            var self = this, p = function () {
                self.run(self)
            }
            this.fdelay = setTimeout(p, this.delay);
        },
        run : function (o) {
            var self = this;
            this.div.animate({
                'opacity' : this.div.data('old-opacity')
            }, parseInt(self.div.attr('data-time')) ? parseInt(self.div.attr('data-time')) : 1000 ,
                self.div.attr('data-easing') ? self.div.attr('data-easing') : 'linear',
                function () {
                    if (!self.pause)
                        o.div.trigger('Effect.complete');
                }
                );
        },
        initFrame : function () {
            this.clearTimers();
            this.pause = false;
            this.div.css('opacity', 0);
            this.div.stop();
        }
    }),
    FadeOut = Effect.extend({
        init: function (obj) {
            this.div = obj.div;
            this.div.data('old-opacity', obj.div.css('opacity') ? obj.div.css('opacity') : 1);
            this.delay = this.div.attr('data-delay') ? this.div.attr('data-delay') : '0';
            if (utils.hasCSS3()) {
                this.run = this.run3d;
            }
        },
        animate : function () {
            this.initFrame();
            var self = this, p = function () {
                self.run(self)
            }
            this.fdelay = setTimeout(p, this.delay);
        },
        run3d : function (o) {
            this.addCSSEvents();
            this.div.css(utils.getPrefix() + 'transition-property', 'all');
            this.div.css('opacity', 0);
            this.div.css(utils.getPrefix() + 'transition-duration',
                parseInt(this.div.attr('data-time')) ? parseInt(this.div.attr('data-time')) + 'ms' : 1000 + 'ms'
            );
            this.div.css(utils.getPrefix() + 'transition-timing-function',
                this.div.attr('data-easing') ? utils.CSSeasing(this.div.attr('data-easing')) : 'linear'
                );
        },
        run : function (o) {
            var self = this;
            this.div.animate({
                'opacity' : 0
            }, parseInt(self.div.attr('data-time')) ? parseInt(self.div.attr('data-time')) : 1000,
                self.div.attr('data-easing') ? self.div.attr('data-easing') : 'linear',
                function () {
                    if (!self.pause)
                        o.div.trigger('Effect.complete');
                }
                );
        },
        initFrame : function () {
            this.clearTimers();
            this.pause = false;
            this.div.css('opacity', this.div.data('old-opacity'));
            this.div.stop();
        }
    });
    var AnimatedDiv = Class.extend({
        els : null,
        width : null,
        current : 0,
        dir : -1,
        name : null,

        init: function (obj) {
            this.name = 'toto' + Math.random() % 100;
            this.els = null;
            this.current = 0;
            this.els = $(obj.el);
            this.child = this.els.children().length;
            this.height = obj.height;
            this.width = obj.width;
            this.fxs = [];
        },
        buildOne : function (el) {
            utils.redirect();
            var self = this, tmp;
            el = $(el);
            tmp = effectFactory.create(el.attr('data-effect'), {
                w : self.width,
                h: self.height,
                div : el
            });
            self.fxs.push(tmp);
            if (el.children()) {
                this.buildAll(el);
            }
        },
        buildAll : function (el) {
            var self = this;
            $.each(el.children(),
                function (i, el) {
                    self.buildOne(el);
                });
        },
        build : function () {
            var self = this;
            this.buildAll(this.els);
            this.els.bind('Effect.complete', function () {
                self.onEffectFinish();
            })
            this.child = this.fxs.length;
        },
        initFrame : function () {
            this.current = 0;
            $.each(this.fxs,
                function (i, fx){
                    fx.clearTimers();
                    fx.initFrame();
                });
        },
        cleanCSS : function (prefix) {
            $.each(this.fxs,
                function (i, fx){
                    fx.cleanCSS(prefix);
                });
        },
        clearTimers : function () {
            $.each(this.fxs,
                function (i, fx){
                    fx.clearTimers();
                });
        },
        animate : function () {
            //console.log(this.child);
            var dir = this.dir;
            $.each(this.fxs,
                function (i, fx){
                    fx.clearTimers();
                    fx.animate(dir);
                }
                );
        },

        toElement : function () {
            return $(this.els);
        },

        onEffectFinish : function () {
            this.current++;
            if (this.current == this.child) {
                this.els.trigger('Animated.finish');
                this.current = 0;
            }
        }
    });
    this.FlexSlider = Class.extend({
        options: {},
        element : null,
        dom : null,
        delay : 5000,
        timeout : 5000,
        width : 0,
        childs : 0,
        next : 0,

        init: function(options, elem) {
            this.options = $.extend({}, this.options, options);
            if (!this.options.noMouseDrag)
                this.options.noMouseDrag = false;
            if (!this.options.noTouchDrag)
                this.options.noTouchDrag = false;
            this.step = '+=0';
            this.element = $(elem).children('.wrapper');
            this.current = 0;
            this.dom = elem;
            this.fdelay = 0;
            this.rotator = [];
            this.lastClicked = null;
            this.buttons = [];
            this.play = null;
            this.pause = false;
            this.finishedPlaying = true;
            this.childs = 0;
            this.fx = null;
            this.delay = 1000;
            this.fn = [];
            this.prefix = utils.getPrefix();
            this.load = false;
            this.dragEvent = {
                click : false,
                oldX : 0,
                ok : true,
                last : false
            }
            this.showLoader(this.element);
            this.preloadImage(this.element);
        },
        buildOne : function (div) {
            utils.redirect();
            var tmp, self = this, width;
            if (this.options.fullscreen)
                width = $(window.document).width();
            else
                width = $(div).width();
            tmp = new AnimatedDiv({
                el : div,
                width : width,
                height : $(div).height()
            });
            $(tmp.els).width(width);
            width = self.options.width ? self.options.width : $(div).width();
            $(div).bind('Animated.finish', function () {
                self.resetDelay();
                self.finishedPlaying = true;
            })
            self.rotator.push(tmp);
            tmp.build();
            return width;
        },
        move : function (step) {
            this.element.css(this.prefix + 'transition-duration', '');
            this.element.css(this.prefix + 'transform', '');
            this.element.css('left', - (this.current * this.width) + step);
            
        },
        move3d : function () {
            this.element.css(this.prefix + 'transition-duration', '');
            this.element.css(this.prefix + 'transform', 'translate(' + (- (this.current * this.width) + step)+'px, 0, 0)');
            this.element.css(this.prefix + 'transform', 'translate3d(' + (- (this.current * this.width) + step)+'px, 0, 0)');
        },
        build: function() {
            var self = this, width;
            this.load = true;
            width = $(this.dom).width();
            $.each(this.element.children('.rotator'),
                function (i, div){
                    width = self.buildOne(div);
                });
            this.childs = this.rotator.length;
            this.width = width;
            this.step = '+=' + width;
            this.element.css('width', this.childs * width);
            this.element.css('left', 0);
            if (this.options.controls)
                this.controls(this.options.controls);
            if (this.options.noAutoPlay)
                this._pause();
            if (this.options.transitions) {
                $.each(this.rotator, function (i, el) {
                    $(el.els).css('position', 'absolute')
                });
                this.swapIndex(0,0);
                this.slide = this.transitionSlide;
            }
            this.setEvents(this.element);
        },
        showLoader : function (o) {
	/*
            this.removeLoader();
            var d = new Element('div', {
                'id' : 'preloader',
                'class' : 'fullsize preload',
                'html' : '<div class="content_preloader">\n\
                        <div data-effect="fade" class="square" data-delay="0"></div>\n\
                        <div data-effect="fade" data-delay="300" class="square"></div>\n\
                        <div data-effect="fade" data-delay="600" class="square"></div>\n\
                        <div data-effect="fade" data-delay="900" class="square"></div>\n\
                    </div>'
            });
            d = d.tojQuery();
            $(o).append(d);
            this.animateLoader(d);*/
        },
        showVisualTimer : function (o, delay) {
            this.removeVisualTimer();
            var d, step = parseInt(delay) / 4, self = this;
            d = new Element('div', {
                'id' : self.visualId,
                'class' : 'visualTimer preload',
                'html' : '<div class="content_preloader" effect="fade" data-delay="0">\n\
                            <div data-effect="fadeout" class="square" data-delay="0" data-time="' + (step/2 * 4) + '"></div>\n\
                            <div data-effect="fadeout" data-delay="' + (step) + '" data-time="' + (step/2 * 3) + '" class="square"></div>\n\
                            <div data-effect="fadeout" data-delay="' + (step * 2) + '" data-time="' + (step/2 * 2) + '" class="square"></div>\n\
                            <div data-effect="fadeout" data-delay="' + (step * 3) + '" data-time="' + (step/2) + '" class="square"></div>\n\
                    </div>'
            });
            d = d.tojQuery();
            $(o).append(d);
            this.animateLoader(d);
        },
        animateLoader : function (d) {
            var self = this;
            this.preloader = new AnimatedDiv({
                el : d,
                width : d.width()
            });
            this.preloader.build();
            this.preloader.animate();
        },
        removeVisualTimer : function () {
            try {
                $(this.preloader.els).unbind('Animated.finish');
                $(this.preloader.els).remove();
                $('.visualTimer').remove();
            } catch (e) {}
        },
        removeLoader : function () {
            try {
                $(this.preloader.els).unbind('Animated.finish');
                $('#preloader').remove();
                this.preloader = null;
                window.clearInterval(this.preloadTimer);
            } catch (e) {}
        },
        preloadImage : function (o) {
            $(document).load(fn);
            var imgs = $(o).find('img'), count = 0, self = this, fn, done = false;

			
            fn = function () {
                if (!done) {
                    done = true;
                    self.build();
                    self.firstRun();
                    self.removeLoader();
                    if (self.fn['onLoad'])
                        self.fn['onLoad']();
                }
            }
            for (var i = 0, max = imgs.length; i < max; i++) {
                if (imgs[i]['complete']) {
                    count++;
                }
            }
            $(imgs).bind('error load onreadystatechange', function () {
                count++;
                if (count >= imgs.length) {
                    fn();
                }
            });
            if (!imgs || imgs.length <= 1 || count >= imgs.length) {
                fn();
            }
            window.setTimeout(fn, 3000);
        },
        setEvents : function (div) {
            var self = this;
            //div.getElements('img').addEvent('click', function (e) {e.preventDefault();});
            if (this.options.transitions)
                return;
            if ($.browser.msie) {
                div.ondragstart = function () {
                    return false;
                };
            }
            if (!this.options.noMouseDrag) {
                div.bind({
                    mousedown : function (e) {
                        e.preventDefault();
                        self.clearFrame();
                        if (!self.dragEvent.click) {
                            self.dragEvent.oldX = e.clientX;
                            self.dragEvent.click = true;
                            self.dragEvent.last = e.clientX;
                        }
                        div.css('cursor', '');
                        if (self.fn['onMouseDown'])
                            self.fn['onMouseDown']();
                    },
                    mousemove : function (e) {
                        if (self.fn['onMouseMove'])
                            self.fn['onMouseMove']();
                        if (self.options.noMouseDrag)
                            return;
                        // dragging
                        if (self.dragEvent.click && self.dragEvent.ok) {
                            var step = e.clientX - self.dragEvent.oldX;
                            self.move(step);
                        }
                    },
                    mouseup : function (e) {
                        if (self.dragEvent.ok)
                            self.onDragComplete(e);
                        self.dragEvent.oldX = 0;
                        self.dragEvent.last = 0;
                        self.dragEvent.click = false;
                        div.css('cursor', '-moz-grab');
                    },
                    mouseover : function () {
                        self.pauseSlide();
                    },
                    mouseleave : function () {
                        if (self.finishPlaying)
                            self.resetDelay();
                        else
                            self.unPause();
                        self.dragEvent.click = false;
                    }
                });
            }
            if (!this.options.noTouchDrag) {
                div.bind({
                    // touch devices
                    touchstart : function (e) {
                        e = e.originalEvent;
                        e.preventDefault();
                        self.clearFrame();
                        self.dragEvent.oldX = e.touches[0].pageX;
                        self.pauseSlide();
                        if (self.fn['onTouchStart'])
                            self.fn['onTouchStart']();
                    },
                    touchmove : function (e) {
                        if (self.fn['onTouchMove'])
                            self.fn['onTouchMove']();
                        e = e.originalEvent;
                        e.preventDefault();
                        self.pauseSlide();
                        if(e.touches.length == 1) {
                            e = e.touches[0];
                            var step = e.pageX - self.dragEvent.oldX;
                            self.dragEvent.last = e.pageX;
                            self.move(step);
                        }
                    },
                    touchend : function (e) {
                        self.onDragComplete(e, true);
                    }
                });
            }
        },
        onDragComplete : function (e) {
            var to = 0, x = null, oldx, dontReset = false;
            try {
                x = this.dragEvent.click ? e.clientX : this.dragEvent.last;
                oldx = this.dragEvent.oldX;
            } catch (e) {
            //$('debug').innerHTML = e;
            }
            if (oldx - x > 10)
                to = this.current + 1 < this.getMaxChilds() ? this.current + 1 : this.current;
            else if (oldx - x < -10)
                to = this.current - 1 > 0 ? this.current - 1 : 0;
            else {
                to = this.current;
            }
            dontReset = this.slideTo(to, x - this.dragEvent.oldX);
            if (this.fn['onDragComplete'])
                this.fn['onDragComplete']();
            this.slide(dontReset);
        },
        firstRun : function () {
            this.current = 0;
            //this.run(0);
            this.rotator[this.current].animate()
            this.setActive(this.buttons[0]);
        },

        run : function (to) {
            var reset;
            this.removeVisualTimer();
            this.pauseSlide();
            //from = this.current * this.width * -1;
            reset = this.slideTo(to);
            //to = this.next * this.width * -1;
            this.slide(reset);

        },
        checkDrag : function (x) {
            if (!x)
                return 0;
            var cx = parseInt(this.element.css('left')),
            thresold = cx - x, n = this.current * -this.width;
            if (thresold % this.width == 0)
                return x;
            x = x + (thresold - n);
            return x;
        },
        clearFrame : function () {
            if (this.current - 1 >= 0)
                this.rotator[this.current - 1].initFrame();
            if (this.current + 1 < this.getMaxChilds())
                this.rotator[this.current + 1].initFrame();
        },
        cleanCSS : function () {
            var self = this;
            $.each(this.rotator, function (i, el){
                el.cleanCSS(self.prefix);
            });
        },
        /**
     * Move to a specified slider
     * @param int to is the slide number we want to slide to
     **/
        slideTo: function (to, oldx) {
            var a =  to - this.current;
            oldx = this.checkDrag(oldx);
            if(this.current == to) {
                this.step = '-=' + parseInt(oldx);
                return false;
            }
            this.next = (to) % this.getMaxChilds();
            if (this.current == this.next)
                return false;
            if (this.options.transitions)
                this.swapIndex(this.current, this.next);
            //this._pause();
            this.setActive(this.buttons[this.next]);
            this.rotator[this.next].initFrame();
            this.cleanCSS();
            this.rotator[this.next].dir = this.next - this.current > 0 ? 1 : -1;
            this.current = this.next;
            to = a != 0 ? a : 1;
            this.step = '-=' + ((this.width * a) + parseInt(oldx));
            return true;
        },
        slide : function (reset) {
            if (this.fn['onStartSlide'])
                this.fn['onStartSlide']();
            var self = this, step = 0;
            this.dragEvent.ok = false;
            this.element.animate({
                left : this.step,
                useTranslate3d: true,
                leaveTransforms : false
            }, 1000, function () {
                if (self.current != self.next)
                    self.current = self.next;
                self.unPause();
                self.dragEvent.ok = true;
                if (reset) {
                    self.clearTimers();
                    self.rotator[self.current].animate();
                }
                self.setActive(self.buttons[self.current]);
                if (self.fn['onFinishSlide'])
                    self.fn['onFinishSlide']();
            });
            return true;
        },
        getTransitions : function (el) {
            var transition = {
                slide : {
                    none : {
                        value : 0,
                        init : this.width
                    },
                    left : {
                        value : 0,
                        init : this.width
                    },
                    right : {
                        value : 0,
                        init : -this.width
                    },
                    up : {
                        value : 0,
                        init : el.height()
                    },
                    down : {
                        value : -this.width,
                        init : 0
                    }
                },
                fade : {
                    none : {
                        value : 1,
                        init : 0
                    }
                },
                none : {
                    none : {
                        value : 0,
                        init : 0
                    }
                }
            }, translate = {
                up : 'top',
                right : 'left',
                left : 'left',
                down : 'top',
                fade : 'opacity',
                none : 'left'
            }, effect = el.attr('data-effect') ? el.attr('data-effect') : 'fade',
            dir = el.attr('data-direction') ? el.attr('data-direction') : 'none',
            o = {};
            if (translate[dir] && dir !='none') {
                el.css(translate[dir], transition[effect][dir].init);
                o[translate[dir]] = transition[effect][dir].value;
            } else {
                el.css(translate[effect], transition[effect][dir].init);
                o[translate[effect]] = transition[effect][dir].value;
            }
            o['translate3d'] = true;
            return o;
        },
        swapIndex : function (c, n) {
            $.each(this.rotator, function (i, el) {
                $(el.els).css('z-index', 0);
            });
            $(this.rotator[n].els).css('z-index', 400);
            $(this.rotator[c].els).css('z-index', 200);
            /*if (this.current >= 0)
                $(this.rotator[c].els).css('z-index', 2);*/
        },
        transitionSlide : function (reset) {
            if (this.fn['onStartSlide'])
                this.fn['onStartSlide']();
            var self = this, el = $(this.rotator[self.current].els);
            el.animate(this.getTransitions(el),
                el.attr('data-time') ? parseInt(el.attr('data-time')) : 1000,
                el.attr('data-easing') ? el.attr('data-easing') : 'easeOutExpo',
                function () {
                    if (self.current != self.next)
                        self.current = self.next;
                    self.unPause();
                    if (reset) {
                        self.clearTimers();
                        self.rotator[self.current].animate();
                    }
                    self.setActive(self.buttons[self.current]);
                    if (self.fn['onFinishSlide'])
                        self.fn['onFinishSlide']();
                });
            return true;
        },
        clearTimers : function () {
            /*
            for (var i = 0, max = this.rotator.length; i < max; i++)
                this.rotator[i].clearTimers();*/
        },
        setActive : function (obj) {
            try {
                obj = obj.tojQuery();
            } catch (e) {}
            try {
                if (!obj)
                    obj = this.buttons[0];
                if (this.lastClicked)
                    this.lastClicked.removeClass('active');
                this.lastClicked = obj;
                obj.addClass('active');
            } catch (e) {}
        },
        getMaxChilds : function () {
            return this.childs;
        },
        createOneControls : function (div, i) {
            var a, self = this;
            a = new Element('a',{
                'class' : '_flex_button',
                'rel' : i,
                'href' : '#slider_page' + (i + 1),
                'html' : self.options.numeric ? (i + 1) : '',
                'events' : {
                    'click' : function () {
                        if (!self.pause) {
                            self.cleanCSS();
                            self.delaySlide();
                            self.run($(this).attr('rel'));
                        }
                    }
                }
            });
            div.append(a.tojQuery());
            this.buttons.push(a);
        },
        /**
     * Build controls
     */
        controls : function (div) {
            if (this.buttons.length)
                return;
            if (!this.options.onlyPrevNextControls) {
                var a, self = this, div = $(div);
                for (var i = 0, max = this.getMaxChilds(); i < max; i++) {
                    this.createOneControls(div, i);
                }
            }
            a = new Element('a', {
                'class' : 'prev' +  ($.browser.msie ? ' IE'+$.browser.version.substr(0, 1) : ''),
                'href' : '#slider_page' + (i + 1),
                'html' : '&lt;',
                'events' : {
                    'click' : function () {
                        if (!self.pause || 1) {
                            self.delaySlide();
                            self.cleanCSS();
                            self.playPrevious();
                        }
                    }
                }
            });
            div.append(a.tojQuery());
            a = new Element('a', {
                'class' : 'next' + ($.browser.msie ? ' IE'+$.browser.version.substr(0, 1) : ''),
                'href' : '#slider_page' + (i + 1),
                'html' : '&gt;',
                'events' : {
                    'click' : function () {
                        if (!self.pause || 1) {
                            self.delaySlide();
                            self.cleanCSS();
                            self.playNext();
                        }
                    }
                }
            });
            div.append(a.tojQuery());
        },
        /**
     *  API FUNCTIONS
     */
        addCallBack : function (fn, key) {
            this.fn[key] = fn;
        },
        removeCallBack : function (key) {
            this.fn[key] = function () {};
        },
        addSlide : function (div) {
            var self = this;
            tmp = new AnimatedDiv({
                el : div,
                width : this.width ? this.width : div.width()
            });
            tmp.addEvent('Animated.finish', function () {
                self.resetDelay();
                self.finishedPlaying = true;
            });
            if (this.options.controls)
                this.createOneControls(this.options.controls, this.childs);
            this.childs += 1;
            div.addClass('rotator');
            this.element[0].css('width', this.childs * this.width);
            this.element[0].adopt(div.toJquery());
            this.rotator.push(tmp);
            this.run(this.childs - 1);
        },
        setControls : function (controls) {
            var self = this;
            this.buttons = controls;
            this.lastClicked = this.buttons[0];
            controls.bind(
                'click', function (e) {
                    self.buttons.each(function () {
                        $(this).removeClass('active');
                    })
                    if (!self.pause) {
                        $(this).addClass('active');
                        self.delaySlide();
                        self.run($(this).attr('rel'));
                    }
                })
        },
        disallowDrag : function() {
            this.dragEvent.ok = false;
        },
        allowDrag : function() {
            this.dragEvent.ok = true;
        },
        autoPlay : function () {
            if (!this.pause && !this.options.noAutoPlay)
                this.run(this.current + 1 < this.getMaxChilds() ? this.current + 1 : 0);
        },
        delaySlide : function () {
            window.clearTimeout(this.fdelay);
            this.fdelay = null;
        //this.fdelay = this._delay();
        },
        _pause : function () {
            this.finishedPlaying = true;
            this.pause = true;
        },
        unPause : function () {
            this.pause = false;
        },
        pauseSlide : function () {
            this._pause();
            window.clearTimeout(this.fdelay);
        },
        playNext : function () {
            this.autoPlay();
        },
        playPrevious : function () {
            this.run(this.current - 1 < 0 ? this.getMaxChilds() - 1 : this.current - 1);
        },
        nextSlideDelay : function () {
            var delay = null;
            if (this.current > 0)
                delay = this.rotator[this.current].toElement().attr('data-autoplay')
            else
                delay = this.rotator[0].toElement().attr('data-autoplay');
            if (!delay)
                delay = this.delay;
            return delay;
        },
        resetDelay : function () {
            window.clearTimeout(this.fdelay);
            this.fdelay = this._delay();
            return 1;
        },
        _delay : function () {
            var self = this;
            window.clearTimeout(this.fdelay);
            if (!this.options.noVisualTimer)
                this.showVisualTimer(this.dom, this.nextSlideDelay());
            return window.setTimeout(function ()  {
                self.autoPlay();
                self.removeVisualTimer();
            }, this.nextSlideDelay());
        }
    });
})();