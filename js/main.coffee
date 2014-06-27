
$ ->
  score = 0
  WinningTileValue = 2048



  ppArray = (array) ->
    for row in array
      console.log row


  buildBoard = ->
    [0..3].map -> [0..3].map -> 0



  generateTile= (board) ->
    unless boardFull(board)
      val = randomValue()
      [x,y] = getRandomCellIndices()
      if board[x][y] == 0
        board[x][y]=val
      else
        generateTile(board)


  # Return any value from 0 to 3
  randomIndex= (x) ->
    Math.floor(Math.random()* x)

  # Return any value of 2 or 4
  randomValue = ->
    values =[2, 2, 2, 4]
    values[randomIndex(values.length)]

  # Return random coordinate
  getRandomCellIndices = ->
    [randomIndex(4), randomIndex(4)]

  arrayEqual = (a,b) ->
    for val, i in a
      if val != b[i]
        return false
    true

  boardEqual = (a,b) ->
    for row, i in a
      unless arrayEqual(row, b[i])
        return false
    true

    a = [[0,0],[0,0]]
    b = [[0,0],[0,0]]
    c = [[0,0],[0,1]]

  moveIsValid = (a, b ) ->
      not boardEqual(a, b)

  noValidMoves = (board) ->




  boardFull= (board)->
    for row in board
      for cell in row
        if cell == 0
          return false
    true

  collapseCells=(cells, direction) ->
    cells = cells.filter (x) -> x != 0
    padding = 4 - cells.length

    for i in [0...padding]
      switch direction
        when 'right' then cells.unshift 0
        when 'left' then cells.push 0
        when 'down' then cells.unshift 0
        when 'up' then cells.push 0
    cells

  # console.log "collapseCells"+ collapseCells([0,2,0,4], 'left')
  # console.log "collapseCells"+ collapseCells([0,2,0,4], 'right')

  mergeCells = (arrayToMerge, direction) ->
    newArray = arrayToMerge
    switch direction
      when 'up', 'right'
        for x in [3...0]
          for y in [x-1..0]
            if newArray[x] == 0 then break
            else if newArray[x] == newArray[y]
              newArray[x]= newArray[x]* 2
              addScore(newArray[x])
              newArray[y]=0
              break
            else if newArray[y] != 0
              break
      when 'down', 'left'
        for x in [0...3]
          for y in [x+1..3]
            if newArray[x] == 0 then break
            else if newArray[x] == newArray[y]
              newArray[x]= newArray[x]*2
              newArray[y]= 0
              break
            else if newArray[y] !=0
              break
    newArray

  getRow = (rowNumber, board) ->
    [r,b] = [rowNumber, board]
    [b[r][0],b[r][1], b[r][2], b[r][3]]

    #board[rowNumber]
  getColumn = (columnNumber, board) ->
    column = []
    for row in [0..3]
      column.push board[row][columnNumber]
    column

  setRow = (row, rowNumber, board) ->
    # row = board[rowNumber]
    board[rowNumber] = row

  # ppArray(setRow([1,1,1,1], 0,@board))

  setColumn = (column, columnNumber, board) ->
    c= columnNumber
    b= board
    [b[0][c],b[1][c],b[2][c],b[3][c]] = column

  move = (board, direction) ->

    newBoard = buildBoard()

    switch direction
      when 'left','right'
        for i in [0..3]
          row = mergeCells(getRow(i, board),direction)
          row = collapseCells(row, direction )
          setRow(row, i, newBoard)
      when 'up','down'
        for i in [0..3]
          column = mergeCells(getColumn(i,board), direction)
          column = collapseCells(column, direction)
          setColumn(column, i, newBoard)

    ppArray(newBoard)
    newBoard


  gameWon = (board) ->
    for row in board
      for cell in row
        if cell >= WinningTileValue
          return true
    false

  addScore = (x) ->
    score = score + x
    $('.scoreboard > h2').html("score: #{score}")

  setScoreZero = (@board) ->
    @board = buildBoard
    score = 0
    $('.scoreboard > h2').html("score: #{score}")



  gameLost = (board) ->
    boardFull(board) && noValidMoves(board)

  showValue = (value) ->
    if value == 0 then "" else value



  showBoard = (board) ->
    for i in [3..0]
      for j in [0..3]
        c = board[i][j]
        if c is 0
          $(".r#{i}.c#{j}>div").html('')
        else
          $(".r#{i}.c#{j}>div").html(c)


  $('body').keydown (e) =>
    key=e.which
    keys= [37..40]

    if $.inArray(key,keys)> -1
      e.preventDefault()

    direction = switch key
      when 37 then 'left'
      when 38 then 'up'
      when 39 then 'right'
      when 40 then 'down'

    newBoard = move(@board, direction)

    if moveIsValid(newBoard,@board)
      @board = newBoard
      generateTile(@board)
      showBoard(@board)
      console.log gameLost(@board)
      if gameLost(@board)
        console.log "Game Over!!"
        alert "Game Over!!"
      else if gameWon(@board)
        console.log "Victory!!"
        alert "Victory"



  @board = buildBoard()
  generateTile(@board)
  generateTile(@board)
  ppArray(@board)
  showBoard(@board)

  $('#resetButton').click =>
    setScoreZero(@board)
    @board = buildBoard()
    generateTile(@board)
    generateTile(@board)
    showBoard(@board)





  # console.log "mergeCells " + mergeCells([2,2,2,2]) #=> 0,4,0,4
  # console.log "mergeCells " + mergeCells([2,2,2,2]) #=> 0,4,0,4
  # console.log "mergeCells " + mergeCells([2,2,4,2]) #=> 0,4,4,2
  # console.log "mergeCells " + mergeCells([4,2,2,2]) #=> 4,2,0,4
  # generateTile(@board)
  # ppArray(@board)





















