|%
+$  signature  [p=@uvH q=ship r=life]
+$  signal                   ::  what gets broadcast
  $:
    =hops
    =post
  ==
+$  hops  ?(%0 %1 %2)        ::  do not allow >2 hops
+$  post                     ::  FQSP such that mark is %entry
  $|  path
  |=  =path
  ?=  %entry  (rear path)        
::  author in the head
::  require timestamp, other cases rejected
::  originating desk included
+$  entry                    ::  /mar/entry/hoon
  $:
    text=(unit cord)           ::  max length 256 bytes
    link=(unit rich)
    quote=(unit post)
    tags=(set @ta)
  ==
+$  rich
  $%
    [%media =media]
    [%preview =preview]
  ==
+$  media
  $%
    [%url path]              ::  url with supported mime type
    [%scry path]             ::  FQSP with supported datatype mark
  ==
+$  preview  (map path cord) ::  OGP data
+$  saved  (set post)
+$  hidden  (set post)
+$  boosts  (map post [ship @da])  ::  ships who have boosted and when
+$  store  (map post (unit entry))  ::  the content that gets sorted
::  +$  sort  (map post weight=@sd)
::  +$  fresh  (list [post weight])  :: populated upon hearing new post
::
+$  locker  (set evidence)   ::  reported posts from friends
+$  evidence
  $:
    mine=signature
    %disavow
    =post
    theirs=signature
    =entry
  ==
::
+$  action
  $%
    [%broadcast =signal]
    :: [%save =post]
    :: [%hide =post]
    :: [%boost =post]
    :: [%report =post]
    :: [%read =post]
  ==
+$  message
  $%
    [%gossip =signal]
    [%praise =entry]
    [%tattle =evidence]
  ==
--