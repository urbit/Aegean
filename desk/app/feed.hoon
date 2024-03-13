/-  *feed, pals
/+  dbug, default-agent
::
|%
::
+$  versioned-state  $%(state-0)
::
+$  state-0  
  $:
    leeches=(set ship)
    =store
    ::=saved
    ::=hidden
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
  [~ this]
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
  %-  emit
  ::  TO-DO  - subscribe to %foes too
  :*  %pass  /leeches  %agent
      [our.bowl %pals]  %watch  /leeches
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
++  handle-action
  |=  act=action
  ^+  that
  ?-    -.act
      %create
    ::  This should eventually take an [entry hops] and then grow a post.
    ::  For now, just say that we're taking a [post hops]
    =.  store  (~(put by store) post.act ~)
    =/  sig  [post.act hops.act]  :: redundant until this takes entry
    (broadcast sig)
  ==
::
++  handle-message
  |=  msg=message
  ^+  that
  ?-    -.msg
      %gossip
    :: TO-DO ?> on -.post so that author is not blocked
    ::  prevent malicious massive paths
    ?>  (lte 256 (met 3 (jam post)))
    =.  store  (~(put by store) post.signal.msg ~)
    ::  start thread(?) to attempt to download
    (broadcast signal.msg)
  ==
::
++  broadcast
  |=  =signal
  ^+  that
  ?:  =(hops.signal 0)
    that
  =/  sig  [post.signal (dec hops.signal)]
  %-  emil
  %+  turn
    ~(tap in leeches)
  |=  =ship
  ^-  card
  :*  %pass  /gossip
      %agent  [ship %feed]
      %poke  %feed-message  !>([%gossip sig])
  ==
::
++  agent
  |=  [=wire =sign:agent:gall]
  ^+  that
  ?+    wire  that
      [%leeches ~]
    ?+    -.sign  that
        %fact
      ?+    p.cage.sign  that
          %leeche-effect
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
  ==
::
++  load
  |=  =vase
  ^+  that
  ?>  ?=([%0 *] q.vase)
  that(state !<(state-0 vase))
--