/@  sky
:-  [%sky %htmx]
|=  =sky
|=  =bowl:neo
^-  manx
|^
  shell
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
++  shell
  =/  theme  theme.sky
  =/  colors
    ?:  =(theme %light)  theme-light
    ?:  =(theme %dark)  theme-dark
    theme-system
    ::
  ;div.wf.b1(style "min-height: 100vh;")
    ;style: {colors}
    ;s-k-y.wf.hf(open "", hawks "0")
      ;*  %:  turn  ~(tap by kids:bowl)
        |=  [=pith =vase]
        ;ha-wk
          =hx-get  "/neo/hawk{(en-tape:pith:neo pith)}"
          =hx-trigger  "load"
          =hx-swap  "innerHTML"
          ;div.wf.hf.fc.jc.ac.f2
            ; loading . . .
          ==
        ==
      ==
    ==
  ==
--
