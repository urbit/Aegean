::  zed : a gossiped microblog for the %pals network
::
::
/-  *zed
/+  gossip, default-agent
/+  icons
/*  style-css  %css  /lib/style/css
/*  htmx-js  %js  /lib/htmx/js
::/$  grab-convo  %noun  %convo
::
=-
::
%-  %+  agent:gossip
        [2 %mutuals %mutuals |]
      %-  ~(put by *(map mark $-(* vase)))
      stage+|=(n=* !>((stage n)))
      ::
=|  state-n
=*  state  -
^-  agent:gall
|_  =bowl:gall
  +*  this  .
      def   ~(. (default-agent this %|) bowl)
  ++  on-init
    ::
    :_  this
    [%pass /bind-site %arvo %e %connect [~ dap.bowl ~] dap.bowl]~
    ::
  ++  on-save
    ::
    !>(state)
    ::
  ++  on-load
    ::
    |=  old-state=vase
    ^-  (quip card _this)
    ?:  -:(mule |.(!<(state-n old-state)))
      =/  old  !<(state-n old-state)
      `this(state old)
    `this(state *state-n)
    ::
  ++  on-poke
    ::
    |=  [=mark =vase]
    ?+  mark
        %-  (slog [leaf+"zed: unknown mark {(trip mark)}" ~])
        `this
      %trim
        ::
        ?>  =(src our):bowl
        =/  n  !<(@ud vase)
        =.  fresh  (scag n fresh)
        %-  (slog [leaf+"trimmed down to {<n>} posts" ~])
        `this
        ::
      %entry
        ::
        ?>  =(src our):bowl
        =/  new-entry=entry  [0 our.bowl now.bowl !<(@t vase)]
        =/  new-convo=convo  [new-entry ~ ~]
        =/  new-stage=stage  [(~(put in *(set @p)) our.bowl) new-convo]
        =/  hash  (mug new-convo)
        =.  fresh  [[now.bowl hash] fresh]
        =.  store  (~(put by store) hash new-stage)
        :_  this
        :~
          (invent:gossip %stage !>(new-stage))
          [%pass /~/zed %agent [our.bowl %zed] %poke %list !>(1)]
        ==
        ::
      %boost
        ::
        ?>  =(src our):bowl
        =/  hash  !<(@ vase)
        =/  old-stage=stage  (~(got by store) hash)
        =.  whos.old-stage  (~(put in whos.old-stage) our.bowl)
        =.  store  (~(put by store) hash old-stage)
        :-  [(invent:gossip %stage !>(old-stage)) ~]
        =-  this(fresh -)
        =/  rumor=[when=@da what=@]  [when.me.what.old-stage hash]
        |-  ^+  fresh
        ?~  fresh  [rumor ~]
        ?:  (gte when.rumor -.i.fresh)
          ?:  =(rumor i.fresh)
            fresh
          [rumor fresh]
        [i.fresh $(fresh t.fresh)]
        ::
      %quote
        ::
        ?>  =(src our):bowl
        =/  x  !<([@ @t] vase)
        =/  new-entry=entry  [0 our.bowl now.bowl +.x]
        =/  old-stage=stage  (~(got by store) -.x)
        =/  old-convo=convo  what.old-stage
        =/  new-convo=convo  [new-entry [~ -.old-convo] +<.old-convo]
        =/  new-stage=stage  [(~(put in *(set @p)) our.bowl) new-convo]
        =/  hash  (mug new-convo)
        =.  fresh  [[when.me.old-convo hash] fresh]
        =.  store  (~(put by store) (mug new-convo) new-stage)
        :_  this
        :~
          (invent:gossip %stage !>(new-stage))
          [%pass /~/zed %agent [our.bowl %zed] %poke %list !>(1)]
        ==
        ::
      %list
        ::
        ?>  =(src our):bowl
        %-  %-  slog
            ^-  tang
            %-  zing
            %+  turn  (scag !<(@ud vase) fresh)
            |=  [when=@da hash=@]
            ^-  tang
            =/  b=stage  (~(got by store) hash)
            :~
              ''
              leaf+"{<whos.b>} {(scow %da when.me.what.b)}"
              what.me.what.b
              ''
            ==
        `this
        ::
      %handle-http-request
        ::
        =/  res
          %-  ~(res web [bowl state.this])
          !<((pair @ta inbound-request:eyre) vase)
        [cards.res this(state state.res)]
      ::
    ==
    ::
  ++  on-watch
    ::
    |=  =path
    ^-  (quip card _this)
    ?:  ?=([%http-response *] path)         [~ this]
    ::?:  &(=(/rumors path) =(our src):bowl)  [~ this]
    ?.  =(/~/gossip/source path)
      (on-watch:def path)
    :_  this
    %-  flop
    =|  n=@ud
    |-
    ?~  fresh  ~
    ?:  (gth n 25)  ~
    =/  togive  (~(got by store) hash.i.fresh)
    :-  [%give %fact ~ %stage !>(togive)]
    $(fresh t.fresh, n +(n))
    ::
  ++  on-leave
    ::
    |=(path `..on-init)
    ::
  ++  on-peek
    ::
    |=  =path
    ~
    ::
  ++  on-agent
   ::
   |=  [=wire =sign:agent:gall]
   ?:  =(/~/zed wire)  [~ this]
   ?>  =(/~/gossip/gossip wire)
   ?>  ?=(%fact -.sign)
   ?>  =(%stage p.cage.sign)
   =/  new-stage=stage  (stage !<(stage q.cage.sign))
   =/  hash  (mug what.new-stage)
   =/  old-stage=(unit stage)  (~(get by store) hash)
   =?  whos.new-stage  ?=(^ old-stage)  (~(uni in whos.new-stage) whos:(need old-stage))
   =.  store  (~(put by store) hash new-stage)
   :-  [%pass /~/zed %agent [our.bowl %zed] %poke %list !>(1)]~
   =-  this(fresh -)
   =/  rumor=[when=@da what=@]  [when.me.what.new-stage hash]
   |-  ^+  fresh
   ?~  fresh  [rumor ~]
   ?:  (gte when.rumor -.i.fresh)
     ?:  =(rumor i.fresh)
       fresh
     [rumor fresh]
   [i.fresh $(fresh t.fresh)]
   ::
  ++  on-arvo
    ::
    |=  [=wire =sign-arvo]
    `this
    ::
  ++  on-fail
    ::
    |=  [=term =tang]
    %-  (slog tang)
    `..on-init
    ::
--
::
|%
+$  card  card:agent:gall
::
+$  fresh  (list [when=@da hash=@])  ::  TODO prune
+$  store  (map hash=@ stage)
::  store  (map author=@p (map timestamp=@da stage))
+$  saved  (list hash=@)
+$  avoid  (set rule)
+$  snubs  (set ship)
::
+$  state-0  [=fresh =store =saved =avoid =snubs]
+$  state-n  $%(state-0)
::
++  http-cards
  ::
  |=  [id=@ta headers=(list [@t @t]) body=@t]
  =/  rath  [/http-response/[id]]~
  =/  page  (as-octs:mimes:html body)
  =/  status  (slav %ud (~(gut by (malt headers)) 'X-Status' '200'))
  :~
      [%give %fact rath %http-response-header !>([status headers])]
      [%give %fact rath %http-response-data !>(`page)]
      [%give %kick rath ~]
  ==
  ::
++  web
  |_  [=bowl:gall state=state-n]
  ::
  +*  that  .
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
  ++  doc
    ::
    |=  [title=tape theme=@t body=manx]
    ^-  manx
    ::=/  theme  'system'
    =/  colors
      ?:  =(theme 'light')  theme-light
      ?:  =(theme 'dark')  theme-dark
      theme-system
      ::
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
        ;script: {(trip htmx-js)}
        ;style: {(trip style-css)}
        ;style: {colors}
        ;script
          ;+  ;/  %-  trip
          '''
          function gid(id) {
            return document.getElementById(id);
          }
          '''
        ==
      ==
      ;body
        ;+  body
      ==
    ==
    ::
  ++  part-stage
    ::
    |=  b=stage
    =/  hash  (mug what.b)
    ;div.p2.fc.g1
      =style  "border-bottom: 0.5px solid var(--f3); padding-bottom:15px;"
      ;+  (part-entry me.what.b hash)
      ;+  ?~  mom.what.b  ;/("")
      ;div.p2.br1.fc.g1.b0.f1
        =style  "filter: invert(6%); margin: 5px;"
        ;+  (part-entry (need mom.what.b) hash)
        ;+  ?~  grandma.what.b  ;/("")
        ;div.p2.br1.b0.f1
          =style  "filter: invert(7%); margin: 5px;"
          ;+  (part-entry (need grandma.what.b) hash)
        ==
      ==
      ;div.fr.ja.ac.g2.p2
        ;+  ?:  (~(has in whos.b) our.bowl)
          ;div.p2.br1.f1.b0.fr.ac.jc.g2
            ;+  heart-filled.icons
            ; {<(lent ~(tap in whos.b))>}
          ==
        ;button.p2.br1.hover.f1.b0.fr.ac.jc.g2
          =hx-post  "/zed/boost/{(scow %ud hash)}"
          =hx-swap  "none"
          =title  "boost"
          ;+  heart.icons
          ; {<(lent ~(tap in whos.b))>}
        ==
        ;button.p2.br1.hover.f1.b0
          ;+  bookmark.icons
        ==
        ;+  ?~  grandma.what.b
          ;button.p2.br1.hover.f1.b0.fade
            =id  "btn-quote-{(scow %ud hash)}"
            =onclick
              """
              gid('extra-{(scow %ud hash)}')?.parentNode.classList.remove('open');
              gid('btn-extra-{(scow %ud hash)}')?.classList.remove('active');
              gid('quote-{(scow %ud hash)}').parentNode.classList.toggle('open');
              this.classList.toggle('active');
              """
            ;+  quote.icons
          ==
        ;div.p2.f3
          =style  "opacity: 0.5;"
          ;+  quote.icons
        ==
        ;button.p2.br1.hover.f1.b0.fade
          =id  "btn-extra-{(scow %ud hash)}"
          =onclick
            """
            gid('quote-{(scow %ud hash)}')?.parentNode.classList.remove('open');
            gid('btn-quote-{(scow %ud hash)}')?.classList.remove('active');
            gid('extra-{(scow %ud hash)}').parentNode.classList.toggle('open');
            this.classList.toggle('active');
            """
          ;+  elipses.icons
        ==
      ==
      ;div.expander
        ;div.expandable
          =id  "quote-{(scow %ud hash)}"
          ;form.fc.p2.g1
            =hx-post  "/zed/quote/{(scow %ud hash)}"
            ;+  (part-textbox "well ackchyually...")
          ==
        ==
      ==
      ;div.expander
        ;div.expandable
          =id  "extra-{(scow %ud hash)}"
          ;div.p3
            ;button.hover.b2.f1.p2.br1: Report
          ==
        ==
      ==
    ==
  ++  part-textbox
    ::
    |=  placeholder=tape
    ;div.fc.g1
      ;textarea.p2.border.br1
        =style  "line-height:1.3;"
        =placeholder  placeholder
        =autocomplete  "off"
        =rows  "3"
        =oninput
          """
          this.rows = Math.max(3, this.value.split('\\n').length);
          this.parentNode.querySelector('.chars').textContent = this.value.length;
          """
        =required  "true"
        =name  "data"
        ;
      ==
      ;div.fr.jb.as
        ;button.b1.f1.p2.br1.hover.border.wfc: post
        ;span.chars.s-1.f2.p1
          ; 0
        ==
      ==
    ==
    ::
  ++  part-entry
    ::
    |=  [e=entry hash=@]
    ;div.br1.p1.fc.g2
      ;div.fr.jb.ac.f2
        ;a.p1.hover.f2.b0.br1.s-1
          =href  "/zed/profile/{(scow %p who.e)}"
          ;span: {(scow %p who.e)}
        ==
        ;a.p1.hover.f2.b0.br1.s-1
          =href  "/zed/{(scow %ud hash)}"
          ;span
            ;+  ;/
              =+  
              (scow %dr (sub now.bowl when.e))
            (scag (sub (max (lent -) 9) 6) -)
          ==
        ==
      ==
      ;p.pre-line: {(trip what.e)}
    ==
    ::
  ++  res
    ::
    |=  req=(pair @ta inbound-request:eyre)
    ^-  [cards=(list card) state=state-n]
    ::
    =/  purl  ::  parsed url with query params
      ::
      ^-  [pax=path pam=(map @t @t)]
      =+  %+  rash  url.request.q.req
          ;~  plug
              ;~(pfix fas (more fas smeg:de-purl:html))
              yque:de-purl:html
          ==
      [->.- (molt +.-)]
      ::
    ::
    ::  if trailing slash, redirect to sans-slash
    ?:  &((gth (lent pax.purl) 0) =(~ (rear pax.purl)))
      ::
      :_  state
      %^    http-cards
          p.req
        :~  ['X-Status' '307']
            ['Location' (spat [dap.bowl (snip pax.purl)])]
        ==
      ''
    ::
    ?:  ::  if unauthenticated, redirect to login
      ::
      !authenticated.q.req
      =/  redir  (crip "/~/login?redirect={(spud [dap.bowl pax.purl])}")
      :_  state
      (http-cards p.req [['X-Status' '307'] ['Location' redir] ~] '')
      ::
    ::
    =/  body  ::  parsed form-encoded body
      ::
      %-  malt
      %+  fall
        %+  rush
          q:(fall body.request.q.req [p=0 q=''])
        yquy:de-purl:html
      ~
    =/  pams  ::  combined params from purl, body, & headers
      ::
      %-  ~(uni by (malt header-list.request.q.req))
      (~(uni by pam.purl) body)
      ::
    =/  meth  ::  aesthetic-ized request method
      ::
      ?+  method.request.q.req  'get'
      %'GET'     'get'
      %'POST'    'pos'
      %'DELETE'  'del'
      %'PATCH'   'pat'  :: still doesn't work. devs do something!
      %'PUT'     'put'
      ==
      ::
    ::
    =/  res
      (~(htmx web [bowl state]) [[meth pax.purl] (~(uni by pam.purl) body)])
      ::
    :_  sate.res
      %+  welp
        xtra:res
      %:  http-cards
        p.req
        heds:res
        %-  crip
        %+  welp  (trip (~(gut by (malt heds:res)) 'X-Directive' ''))  ::  add any XML directives
        (en-xml:html frag:res)
      ==
      ::
  ++  htmx
    ::
    |=  req=[pax=path pam=(map @t @t)]
    ^-  [sate=state-n heds=(list [@t @t]) xtra=(list card) frag=manx]
    ::
    ?:  ?=([%pos %quote * ~] pax.req)
      ::
      =/  hash  (fall (slaw %ud (snag 2 `path`pax.req)) 0)
      =/  b  (~(get by store.state) hash)
      =/  data  (~(got by pam.req) 'data')
      :^    state
          ['HX-Location' '/zed']~
        [%pass /~/zed %agent [our.bowl %zed] %poke %quote !>([hash data])]~
      ;div;
      ::
    ?:  ?=([%pos %entry ~] pax.req)
      ::
      =/  data  (~(got by pam.req) 'data')
      :^    state
          ['HX-Location' '/zed']~
        [%pass /~/zed %agent [our.bowl %zed] %poke %entry !>(data)]~
      ;div;
      ::
    ?:  ?=([%pos %boost * ~] pax.req)
      ::
      =/  hash  (fall (slaw %ud (snag 2 `path`pax.req)) 0)
      :^    state
          ['HX-Location' '/zed']~
        [%pass /~/zed %agent [our.bowl %zed] %poke %boost !>(hash)]~
      ;div;
      ::
    ?:  ?=([%get * ~] pax.req)
      ::
      =/  hash  (fall (slaw %ud (snag 1 `path`pax.req)) 0)
      =/  b  (~(get by store.state) hash)
      :^  state  ~  ~
      %^  doc  "test"  'light'
      ;div.p2.fc.g4.ma
        =style  "max-width: 700px; padding-top:50px; padding-bottom:50px;"
        ;a.b2.f1.p2.br2.hover.wfc.border/"/zed": back
        ;main.fc
          ;+  ?~  b
            ;/  "not found"
          (part-stage (need b))
        ==
      ==
      ::
    ?:  ?=([%get ~] pax.req)
      ::
      :^  state  ~  ~
      %^  doc  "test"  (~(gut by pam.req) 'theme' 'system')
      ;div.p2.fc.g2.ma
        =style  "max-width: 700px; padding-top:50px; padding-bottom:50px;"
        ;form.br1.fc.g1
          =style  "margin: 30px 0 40px 0;"
          =hx-post  "/zed/entry"
          =hx-target  "main"
          =hx-swap  "afterbegin"
          ;+  (part-textbox "what's up?")
        ==
        ;main.fc.g4
          ;*  %:  turn  (scag 20 fresh.state)
            |=  [when=@da hash=@]
            (part-stage (~(got by store.state) hash))
          ==
        ==
      ==
      ::
    ::
    ::  fallback
      ::
      :^  state  ~  ~
      ;div: unknown
  --
--
::
