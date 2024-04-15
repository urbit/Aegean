::  %dns-stun
::    provides a public interface for finding your ship's domain
::
::
/*  style-css  %css  /lib/style/css
=-
::
=|  state-n
=*  state  -
^-  agent:gall
|_  =bowl:gall
  +*  this  .
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
        %-  (slog [leaf+"hawk: unknown mark {(trip mark)}" ~])
        `this
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
    `this
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
   ?+  -.wire  `this
     %thread
       ::
       ?+  -.sign  `this
         %poke-ack
           ::
           ?~  p.sign
             %-  (slog leaf+"fetching domain" ~)
             `this
           %-  (slog leaf+"Thread failed to start" u.p.sign)
             `this
         %fact
           ::
           ?+  p.cage.sign  !!
           %thread-fail
             =/  err  !<  (pair term tang)  q.cage.sign
             :_  this
             %^    http-cards
                 (rear `path`wire)
               ~
             %-  crip
             %-  en-xml:html
             ;div: {(trip p.err)}
             ::
           %thread-done
             =+  !<(url=@t q.cage.sign)
             :_  this
             (http-cards (rear `path`wire) ['HX-Redirect' url]~ '')
             ::
           ==
         ::
       ==
       ::
     ::
   ==
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
+$  state-n  *
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
    |=  [title=tape body=manx]
    ^-  manx
    =/  theme  'light'
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
        ;script(src "https://unpkg.com/htmx.org@1.9.11");
        ;style: {(trip style-css)}
        ;style: {colors}
      ==
      ;body
        =style  "max-width: 700px; margin: auto;"
        ;+  body
      ==
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
    =/  meth  method.request.q.req
    =/  body
      ::
      %-  malt
      %+  fall
        %+  rush
          q:(fall body.request.q.req [p=0 q=''])
        yquy:de-purl:html
      ~
    ::
    ?:  =(meth 'POST')
      ::
      =/  who  (slav %p (~(got by body) 'pat_p'))
      =/  tid  `@ta`(cat 3 'thread_' (scot %uv (sham eny.bowl)))
      =/  start-args  [~ `tid byk.bowl(r da+now.bowl) %sso !>(who)]
      :_  state
      :~
        [%pass /thread/[tid]/[p.req] %agent [our.bowl %spider] %watch /thread-result/[tid]]
        [%pass /thread/[tid]/[p.req] %agent [our.bowl %spider] %poke %spider-start !>(start-args)]
      ==
      ::
    ::  =(meth 'GET')
      ::
      :_  state
      %^    http-cards
          p.req
        ~
      %-  crip
      =-
        %+  weld  "<!DOCTYPE html>"
        %-  en-xml:html
        %+  doc  "dns stun"
        -
      ;form.ma
        =style  "width: 300px; margin-top: 200px;"
        =hx-post  "/dns-stun"
        ;label.fc.g1
          ;span: @p
          ;input.p2.br1.border
            =type  "text"
            =name  "pat_p"
            =autocomplete  "off"
            =placeholder  "~sampel-palnet"
            =pattern  (trip '~[a-z]{6}(-[a-z]{6})*')
            ;
          ==
          ;button.p2.br1.b1.f1.hover.loader
            ;span.loaded: login
            ;span.loading: ...
          ==
        ==
      ==
    ::
  --
--
::
