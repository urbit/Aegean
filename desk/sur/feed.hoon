|%
+$  signature  [p=@uvH q=ship r=life]
+$  signal  [=ref =hops]      ::  what gets broadcast
+$  ref                       ::  FQSP such that mark is %entry
  $:  author=@p
      time=@da
      agent=@tas
      %entry
  ==
  ::$|  path
  ::|=  p=path
  ::~&  >>  'checking'
  ::~&  >>  p
  ::~&  >>  -.p
  ::=+  (slav %p -.p)
  ::=+  (slav %da +<.p)       :: should probably sanity-check time too
  ::=+  (slav %tas +>-.p)
  ::?&  =(+>+<.p %entry)
  ::    =((lent p) (lent [%author %time %agent %entry ~]))
  ::==
::
+$  hops  @ud                ::  do not allow >2 hops
::
+$  entry                    ::  /mar/entry/hoon
  $:  text=(unit cord)       ::  max length 256 bytes
      link=(unit rich)
      quote=(unit ref)
      tags=(set @ta)
  ==
+$  rich
  $%  [%preview =preview]
      [%media =media]
  ==
+$  preview  (map path cord) ::  OGP data
+$  media
  $%  [%url url=@t]        ::  url with supported mime type
      [%scry =path]        ::  FQSP with supported datatype mark
  ==
::
+$  saved  (set ref)
+$  hidden  (set ref)
+$  boosts  (map ref (map ship @da))  ::  ships who have boosted and when
+$  store  (map ref (unit entry))  ::  the content that gets sorted
::  +$  sort  (map ref weight=@sd)
::  +$  fresh  (list [ref weight])  :: populated upon hearing new ref
::
+$  locker  (map evidence @da)   ::  reported refs from friends
+$  evidence
  $:  mine=signature    ::  [p=@uvH q=ship r=life]
      %disavow
      =ref
      theirs=signature
      =entry
  ==
::
+$  command  :: Backend pokes
  $%  [%create =entry =hops]  :: Grows a ref and then broadcasts
  ==
+$  interaction  :: Called by user from UI
  $%  [%boost =path]
      [%report =path]
      [%save =path]
      [%hide =path]
    :: [%read =path]  :: Activity tracking
  ==
+$  message  :: Called from other ships
  $%  [%receive =signal]
      [%praise =ref]
      [%tattle =ref]
  ==
--