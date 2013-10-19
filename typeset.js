(function() {
  var $, Typeset;

  Typeset = (function() {
    function Typeset(options, element) {
      this.node = $(element);
      this.interval = options.interval || 150;
      this.jitter = options.jitter || 30;
      this.wordDelay = options.wordDelay || 100;
      this.cursorColor = options.cursorColor || "#69D2E7";
      this.pauseDuration = options.pauseDuration || 100;
      this.longPauseDuration = options.longPauseDuration || 2000;
      this.init();
    }

    Typeset.prototype.init = function() {
      var addChar, chars, cursorNode, height, i, length, text, textNode,
        _this = this;
      this.node.addClass('typeset').show();
      text = this.node.text();
      height = this.node.height();
      textNode = $("<span class='typset-text' />");
      cursorNode = $("<span class='typeset-cursor' />").css({
        height: parseInt(this.node.css("line-height")) - 20,
        background: this.cursorColor
      });
      this.node.html("");
      this.node.append([textNode, cursorNode]);
      chars = text.split("");
      length = chars.length;
      i = 0;
      addChar = function() {
        var delay, nextChar;
        if (i < length) {
          delay = _this.interval + Math.floor(Math.random() * _this.jitter);
          nextChar = chars[i];
          if (nextChar === "|") {
            delay += _this.pauseDuration;
            cursorNode.addClass('blink');
          } else if (nextChar === "^") {
            delay += _this.longPauseDuration;
            cursorNode.addClass('blink');
          } else if (nextChar === "~") {
            textNode.text(textNode.text().slice(0, -1));
          } else {
            textNode.append(nextChar);
            cursorNode.removeClass('blink');
          }
          if (nextChar === " ") {
            delay += _this.wordDelay;
          }
          i++;
          return setTimeout(function() {
            return addChar();
          }, delay);
        } else {
          return cursorNode.addClass('blink');
        }
      };
      return addChar();
    };

    return Typeset;

  })();

  $ = jQuery;

  $.fn.typeset = function(options) {
    var typeset;
    return typeset = new Typeset(options || {}, this);
  };

}).call(this);
