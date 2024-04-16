/@  gallery
/@  gallery-diff
/@  photo
=> 
|%
++  add-photo 
  |=  [=bowl:neo pic=photo]
  ^-  card:neo
  ~&  >>  ['here.bowl' here.bowl]
  :-  (welp here.bowl ~[da/now.bowl])
  ^-  note:neo
  [%make %photo `!>(pic) ~]
--
^-  firm:neo
|%
++  state  %gallery
++  poke   (sy %gallery-diff ~)
++  kids  
  %-  ~(gas by *kids:neo)
  :~  [~[&/%photo |/%da] %photo %sig]
  ==
++  deps   ::subscribtions dependencies 
::     :~  acl/[req=& %x %circle %sig]
::   ==
  *deps:neo
++  form
  ^-  form:neo
  |_  [=bowl:neo =ever:neo state-vase=vase *]
  ++  init
    |=  vas=(unit vase)
    ::  Must name your gallery on %make
    [~ (need vas)]
  ::
  ++  poke
    |=  [=stud:neo vax=vase]
    ^-  (quip card:neo vase)
    ?>  =(%gallery-diff stud)
    =/  poke  !<(gallery-diff vax)
    ?>  =(our ship.src):bowl
    ?-  -.poke
        %name  
      =/  sta   !<(gallery state-vase)
      [~ !>(sta(name name.poke))]
      ::
        %add-photo
      ~&  photo.poke
      :_  state-vase
      ~[(add-photo bowl photo.poke)]
      ::
        %del-photo
      ~&  date.poke
      ~&  >>  ['here.bowl' here.bowl]
      `state-vase
    ==
  --
--