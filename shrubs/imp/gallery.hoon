/@  gallery
/@  gallery-diff
/@  photo
=> 
|%
++  state  gallery
++  poke   gallery-diff
++  card   card:neo
++  add-photo 
  |=  [=bowl:neo pic=photo]
  ^-  card:neo
  ~&  >>  ['were.bowl' were.bowl]
  :-  (welp were.bowl ~[da/now.bowl])
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
  +*  sta  !<(gallery state-vase)
  ++  poke
    |=  [=stud:neo vax=vase]
    ^-  (quip card:neo vase)
    ?>  =(%gallery-diff stud)
    =+  !<(poke=gallery-diff vax)
    ~&  >>>  poke
    =/  sta  sta
    ?>  =(our ship.src):bowl
    ?-  -.poke
        %name  
        ~&  deps.bowl
          [`(list card)`~ !>(sta(name name.poke))]
        %add-photo
          ~&  photo.poke
          :-  ~[(add-photo bowl photo.poke)]
              !>(sta)
        %del-photo
          ~&  date.poke
          ~&  >>  ['here.bowl' here.bowl]
          ~&  ~[[(snoc here.bowl da/date.poke) %tomb ~]]
          :-  ~[[(snoc here.bowl da/date.poke) %tomb ~]]
              !>(sta)
    ==
    ::[~ !>(sta)]
  ++  init
    |=  vas=(unit vase)
    `!>(*^state)  ::name=''
  --
--