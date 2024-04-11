:-  [%hoon %htmx]
|=  hon=@t
|=  =bowl:neo
=/  =name:neo
  [our here]:bowl
=/  =file:ford:neo
  (scan (trip hon) (rein:ford:neo name))
=/  src=wain
  (to-wain:format hon)
^-  manx
=<  apex
|%
::  XX: non-std
++  post-href
  |=  =post:neo
  ^-  path
  ?>  ?=(@ q.post)
  =/  dsk
    /neo/hawk/src/std
  %+  welp  dsk
  /[p.post]/[q.post]
::
++  apex
  ^-  manx
  ;div.scroll-x
    ;+  imports
    ;+  contents
  ==
++  imports
  ;div.p2
    ;div.p2.border.br1.fc.g2
      ;h4.bold: Protocols
      ;div.frw.g2
        ;*
        %+  turn  pro.file
        |=  =pro:ford:neo
        ^-  manx
        ;a.p2.br1.b1.hover
          =hx-get  (spud (post-href %pro stud.pro))
          =hx-target  "closest ha-wk"
          =hx-swap  "innerHTML"
          ; {<stud.pro>}
        ==
      ==
    ==
  ==
++  contents   
  ;code.pre.scroll-x.scroll-y.p2.block.mono
    ;* 
    %+  turn  src
    |=  lin=@t
    ;div: {(trip lin)}
  ==
--
