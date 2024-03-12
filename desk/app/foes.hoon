:: %foes
::
:: Coded by ~hanfel-dovned
:: Designed by ~tiller-tolbus
:: 
:: A counterpart to %pals for identifying malicious users.
:: 
:: An enemy is someone you accuse.
:: A suspect is someone your mutual pal accuses.
:: 
:: You will tell your mutual pals about people you accuse,
:: and they'll flag them as suspects.
:: 
:: Your mutual pals will tell you about people they accuse,
:: and you'll flag them as suspects.
:: 
:: Scry Paths:
:: /x/enemies - Returns a (set ship) of all your enemies
:: /x/enemies/@p - Returns a (set tag) of your tags for that enemy
:: /x/suspects - Returns a (map ship (set ship)) of all suspects
:: /x/suspects/@p - Returns a (set ship) of all accused by that accuser
:: 
:: Subscription Paths:
:: /enemies - Pushes an %accuse or %unaccuse when you accuse or unaccuse someone
:: /suspects - Pushes a %suspected or %unsuspected when one of your pals accuses or unaccuses someone
::
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
      ?+    -.upd  !!
          %accuse
        :-  :~  :*  %give  %fact  ~[/suspects] 
                    %foes-update  !>([%suspected src.bowl ship.upd])
                ==  
            ==
        =-  this(suspects (~(put by suspects) src.bowl -))
        %.  ship.upd
        %~  put  
          in
        (~(got by suspects) src.bowl) 
        ::
          %unaccuse
        :-  :~  :*  %give  %fact  ~[/suspects] 
                    %foes-update  !>([%unsuspected src.bowl ship.upd])
                ==  
            ==
        =-  this(suspects (~(put by suspects) src.bowl -))
        %.  ship.upd
        %~  del  
          in
        (~(got by suspects) src.bowl)
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
  ::
      [%suspects ~]
    ?>  =(our.bowl src.bowl)
    :_  this
    %-  zing
    ^-  (list (list card))
    %+  turn
      ~(tap by suspects)
    |=  [accuser=ship accused=(set ship)]
    ^-  (list card)
    %+   turn
      ~(tap in accused) 
    |=  =ship
    ^-  card
    [%give %fact ~[/suspects] %foes-update !>([%suspected accuser ship])]
  ==
::
++  on-peek
  |=  =path
  ^-  (unit (unit cage))
  ?>  =(src.bowl our.bowl)
  ?+    path  !!
      [%x %enemies ~]  
    ``noun+!>(enemies)
  ::
      [%x %enemies @ ~]
    ``noun+!>((~(get by enemies) (need (slaw %p i.t.t.path))))
  ::
      [%x %suspects ~]
    ``noun+!>(suspects)
  ::
      [%x %suspects @ ~]
    ``noun+!>((~(get by suspects) (need (slaw %p i.t.t.path))))
  ==
::
++  on-arvo  on-arvo:def
++  on-fail   on-fail:def
++  on-leave  on-leave:def
--