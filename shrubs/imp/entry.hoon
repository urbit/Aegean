/@  entry
|%
++  state  %entry
++  poke   ~
++  kids   *kids:neo
++  deps   *deps:neo
++  form
  ^-  form:neo
  |_  [=bowl:neo =ever:neo state-vase=vase *]
  ++  poke
    |=  [=stud:neo vax=vase]
    [~ state-vase]
  ++  init
    |=  vas=(unit vase)
    =/  v  ;;(@t !<(@t (need vas)))
    [~ !>(v)]
  --
--
