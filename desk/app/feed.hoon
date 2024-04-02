/-  *feed, pals, foes
/+  dbug, default-agent, *feed-ref, schooner, server
/*  ui  %html  /app/feed/html
/*  style-css  %css  /web/style/css
/*  htmx-js  %js  /web/htmx/js
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
      =locker
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
  ::
  |=  =cage
  ^-  (quip card _this)
  =^  cards  state  abet:(poke:hc cage)
  [cards this]
::
++  on-peek
  ::
  |=  =path
  ^-  (unit (unit cage))
  [~ ~]
::
++  on-agent
  ::
  |=  [=wire =sign:agent:gall]
  ^-  (quip card _this)
  =^  cards  state  abet:(agent:hc [wire sign])
  [cards this]
::
++  on-arvo
  ::
  |=  [=wire =sign-arvo]
  ^-  (quip card _this)
  =^  cards  state  abet:(arvo:hc [wire sign-arvo])
  [cards this]
::
++  on-watch
  ::
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
  |=  time=@da
  ^-  path
  [%g %x (scot %da time) %feed %$ ~]
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
      =/  r
        :*  our.bowl
            now.bowl
            dap.bowl
            %entry
        ==
      =/  p  (ref-to-path r)
      =.  that  (emit [%pass /growth %grow p [%entry entry.com]])
      =.  store  (~(put by store) r [~ entry.com])
      (broadcast [r hops.com])
    ==
  ==
::
++  handle-interaction
  |=  act=interaction
  ^+  that
  =/  r  (path-to-ref path.act)
  ?-    -.act
      %boost
    =.  boosts  (add-boost r)
    (tell-leeches [%praise r])
  ::
      %report
    ~&  >  'report poke'
    =/  paf  (weld (scry-prefix time.r) path.act)
    (emit [%pass /report %arvo %a %keen author.r paf])
  ::
      %save
    that(saved (~(put in saved) r))
  ::
      %hide
    that(hidden (~(put in hidden) r))
  ==
::
++  broadcast
  |=  =signal
  ^+  that
  ?:  =(hops.signal 0)
    that
  =/  h   ?:((gth hops.signal 2) 2 hops.signal)
  =/  sig  [ref.signal (dec h)]
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
    ?>  (lte hops.signal.msg 2)  :: reject hop hackers
    =/  paf  (weld (scry-prefix time.ref) (ref-to-path ref))
    =.  that  (emit [%pass /scry %arvo %a %keen author.ref paf])
    =.  store  (~(put by store) ref ~)
    (broadcast signal.msg)
  ::
      %praise
    that(boosts (add-boost ref.msg))
  ::
      %tattle
    that(locker (~(put by locker) evidence.msg now.bowl))
  ==
::
++  add-boost
  |=  =ref
  ^+  boosts
  %+  ~(put by boosts)
    ref
  =/  n  (~(get by boosts) ref)
  ?~  n
    `(map @p @da)`(malt (limo [src.bowl now.bowl]~))
  (~(put by (need n)) src.bowl now.bowl)
::
++  theme-dark
  ::
  %-  trip
  '''
  :root {
    --b0: #222;
    --b1: #333;
    --b2: #444;
    --b3: #555;
    --be: #752;
    --b-success: #351;
    --f1: #ccc;
    --f2: #999;
    --f3: #777;
    --f4: #555;
    --f-error: orange;
    --f-success: lightgreen;
    --link: lightblue;
    --hover:  115%;
  }
  '''
  ::
++  theme-light
  ::
  %-  trip
  '''
  :root {
    --f1: #333;
    --f2: #555;
    --f3: #777;
    --f4: #999;
    --f-error: #953;
    --f-success: #351;
    --b0: #eee;
    --b1: #ccc;
    --b2: #bbb;
    --b3: #888;
    --b-error: #ca8;
    --b-success: #8c8;
    --link: blue;
    --hover: 87%;
  }
  '''
  ::
++  theme-system
  ::
  """
  {theme-light}
  @media (prefers-color-scheme: dark) \{
  {theme-dark}
  }
  """
  ::
++  html-template
  ::
  |=  [title=tape body=manx]
  ^-  manx
  ;html
    ;head
      ;meta(charset "UTF-8");
      ;title: {title}
      ;meta
        =name  "viewport"
        =content
          """
          width=device-width,
          initial-scale=1.0,
          maximum-scale=1.0"
          """
        ;
      ==
      ;style: {(trip style-css)}
      ;style: {theme-system}
      ;script: {(trip htmx-js)}
    ==
    ;body.p3
      =style  "max-width: 700px; margin: 200px auto;"
      ;div
        ;+  body
      ==
    ==
  ==
  ::
::
++  form-new-post
  ::
  ;form.fc.g2
    =hx-post  "/apps/feed/submit"
    =hx-target  "main"
    =hx-swap  "outerHTML"
    ;textarea
      =class  "p3 br1 border wf"
      =rows  "5"
      =name  "text"
      =autocomplete  "off"
      =type  "text"
      =placeholder  "What's up?"
      =required  ""
      ;
    ==
    ;textarea
      =class  "p3 br1 border wf"
      =rows  "1"
      =name  "link"
      =autocomplete  "off"
      =type  "text"
      =placeholder  "url"
      ;
    ==
    ;button.p2.border.b2.hover.loader
      ;span.loaded: Submit
      ;span.loading: ...
    ==
  ==
  ::
++  handle-http
  ::
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
      %'POST'
    ?~  body.request.inbound-request  !!
    ?+    site
        (emil (flop (send [404 ~ [%plain "404 - Not Found"]])))
    ::
    ::    [%apps %feed ~]
    ::  =/  json  (de:json:html q.u.body.request.inbound-request)
    ::  =/  act  (dejs-interaction +.json)
    ::  =.  that  (handle-interaction act)
    ::  (emil (flop (send [200 ~ [%none ~]])))
    ::
        [%apps %feed %submit ~]
      =/  body
        ::
        %-  malt
        %+  fall
          %+  rush
            q:(fall body.request.inbound-request [p=0 q=''])
          yquy:de-purl:html
        ~
      =/  entry
        :*  %microblog
            `(~(got by body) 'text')
            ::
            =/  l  (~(get by body) 'link')
            ?~  l  ~
            `[%media %url (need l)]
            ::
            ~
            ~
        ==
      =/  r
        :*  our.bowl
            now.bowl
            dap.bowl
            %entry
        ==
      =/  p  (ref-to-path r)
      =.  that  (emit [%pass /growth %grow p [%entry entry]])
      =.  store  (~(put by store) r `entry)
      =.  that  (broadcast [r 1])
      %-  emil
      %-  flop
      %-  send
      :+  200  ~
      :-  %manx
      ;main.fc.g5
        ;+  form-new-post
        ;+  part-feed-list
      ==
    ::
    ==
    ::
      %'GET'
    %-  emil
    %-  flop
    %-  send
    ?+    site  [404 ~ [%plain "404 - Not Found"]]
    ::
        [%apps %feed ~]
      :+  200  ~
      :-  %manx
      %+  html-template  "feed"
      ;main.fc.g5
        ;+  form-new-post
        ;+  part-feed-list
      ==
    ::
    ::    [%apps %feed %json ~]
    ::  [200 ~ [%json (enjs-store [store hidden])]]
    ==  
  ==
::
++  part-feed-list
  ;div.fc.g4
    =id  "posts"
    ;*  %+  turn
          %-  sort-posts
          ~(tap by store)
        part-entry
  ==  
::
++  sort-posts
  |=  posts=(list [ref (unit entry)])
  ^-  (list [ref (unit entry)])
  %+  sort
    posts
  |=  [a=[=ref (unit entry)] b=[=ref (unit entry)]]
  (gth time.ref.a time.ref.b)
::
++  arvo
  ::
  |=  [=wire =sign-arvo]
  ^+  that
  ?+    wire  that
      [%scry ~]
    ?+    sign-arvo  that
        [%ames %tune *]
      =/  =roar:ames  (need roar.sign-arvo)
      ::  roar is a [dat=[p=/ q=~] syg=~]
      ::  %tune's return includes three additional knots
      ::  on top of scry-prefix's return value.
      =/  prefix-length  (add (lent (scry-prefix now.bowl)) 3)  
      =/  =path  (oust [0 prefix-length] p.dat.roar)
      =/  =ref  (path-to-ref path)
      =/  c=(cask)  (need q.dat.roar)
      ::  c should be a [%entry *]
      =/  =entry  ;;(entry +.c)
      that(store (~(put by store) ref [~ entry]))
    ==
    ::
      [%report ~]
    ?+    sign-arvo  that
        [%ames %tune *]
      ~&  >  'got tune'
      =/  =roar:ames  (need roar.sign-arvo)
      =/  prefix-length  (add (lent (scry-prefix now.bowl)) 3)  
      =/  =path  (oust [0 prefix-length] p.dat.roar)
      =/  =ref  (path-to-ref path)
      =/  c=(cask)  (need q.dat.roar)
      =/  =entry  ;;(entry +.c)
      =/  =proof  [%disavow ref syg.roar entry]
      ~&  >  'made proof'
      ::
      =/  life  .^(@ud %j /=life=/(scot %p our.bowl))
      ~&  >  'got life'
      =/  key   .^(@uw %j /=vein=/(scot %ud life))
      ~&  >  'got key'
      =/  crub  (nol:nu:crub:crypto key)
      ~&  >  'made crub'
      =/  oath  (sigh:as:crub (jam proof))
      ~&  >  'made oath'
      =/  sig   
        `signature`(malt (limo [our.bowl [life oath]]~))
      ~&  >  'made signature'
      ::
      =/  evidence  [sig proof]
      =.  locker  (~(put by locker) evidence now.bowl)
      (tell-leeches [%tattle evidence])
    ==
  ==
::
++  part-entry
  |=  [=ref e=(unit entry)]
  ^-  manx
  =/  entry  (need e)
  =/  t  (yore time.ref)
  ::  [[a=%.y y=2.014] m=6 t=[d=6 h=21 m=9 s=15 f=~[0xa16]]]
  =/  tim  
    ;:  weld
      (scow %ud m.t)
      "/"
      (scow %ud d.t.t)
      " "
      (scow %ud h.t.t)
      ":" 
      (y-co:co m.t.t)
    ==
  ?-    -.entry 
      %flexnote
    =/  f  flexnote.entry
    ;div.p3.br1.border.fc.g2
      =style  (weld "background-color:" (trip (fall background-color.f '#aabbcc')))
      ;p.s4.p1: {(trip event.f)}
      ;p.p1: {(trip (fall author.f ''))}
    ==
  ::
      %microblog
    =/  m  microblog.entry
    ;div.p3.br1.border.fc.g2
      ;p: {(trip (fall text.m 'n/a'))}
      ;div.fr.jb.f3
        ;p: {(scow %p author.ref)}
        ;p: {tim}
      ==
      ::
      ;+  ?~  link.m  ;/("")
      =/  link  (need link.m)
      ?+    -.link  ;/("")
          %media
        ?-    -.media.link
            %scry  ;/("")
            ::
            %url
          ;img.block.ma
            =style  "max-height: 300px; width: fit-content;"
            =src  (trip url.media.link)
            ;
          ==
        ==
      ==
    ==
  ==
::
++  agent
  ::
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
  ::
  |=  =vase
  ^+  that
  ?>  ?=([%0 *] q.vase)
  that(state !<(state-0 vase))
--
