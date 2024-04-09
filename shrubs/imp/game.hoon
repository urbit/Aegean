/@  game
/@  game-diff
/@  game-event
/@  game-obj
=>
|%
++  make-obj
  |=  [=bowl:neo obj=game-obj type=@tas]
  ^-  card:neo
  :-  (snoc here.bowl da/now.bowl) 
  ^-  note:neo
  :-  %make 
  [type `!>(obj) ~]
--
|%
++  state  %game
++  poke   (sy %game-diff %game-event ~)
++  kids   
  %-  ~(gas by *kids:neo)
  :~  [~[|/%tas] %game-obj %game-event]
  ==
++  deps   *deps:neo 
++  form
  ^-  form:neo
  |_  [=bowl:neo =ever:neo state-vase=vase *]
  ++  poke
    |=  [=stud:neo vax=vase]
    ^-  (quip card:neo vase)
    ?+    stud  !! 
        %game-diff
      =/  poke  !<(game-diff vax)
      :_  state-vase
      ?-    -.poke
          %add-enemy
        [(make-obj [bowl obj.poke %enemy]) ~]
      ==
    ::
        %game-event
      ~&  >  'got event'
      :_  state-vase
      %+  turn
        ~(tap by kids.bowl)
      |=  [=pith =vase]
      ~&  >>  'poking kid'
      ^-  card:neo
      :-  pith
      ^-  note:neo
      [%poke %game-event vax]
    ==
  ++  init
    |=  vas=(unit vase)
    ::  dimensions=@ud
    :_  (need vas)
    [(make-obj [bowl [%player 1 1 '@'] %player]) ~]
  --
--