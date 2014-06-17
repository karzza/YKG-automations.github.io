$('#pirates').click ->
  alert "give me your money"

$('#abandonShip').click ->
  alert "sharks"

count=0

$('#submarine').click ->
  console.log count
  count=count+1
  $('#submarineCount').html(count)

$('#restart').click ->
  $('#submarineCount').html(0)
  count=0

worldCup=$('.germany h1').html()
alert worldCup

worldCupYear=$('.germany p').html()
alert worldCupYear

lastNightGame=$('.germany h2').html()
alert lastNightGame

unitedStates=$('.germany h3').html()
alert unitedStates

result=$('.germany h4').html()
console.log result

noSoRealResult=$('.germany p').last().html()
console.log noSoRealResult

result2=$('.result').html()
console.log result2






# $ jQuery
# $('.classNone') <- jQuery
#   $('.classNone') <- jQuery selector
#     $('classNone').click -> <- jQuery click event handler
#       $('#idName').html()<- get html of element
#         $('#idName').html('hello')<- sets html of element
#           $('#idName').append('Boo!')<- appends html to element

