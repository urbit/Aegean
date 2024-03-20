|%
+$  signature  [p=@uvH q=ship r=life]
+$  signal  [=ref =hops]      ::  what gets broadcast
+$  hops  @ud                 ::  >2 hops are disallowed by agent
+$  ref                       ::  FQSP such that mark is %entry
  $:  author=@p
      time=@da
      agent=@tas
      %entry
  ==
::
+$  store  (map ref (unit entry))
+$  saved  (set ref)
+$  hidden  (set ref)
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
+$  boosts  (map ref (map ship @da))  ::  ships who have boosted and when
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