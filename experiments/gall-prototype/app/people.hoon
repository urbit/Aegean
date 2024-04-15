/-  *people
/+  dbug, default-agent
::
|%
::
+$  versioned-state  $%(state-0)
::
+$  state-0  [%0 owned=rosters following=rosters]
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
  ::?>  =(src.bowl our.bowl)
  ::(peek:hc path)
::
++  on-agent
  |=  [=wire =sign:agent:gall]
  ^-  (quip card _this)
  `this
::
++  on-arvo
  |=  [=wire =sign-arvo]
  ^-  (quip card _this)
  `this
::
++  on-watch
  |=  =path
  ^-  (quip card _this)
  `this
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
  that
::
++  poke
  |=  =cage
  ^+  that
  ?+    -.cage  !!
      %people-action
    (handle-action !<(action +.cage))
  ==
::
++  handle-action
  |=  act=action
  ^+  that
  ?-    -.act
      %create
    ?>  =(src.bowl our.bowl)  
    that(owned (~(put by owned) id.act new-roster))
  ::
      %delete
    ?>  =(src.bowl our.bowl)  
    that(owned (~(del by owned) id.act))
  ::
      %invited
    :: TO-DO watch this path on src.bowl's ship and put in following
    that
  ::
      %blocked
    :: TO-DO unwatch this path on src.bowl's ship and maybe remove from following
    that
  ::
      %update
    (run-update update.act) 
  ==
::
++  new-roster
  ^-  roster
  [our.bowl ~ ~ %.n ~ ~]
::
++  run-update
  |=  =update
  =.  that  (give-op update)
  =.  that  (send-invites update)
  =-  that(owned -)
  %+  ~(put by owned)
    id.update
  %+  update-roster
    op.update
  (~(got by owned) id.update)
::
++  give-op
  |=  =update
  ^+  that
  %-  emit
  :*  %give  %fact 
      ~[/updates]  %people-update  ::TO-DO make this path specify the id
      !>(update)
  ==
::
++  send-invites
  |=  =update
  ^+  that
  ?+  -.op.update  that
    %add-admin          (invitation [ship.op.update id.update])
    %remove-admin       (blockitation [ship.op.update id.update])
    %add-subscriber     (invitation [ship.op.update id.update])
    %remove-subscriber  (blockitation [ship.op.update id.update])
  ==
::
++  invitation
  |=  [=ship =id]
  ^+  that
  %-  emit
  :*  %pass  /invites  %agent 
      [ship %people]
      %poke  %people-action
      !>([%invited id])
  ==
::
++  blockitation
  |=  [=ship =id]
  ^+  that
  %-  emit
  :*  %pass  /blocks  %agent 
      [ship %people]
      %poke  %people-action
      !>([%blocked id]) 
  ==
::
++  update-roster
  |=  [=op ros=roster]
  ^-  roster
  ?>  ?|  =(src.bowl our.bowl)
          ?&  (~(has in admins.ros) src.bowl)
              =(shared.ros %.y)
          ==  
      ==
  ?-    -.op
      %add-member 
    ros(members (~(put in members.ros) ship.op))
      %remove-member
    ros(members (~(del in members.ros) ship.op))
      %add-tag
    ros(tags (~(put in tags.ros) tag.op))
      %remove-tag
    ros(tags (~(del in tags.ros) tag.op))
      %set-shared
    ros(shared share.op)
      %add-admin
    ros(admins (~(put in admins.ros) ship.op))
      %remove-admin
    ros(admins (~(del in admins.ros) ship.op))
      %add-subscriber
    ros(admins (~(del in admins.ros) ship.op))
      %remove-subscriber
    ros(admins (~(del in admins.ros) ship.op))
  ==
::
::++  peek
::  |=  =path
::  ^-  (unit (unit cage))
::  ?+    path  [~ ~]
::      [%x %universe ~]
::    ``explorer-universe+!>(universe)
::  ==
::
++  load
  |=  =vase
  ^+  that
  ?>  ?=([%0 *] q.vase)
  that(state !<(state-0 vase))
--