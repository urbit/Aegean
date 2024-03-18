|%
+$  signature  [p=@uvH q=ship r=life]
+$  signal  [=ref =hops]      ::  what gets broadcast
+$  ref   path                    ::  FQSP such that mark is %entry
  ::$|  path
  ::|=  =path
  ::?=  %entry  (rear path)
::  TO-DO that refs require:
::  - author in the head
::  - require past timestamp, other cases rejected
::  - originating desk/agent included
::  /zod/~2023.3.14..1.30.11..1234/feed/turf/entry
::
+$  hops    @ud                   ::  do not allow >2 hops
  ::$|  @ud
  ::|=  n=@ud
  ::(lte n 2)
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
  $%  [%url url=@t]            ::  url with supported mime type
      [%scry path]           ::  FQSP with supported datatype mark
  ==
::
+$  saved  (set ref)
+$  hidden  (set ref)
+$  boosts  (map ref (map ship @da))  ::  ships who have boosted and when
+$  store  (map ref (unit entry))  ::  the content that gets sorted
::  +$  sort  (map ref weight=@sd)
::  +$  fresh  (list [ref weight])  :: populated upon hearing new ref
::
+$  reports  (map ref (map ship @da))  :: treating this as symmetrical to boosts for now
::+$  locker  (map evidence @da)   ::  reported refs from friends
::+$  evidence
::  $:
::    mine=signature    ::  [p=@uvH q=ship r=life]
::    %disavow
::    =ref
::    theirs=signature
::    =entry
::  ==
::
+$  command  :: Backend pokes
  $%  [%create =entry =hops]  :: Grows a ref and then broadcasts
  ==
+$  interaction  :: Called by user from UI
  $%  [%boost =ref]
      [%report =ref]
      [%save =ref]
      [%hide =ref]
    :: [%read =ref]  :: Activity tracking
  ==
+$  message  :: Called from other ships
  $%  [%receive =signal]
      [%praise =ref]
      [%tattle =ref]
  ==
--