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
|_  =bowl:gall
+*  this  .
    def  ~(. (default-agent this %|) bowl)
::
++  on-init
  ^-  (quip card _this)
  :_  this(public %.n)
  :~  :*  %pass  /targets  %agent
          [our.bowl %pals]  %watch  /targets
      ==  
  ==
::
++  on-save
  ^-  vase
  !>(state)
::
++  on-load
  |=  old-state=vase
  ^-  (quip card _this)
  =/  old  !<(versioned-state old-state)
  ?-  -.old
    %0  `this(state old)
  ==
::
++  on-poke
  |=  =cage
  ^-  (quip card _this)
  ?>  =(src.bowl our.bowl)
  ?>  =(-.cage %foes-action)
  =/  act  !<(action +.cage)
  ?-    -.act
      %accuse
    :_  this(enemies (~(put by enemies) ship.act ~))
    [%give %fact ~[/enemies] %foes-update !>([%accuse ship])]~
  ::
      %unaccuse
    :_  this(enemies (~(del by enemies) ship.act))
    [%give %fact ~[/enemies] %foes-update !>([%unaccuse ship])]~
  ::
      %add-tag
    =-  `this(enemies (~(put by enemies) ship.act -))
    %.  tag.act
    %~  put  
      in
    (~(got by enemies) ship.act)
  ::
      %remove-tag
    =-  `this(enemies (~(put by enemies) ship.act -))
    %.  tag.act
    %~  del  
      in
    (~(got by enemies) ship.act)
  ::
      %switch-public
    ?:  =(public %.y)
      `this(public %.n)
    `this(public %.y)
  ==
::
++  on-agent
  |=  [=wire =sign:agent:gall]
  ^-  (quip card _this)
  ?+    wire  !!
      [%targets ~]
    ?+    -.sign  !!
        %fact
      ?+    p.cage.sign  !!
          %pals-effect
        =/  effect
          !<(effect:pals q.cage.sign)
        ?+    -.effect  !!
            %meet
          :_  this
          :~  :*  %pass  /accusations  %agent 
                  [ship.effect %foes]  %watch  /enemies
              ==
          ==
        ::
            %part
          :_  this
          =/  leave
            :*  %pass  /accusations  %agent
                [ship.effect %foes]  %leave  ~
            ==
          ?:  =(public %.y)
            [leave ~]
          [leave [%give %kick ~[/enemies] `ship.effect] ~]
        ==
      ==
    ==
  ::
      [%accusations ~]
    ?+    -.sign  !!
        %kick
      :_  this
      :~  :*  %pass  /accusations  %agent 
              [src.bowl %foes]  %watch  /enemies
          ==
      ==
      ::
        %fact
      ?>  =(p.cage.sign %foes-update)
      =/  upd  !<(update q.cage.sign)
      ?-    -.upd
          %accuse
        =-  `this(suspects (~(put by suspects) ship.upd -))
        %.  ship.upd
        %~  put  
          in
        (~(got by suspects) ship.upd)
        ::
          %unaccuse
        =-  `this(suspects (~(put by suspects) ship.upd -))
        %.  ship.upd
        %~  del  
          in
        (~(got by suspects) ship.upd)
      ==
    ==
  ==
::
++  on-watch
  |=  =path
  ^-  (quip card _this)
  ?+    path  !!
      [%enemies ~]
    ?>  ?|  =(public %.y)
        ::
            %.  src.bowl
            %~  has
              in
            .^((set @p) %gx /=pals=/targets)
        ==
    :_  this
    =/  cards
      %+  turn
        %~  tap  in
        ~(key by enemies)
      |=  =ship
      ^-  card
      [%give %fact ~[/enemies] %foes-update !>([%accuse ship])]
      ::
    ?:  (~(has by wex.bowl) [/accusations src.bowl %foes])
      cards 
    [[%pass /accusations %agent [src.bowl %foes] %watch /enemies] cards]
  ==
::
++  on-peek  on-peek:def
++  on-arvo  on-arvo:def
++  on-fail   on-fail:def
++  on-leave  on-leave:def
--