|%
++  state  %sig
++  poke   ~
++  kids   
  %-  ~(gas by *kids:neo)
  :~  [~[|/%da] %entry %sig]
  ==
++  deps
  %-  ~(gas by *deps:neo)
  :~  :-  %src
      :^  req=&  %y  [%source %sig]
      %-  ~(gas by *kids:neo)
      :~  [~[|/%da] [%entry %sig]]
      ==
  ==
++  form
  ^-  form:neo
  |_  [=bowl:neo =ever:neo state-vase=vase *]
  ++  poke
    |=  [=stud:neo vax=vase]
    ^-  (quip card:neo vase)
    [~ state-vase]
  ++  init
    |=  vas=(unit vase)
    [~ *vase]
  --
--
