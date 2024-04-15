/@  entry
/@  source-diff
|%
++  state  %sig
++  poke   (sy %source-diff ~)
++  kids   
  %-  ~(gas by *kids:neo)
  :~  [~[|/%da] %entry %sig]
  ==
++  deps   *deps:neo
++  form
  ^-  form:neo
  |_  [=bowl:neo =ever:neo state-vase=vase *]
  ++  poke
    |=  [=stud:neo vax=vase]
    ^-  (quip card:neo vase)
    ::?>  =(our.bowl src.bowl)
    ?>  =(%source-diff stud)
    =/  act  
      ;;  source-diff
      !<(source-diff vax)
    ?>  =(%post -.act)
    :_  state-vase
    :~  :-  (snoc here.bowl da/now.bowl) 
        [%make %entry `!>(entry.act) ~]
    ==
  ++  init
    |=  vas=(unit vase)
    [~ *vase]
  --
--
