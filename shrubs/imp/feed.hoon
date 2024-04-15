/@  feed-action
|%
++  state  %sig
++  poke   (sy %feed-action ~)
++  kids   
  %-  ~(gas by *kids:neo)
  :~  [~[&/%mirror |/%p] %sig %sig]
      [~[&/%source] %sig %source-diff]
  ==
++  deps   *deps:neo
++  form
  ^-  form:neo
  |_  [=bowl:neo =ever:neo state-vase=vase *]
  ++  poke
    |=  [=stud:neo vax=vase]
    ^-  (quip card:neo vase) 
    ::?>  =(our.bowl src.bowl)
    ?>  =(%feed-action stud)
    =/  act  
      ;;  feed-action
      !<(feed-action vax)
    :_  state-vase
    ?-    -.act
        %follow
      =/  =conf:neo
        (malt [[%source ~[p/ship.act %feed %source]] ~])
      :~  :-  (welp here.bowl ~[%mirror p/ship.act]) 
          [%make %mirror `!>(~) conf]
      ==
    ::
        %post
      :~  :-  (snoc here.bowl %source) 
          [%poke %source-diff !>([%post entry.act])]
      ==
    ==
  ++  init
    |=  vas=(unit vase)
    :_  *vase
    :~  :-  (snoc here.bowl %source) 
        [%make %source `!>(~) ~]
    ==
  --
--