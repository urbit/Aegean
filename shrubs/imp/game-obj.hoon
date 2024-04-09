/@  game-obj
|%
++  state  %game-obj
++  poke   (sy %game-event ~)
++  kids   *kids:neo
++  deps   *deps:neo
++  form
  ^-  form:neo
  |_  [=bowl:neo =ever:neo state-vase=vase *]
  ++  poke
    |=  [=stud:neo vax=vase]
    ?>  =(%game-event stud)
    ~&  >  ['Got poke!' bowl]
    `state-vase
  ++  init
    |=  vas=(unit vase)
    ::  [type=@tas x=@ud y=@ud sprite=@t]
    [~ (need vas)]
  --
--