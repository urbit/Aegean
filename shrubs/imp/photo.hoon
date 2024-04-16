/@  photo
/@  comment
/@  photo-diff
=>
|%
++  add-comment
  |=  [=bowl:neo =cord]
  ^-  card:neo
  :-  (welp here.bowl ~[da/now.bowl])
  ^-  note:neo
  [%make %comment `!>([ship.src.bowl cord]) ~]
--
^-  firm:neo
|%
++  state  %photo
++  poke   (sy %photo-diff ~)
++  kids   
  %-  ~(gas by *kids:neo)
  :~  [~[&/%comment |/%da] %comment %sig]
  ==
++  deps   *deps:neo
++  form
  ^-  form:neo
  |_  [=bowl:neo =ever:neo state-vase=vase *]
  ++  init
  |=  vas=(unit vase)
  `(need vas)
  ::
  ++  poke
    |=  [=stud:neo vax=vase]
    ^-  (quip card:neo vase)
    ?>  =(%photo-diff stud)
    =/  poke  !<(photo-diff vax)
    ::here should be check if @p allowed to add or del comment(only allowed by owner of gallery or by commentator)
    ?-  -.poke
    %add-comment
    :_   state-vase
    ~[(add-comment bowl what.poke)]
    ::
    %del-comment
    ?>  |(=(our ship.src):bowl =(ship.poke ship.src.bowl))
    ~&  'allowed to delete comment'
    `state-vase
    ==
  --
--