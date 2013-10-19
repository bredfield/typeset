class Typeset
  constructor:(options, element)->
    @node = $(element)
    
    ##Set up options w/ defaults
    @interval = options.interval || 150
    @jitter = options.jitter || 30
    @wordDelay = options.wordDelay || 100
    @cursorColor = options.cursorColor || "#69D2E7"
    @pauseDuration = options.pauseDuration || 100
    @longPauseDuration = options.longPauseDuration || 2000

    @init()

  init:()->
    ##Set up node, append to DOM
    @node.addClass('typeset')
      .show()
    text = @node.text()
    height = @node.height()
    textNode = $("<span class='typset-text' />")
    cursorNode = $("<span class='typeset-cursor' />")
      .css
        height:parseInt(@node.css("line-height"))-20
        background:@cursorColor
    @node.html("")
    @node.append [textNode,cursorNode]

    chars = text.split("")
    length = chars.length
    i = 0

    addChar = ()=>
      if i < length
        delay = @interval + Math.floor(Math.random()*@jitter)
        nextChar = chars[i]

        ##Normal pause
        if nextChar is "|"
          delay += @pauseDuration
          cursorNode.addClass('blink')
        ##Long pause
        else if nextChar is "^"
          delay += @longPauseDuration
          cursorNode.addClass('blink')
        ##Deletion
        else if nextChar is "~"
          textNode.text(textNode.text().slice(0,-1))
        ##Every other character
        else
          textNode.append(nextChar)
          cursorNode.removeClass('blink')

         if nextChar is " "
           delay += @wordDelay

        i++

        setTimeout ()->
          addChar()
        , delay

      else
        cursorNode.addClass('blink')

    addChar()

##Initialize plugin
$ = jQuery
$.fn.typeset = (options)->
  typeset = new Typeset(options || {}, @)

