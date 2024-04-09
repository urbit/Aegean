::  imp/square implements the %circle-diff poke,
::  meaning that it's a valid kid of imp/circles:
::  [~[|/%tas] %sig %circle-diff]
::  imp/square ignores the provided made and instead
::  adds the provided ship as a pal
::
/@  diff=circle-diff
|%
++  state  %sig
++  poke   (sy %circle-diff ~)
++  kids   
  %-  ~(gas by *kids:neo)
  :~  [~[|/%p] %pal %sig]
  ==
++  deps   *deps:neo
++  form
  ^-  form:neo
  |_  [=bowl:neo =ever:neo state-vase=vase *]
  ++  poke
    |=  [=stud:neo vax=vase]
    ?>  ?=(%circle-diff stud)
    =+  !<(=diff vax)
    :_  state-vase
    ?-    -.diff
        %add  
      %+  turn  ~(tap by p.diff)
      |=  [=ship =made:neo]
      [(snoc here.bowl p/ship) %make [%pal `!>([ship %target ~]) ~]]
    ::
        %del
      !!
    ==
  ++  init
    |=  vas=(unit vase)
    `*vase
  --
--
