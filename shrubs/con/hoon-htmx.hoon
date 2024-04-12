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
  ;div
    ;+  imports
    ;+  contents
  ==
++  imports
  ;div
    ;div
      ;h4: Protocols
      ;*  
      %+  turn  pro.file
      |=  =pro:ford:neo
      ^-  manx
      ;button
        =hx-get  (spud (post-href %pro stud.pro))
        =hx-target  "closest ha-wk"
        =hx-swap  "innerHTML"
        ; {<stud.pro>}
      ==
    ==
  ==
++  contents   
  ;code.pre
    ;* 
    %+  turn  src
    |=  lin=@t
    ;div: {(trip lin)}
  ==
--
