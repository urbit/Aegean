/@  comment
/@  comment-diff
|%
++  state  %comment
++  poke   (sy %comment-diff ~)
++  kids   *kids:neo
++  deps   *deps:neo
++  form
  ^-  form:neo
  |_  [=bowl:neo =ever:neo state-vase=vase *]
  ++  poke
    |=  [=stud:neo vax=vase]
    ^-  (quip card:neo vase)
    ?>  =(%comment-diff stud)
    ::only edited by creator 
    =/  sta  !<(comment state-vase)
    ?>  =(ship.src.bowl from.sta)
    =/  new-comment  !<([%edit-comment =cord] vax)
    =.  what.sta  cord.new-comment
      [~ !>(sta)]
  ++  init
    |=  vas=(unit vase)
    ~&  vas
    `(need vas)
  --
--