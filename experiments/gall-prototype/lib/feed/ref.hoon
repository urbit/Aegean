/-  *feed
|%
::  Any weird bugs from assuming %entry here?
++  ref-to-path
  |=  =ref
  ^-  path
  :~  (scot %p author.ref)
      (scot %da time.ref)
      (scot %tas agent.ref)
      %entry
  ==
::
++  path-to-ref
  |=  =path
  ^-  ref
  :*  (slav %p -.path)
      (slav %da +<.path)
      (slav %tas +>-.path)
      %entry
  ==
--