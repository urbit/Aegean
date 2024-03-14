/-  *feed, pals, foes
/+  dbug, default-agent
::
|%
::
+$  versioned-state  $%(state-0)
::
+$  state-0  
  $:
    leeches=(set ship)
    targets=(set ship)
    enemies=(set ship)
    =store
    =saved
    =hidden
    =boosts
    =reports
  ==
::
+$  card  $+(card card:agent:gall)
--
::
%-  agent:dbug
=|  versioned-state
=*  state  -
::
^-  agent:gall
::
=<
|_  =bowl:gall
+*  this  .
    def  ~(. (default-agent this %|) bowl)
    hc   ~(. +> [bowl ~])
::
++  on-init
  ^-  (quip card _this)
  =^  cards  state  abet:init:hc
  [cards this]
::
++  on-save
  ^-  vase
  !>(state)
::
++  on-load
  |=  =vase
  ^-  (quip card _this)
  =^  cards  state  abet:(load:hc vase)
  [cards this]
::
++  on-poke
  |=  =cage
  ^-  (quip card _this)
  =^  cards  state  abet:(poke:hc cage)
  [cards this]
::
++  on-peek
  |=  =path
  ^-  (unit (unit cage))
  [~ ~]
::
++  on-agent
  |=  [=wire =sign:agent:gall]
  ^-  (quip card _this)
  =^  cards  state  abet:(agent:hc [wire sign])
  [cards this]
::
++  on-arvo
  |=  [=wire =sign-arvo]
  ^-  (quip card _this)
  =^  cards  state  abet:(arvo:hc [wire sign-arvo])
  [cards this]
::
++  on-watch
  |=  =path
  ^-  (quip card _this)
  [~ this]
::
++  on-fail   on-fail:def
++  on-leave  on-leave:def
--
::
|_  [=bowl:gall deck=(list card)]
+*  that  .
::
++  emit  |=(=card that(deck [card deck]))
++  emil  |=(lac=(list card) that(deck (welp lac deck)))
++  abet  ^-((quip card _state) [(flop deck) state])
::
++  init
  ^+  that
  (emil [leech-card target-card ~])
::
++  leech-card
  ^-  card
  :*  %pass  /leeches  %agent
      [our.bowl %pals]  %watch  /leeches
  ==
::
++  target-card
  ^-  card
  :*  %pass  /targets  %agent
      [our.bowl %pals]  %watch  /targets
  == 
::
++  enemy-card
  ^-  card
  :*  %pass  /enemies  %agent
      [our.bowl %foes]  %watch  /enemies
  == 
::
++  poke
  |=  [=mark =vase]
  ^+  that
  ?+    mark  that
      %feed-action
    ?>  =(our.bowl src.bowl)
    (handle-action (action !<(action vase)))
  ::
      %feed-message
    (handle-message (message !<(message vase)))
  ==
::
++  handle-action
  |=  act=action
  ^+  that
  ?-    -.act
      %create
    =/  ref  /(scot %p our.bowl)/(scot %da now.bowl)/entry
    =.  that  (emit [%pass /growth %grow ref [%entry entry.act]])
    =.  store  (~(put by store) ref [~ entry.act])
    (broadcast [ref hops.act])
  ::
      %boost
    (tell-leeches [%praise ref.act])
  ::
      %report
    (tell-leeches [%tattle ref.act])
  ::
      %save
    that(saved (~(put in saved) ref.act))
  ::
      %hide
    that(hidden (~(put in hidden) ref.act))
  ==
::
++  broadcast
  |=  =signal
  ^+  that
  ?:  =(hops.signal 0)
    that
  =/  sig  [ref.signal (dec hops.signal)]
  (tell-leeches [%receive sig])
::
++  tell-leeches
  |=  msg=message
  ^+  that
  %-  emil
  %+  turn
    ~(tap in leeches)
  |=  =ship
  ^-  card
  :*  %pass  /messages
      %agent  [ship %feed]
      %poke  %feed-message  !>(msg)
  ==
::
++  handle-message
  |=  msg=message
  ^+  that
  ?>  ?&  (~(has in targets) src.bowl)
          ?!  (~(has in enemies) src.bowl)
      ==
  ?-    -.msg
      %receive
    =/  ref  ref.signal.msg
    ?>  (lte 256 (met 3 (jam ref))) :: no huge refs
    =/  author=@p  (need (slaw %p -.ref))
    =.  that  (emit [%pass /scry %arvo %a %keen author ref])
    =.  store  (~(put by store) ref ~)
    (broadcast signal.msg)
  ::
      %praise
    that(boosts (update-mip boosts ref.msg))
  ::
      %tattle
    that(reports (update-mip reports ref.msg))
  ==
::
++  update-mip
  |=  [m=(map ref (map ship @da)) =ref]
  ^+  m
  %+  ~(put by m)
    ref
  =/  n  (~(get by m) ref)
  ?~  n
    `(map @p @da)`(malt (limo [src.bowl now.bowl]~))
  (~(put by (need n)) src.bowl now.bowl)
::
++  arvo
  |=  [=wire =sign-arvo]
  ^+  that
  ?+    wire  that
      [%scry ~]
    ?+    sign-arvo  that
        [%ames %tune *]
      =/  r=roar:ames  (need roar.sign-arvo)
      ::  r is a [dat=[p=/ q=~] syg=~]
      =/  p=path  p.dat.r
      =/  c=(cask)  (need q.dat.r)
      ::  c should be a [%entry *]
      =/  e  ;;(entry +.c)
      that(store (~(put by store) p [~ e]))
    ==
  ==
::
++  agent
  |=  [=wire =sign:agent:gall]
  ^+  that
  ?+    wire  that
      [%leeches ~]
    ?+    -.sign  that
        %kick
      (emit leech-card)
    ::
        %fact
      ?>  =(p.cage.sign %leeche-effect)
      =/  new  !<(effect:pals q.cage.sign)
      ?+    -.new  that
          %near
        that(leeches (~(put in leeches) ship.new))
      ::
          %away
        that(leeches (~(del in leeches) ship.new))
      ==
    ==
  ::
      [%targets ~]
    ?+    -.sign  that
        %kick
      (emit target-card)
    ::
        %fact
      ?>  =(p.cage.sign %target-effect)
      =/  new  !<(effect:pals q.cage.sign)
      ?+    -.new  that
          %meet
        that(targets (~(put in targets) ship.new))
      ::
          %part
        that(targets (~(del in targets) ship.new))
      ==
    ==
    ::
      [%enemies ~]
    ?+    -.sign  that
        %kick
      (emit enemy-card)
    ::
        %fact
      ?>  =(p.cage.sign %foes-update)
      =/  new  !<(update:foes q.cage.sign)
      ?+    -.new  that
          %accuse
        that(enemies (~(put in enemies) ship.new))
      ::
          %unaccuse
        that(enemies (~(del in enemies) ship.new))
      ==
    ==
  ==
::
++  load
  |=  =vase
  ^+  that
  ?>  ?=([%0 *] q.vase)
  that(state !<(state-0 vase))
--