/@  message
|%
::  +state: Type of state
::  
::    This is a doccord
::
++  state  %message
::  +poke: Accepted poke handlers
::
::    None
++  poke   ~
++  kids   *kids:neo
++  deps   *deps:neo
++  form
  ^-  form:neo
  |_  [=bowl:neo =ever:neo state-vase=vase *]
  ++  poke
    |=  [=stud:neo vax=vase]
    `state-vase
  ++  init
    |=  vas=(unit vase)
    `(need vas)
  --
--
