|%
+$  signature  [p=@uvH q=ship r=life]
+$  signal  [=ref =hops]      ::  what gets broadcast
+$  ref                       ::  FQSP such that mark is %entry
  $|  path
  |=  =path
  ?=  %entry  (rear path)
::  TO-DO that refs require:
::  - author in the head
::  - require timestamp, other cases rejected
::  - originating desk included
::
+$  hops                       ::  do not allow >2 hops
  $|  @ud
  |=  n=@ud
  (lte n 2)
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
  $%  [%url path]            ::  url with supported mime type
      [%scry path]           ::  FQSP with supported datatype mark
  ==
::
+$  saved  (set ref)
+$  hidden  (set ref)
+$  boosts  (map ref [ship @da])  ::  ships who have boosted and when
+$  store  (map ref (unit entry))  ::  the content that gets sorted
::  +$  sort  (map ref weight=@sd)
::  +$  fresh  (list [ref weight])  :: populated upon hearing new ref
::
+$  locker  (set evidence)   ::  reported refs from friends
+$  evidence
  $:
    mine=signature
    %disavow
    =ref
    theirs=signature
    =entry
  ==
::
+$  action  :: Called locally
  $%  [%create =entry =hops]  :: Grows a ref and then broadcasts
      [%save =ref]
      [%hide =ref]
    :: [%boost =ref]
    :: [%report =ref]
    :: [%read =ref]  :: Activity tracking
  ==
+$  message  :: Called from other ships
  $%  [%receive =signal]
    ::[%praise =entry]
    ::[%tattle =evidence]
  ==
--