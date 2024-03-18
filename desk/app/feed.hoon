/-  *feed, pals, foes
/+  dbug, default-agent, feed-json, schooner, server
/*  ui  %html  /app/feed/html
::
|%
::
+$  versioned-state  $%(state-0)
::
+$  state-0  
  $:  %0
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
=|  state-0
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
  (emil [leech-card target-card enemy-card eyre-card ~])
::
++  eyre-card
  ^-  card
  :*  %pass  /eyre/connect  %arvo  %e 
      %connect  [~ /apps/feed]  %feed 
  ==
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
++  scry-prefix  
  ^-  path
  [%g %x ~.0 %feed %$ ~]
::
++  poke
  |=  [=mark =vase]
  ^+  that
  ?+    mark  that
      %feed-interaction
    ?>  =(our.bowl src.bowl)
    (handle-interaction (interaction !<(interaction vase)))
  ::
      %feed-message
    (handle-message (message !<(message vase)))
  ::
      %handle-http-request
    (handle-http !<([@ta =inbound-request:eyre] vase))
  ::
      %feed-command
    =/  com  (command !<(command vase))
    ?-    -.com
        %create
      =/  ref  /(scot %p our.bowl)/(scot %da now.bowl)/entry
      =.  that  (emit [%pass /growth %grow ref [%entry entry.com]])
      =.  store  (~(put by store) ref [~ entry.com])
      (broadcast [ref hops.com])
    ==
  ==
::
++  handle-interaction
  |=  act=interaction
  ^+  that
  ?-    -.act
      %boost
    =.  boosts  (update-mip boosts ref.act)
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
          ?!  (~(has in enemies) src.bowl)  :: block the author
      ==
  ?-    -.msg
      %receive
    =/  ref  ref.signal.msg
    ::?>  (lte 256 (met 3 (jam ref))) :: no huge refs
    =/  author=@p  (need (slaw %p -.ref))
    =/  paf  (weld scry-prefix ref)
    =.  that  (emit [%pass /scry %arvo %a %keen author paf])
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
++  handle-http
  |=  [eyre-id=@ta =inbound-request:eyre]
  ^+  that
  ?>  =(our.bowl src.bowl)
  =/  ,request-line:server
    (parse-request-line:server url.request.inbound-request)
  =+  send=(cury response:schooner eyre-id)
  ::
  ?+    method.request.inbound-request
    (emil (flop (send [405 ~ [%stock ~]])))
    ::
    ::  %'POST'
    ::?~  body.request.inbound-request  !!
    ::?+    site
    ::    (emil (flop (send [404 ~ [%plain "404 - Not Found"]])))
    ::::
    ::    [%apps %creator ~]
    ::  =/  json  (de:json:html q.u.body.request.inbound-request)
    ::  =/  act  (dejs-create-action +.json)
    ::  =.  that  (handle-create-action act)
    ::  (emil (flop (send [200 ~ [%none ~]])))
    ::==
    ::
      %'GET'
    %-  emil
    %-  flop
    %-  send
    ?+    site  [404 ~ [%plain "404 - Not Found"]]
    ::
        [%apps %feed ~]
      [200 ~ [%html ui]]
    ::
        [%apps %feed %json ~]
      [200 ~ [%json (enjs-store:feed-json store)]]
    ::
    ::    [%apps %creator @ ~]
    ::  =/  id  +14:site
    ::  =/  app
    ::    ^-  app:creator
    ::    (~(got by apps) id)
    ::  ?>  ?|  =(%.y published.app)
    ::          =(src.bowl our.bowl)
    ::      ==
    ::  =/  fe  ui.app
    ::  [200 ~ [%html fe]]
    ::
    ==  
  ==
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
      ::  %tune's return includes three additional knots
      =/  prefix-length  (add (lent scry-prefix) 3)  
      =/  p=path  (oust [0 prefix-length] p.dat.r)
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
      ?+    p.cage.sign  that
          %pals-effect
        =/  new  !<(effect:pals q.cage.sign)
        ?+    -.new  that
            %near
          that(leeches (~(put in leeches) ship.new))
        ::
            %away
          that(leeches (~(del in leeches) ship.new))
        ==
      ==
    ==
  ::
      [%targets ~]
    ?+    -.sign  that
        %kick
      (emit target-card)
    ::
        %fact
      ?+    p.cage.sign  that
          %pals-effect
        =/  new  !<(effect:pals q.cage.sign)
        ?+    -.new  that
            %meet
          that(targets (~(put in targets) ship.new))
        ::
            %part
          that(targets (~(del in targets) ship.new))
        ==
      ==
    ==
    ::
      [%enemies ~]
    ?+    -.sign  that
        %kick
      (emit enemy-card)
    ::
        %fact
      ?+    p.cage.sign  that
          %foes-update
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
  ==
::
++  load
  |=  =vase
  ^+  that
  ?>  ?=([%0 *] q.vase)
  that(state !<(state-0 vase))
--