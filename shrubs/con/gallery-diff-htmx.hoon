/@  gallery-diff
:-  [%gallery-diff %htmx]
|=  =gallery-diff
|=  =bowl:neo
?-  -.gallery-diff
    %add-photo
    ::can't make clickable because of @da assign at time of creating
    ::need to change that da assign at the time of event 
    =/  pic-src  (trip data.photo.gallery-diff)
    ;div
      =class  "p2 w-1/3"
      ;img.wf.ha
        :: =hx-get  "{(en-tape:pith:neo (weld /neo/hawk here.bowl))}/{pic-at}"
        ::=hx-trigger  "click"
        ::=hx-target   "closest ha-wk"
        ::=hx-swap     "innerHTML"
        =src  pic-src
        ;
      ==
    ==
    ::
    %name  *manx
    ::
    %del-photo  *manx
==