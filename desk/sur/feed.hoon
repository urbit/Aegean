|%
+$  signature  [p=@uvH q=ship r=life]
+$  signal  [=post =hops]      ::  what gets broadcast
+$  hops                       ::  do not allow >2 hops
  $|  @ud
  |=  n=@ud
  (lte n 2)
+$  post                       ::  FQSP such that mark is %entry
  $|  path
  |=  =path
  ?=  %entry  (rear path)
::
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
+$  action  :: Called locally
  $%  [%create =post =hops]  :: Grows the post and then broadcasts
    ::  To-Do - %create should take an entry, not a post
    :: [%save =post]
    :: [%hide =post]
    :: [%boost =post]
    :: [%report =post]
    :: [%read =post]
  ==
+$  message  :: Called from other ships
  $%  [%gossip =signal]
    ::[%praise =entry]
    ::[%tattle =evidence]
  ==
--