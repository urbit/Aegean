/-  *foes, pals
/+  dbug, default-agent
::
|%
::
+$  versioned-state  $%(state-0)
::
+$  state-0  [%0 =suspects =enemies public=?]
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
  `this
::
++  on-watch
  |=  =path
  ^-  (quip card _this)
  =^  cards  state  abet:(watch:hc path)
  [cards this]
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
  =.  public  %.n
  %-  emil
  :~  :*  %pass  /targets  %agent
          [our.bowl %pals]  %watch  /targets
      ==  
  ==
::
++  poke
  |=  =cage
  ^+  that
  ?>  =(src.bowl our.bowl)
  ?+    -.cage  !!
      %foes-action
    (handle-action !<(action +.cage))
  ==
::
++  accusation
  |=  =ship
  ^-  card
  [%give %fact ~[/enemies] %foes-update !>([%accuse ship])]
::
++  unaccusation
  |=  =ship
  ^-  card
  [%give %fact ~[/enemies] %foes-update !>([%unaccuse ship])]
::
++  handle-action
  |=  act=action
  ^+  that
  ?-    -.act
      %accuse
    =.  enemies  (~(put by enemies) ship.act ~)
    (emit (accusation ship.act))
  ::
      %unaccuse
    =.  enemies  (~(del by enemies) ship.act)
    (emit (unaccusation ship.act))
  ::
      %add-tag
    =-  that(enemies (~(put by enemies) ship.act -))
    %.  tag.act
    %~  put  
      in
    (~(got by enemies) ship.act)
  ::
      %remove-tag
    =-  that(enemies (~(put by enemies) ship.act -))
    %.  tag.act
    %~  del  
      in
    (~(got by enemies) ship.act)
  ::
      %switch-public
    ?:  =(public %.y)
      that(public %.n)
    that(public %.y)
  ==
::
++  follow
  |=  =ship
  ^-  card
  [%pass /accusations %agent [ship %foes] %watch /enemies]
::
++  unfollow
  |=  =ship
  ^-  card
  [%pass /accusations %agent [ship %foes] %leave ~]
::
++  agent
  |=  [=wire =sign:agent:gall]
  ^+  that
  ?+    wire  !!
      [%targets ~]
    ?+    -.sign  that
        %fact
      ?+    p.cage.sign  that
          %pals-effect
        =/  effect
          !<(effect:pals q.cage.sign)
        ?+    -.effect  that
            %meet
          (emit (follow ship.effect))
            %part
          =.  that  (emit (unfollow ship.effect))
          ?:  =(public %.y)
            that
          (emit [%give %kick ~[/enemies] `ship.effect])
        ==
      ==
    ==
  ::
      [%accusations ~]
    ?+    -.sign  !!
        %kick
      %-  emit
      (follow src.bowl)
      ::
        %fact
      ?>  =(p.cage.sign %foes-update)
      =/  upd  !<(update q.cage.sign)
      ?-    -.upd
          %accuse
        =-  that(suspects (~(put by suspects) ship.upd -))
        %.  ship.upd
        %~  put  
          in
        (~(got by suspects) ship.upd)
        ::
          %unaccuse
        =-  that(suspects (~(put by suspects) ship.upd -))
        %.  ship.upd
        %~  del  
          in
        (~(got by suspects) ship.upd)
      ==
    ==
  ==
::
++  watch
  |=  =path
  ^+  that
  ?+    path  that
      [%enemies ~]
    ?>  ?|  =(public %.y)
        ::
            %.  src.bowl
            %~  has
              in
            .^((set @p) %gx /=pals=/targets)
        ==
    %-  emil
    %+  weld
      ?:  (~(has by wex.bowl) [/accusations src.bowl %foes])
        ~
      [(follow src.bowl) ~]
    %+  turn
      %~  tap  in
      ~(key by enemies)
    |=  =ship
    (accusation ship)
  ==
::
++  load
  |=  =vase
  ^+  that
  ?>  ?=([%0 *] q.vase)
  that(state !<(state-0 vase))
--