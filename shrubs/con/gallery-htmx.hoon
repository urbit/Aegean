/@  gallery
/@  photo
:-  [%gallery %htmx]
|=  gal=gallery
|=  =bowl:neo
^-  manx
|^  view
  ::
++  view  
;div 
  ;+  new-name
  ;+  new-photo
  ;+  kids-view
==
::
++  new-name
;form.fc.p2
  =hx-post  "/neo/hawk{(en-tape:pith:neo here.bowl)}?stud=gallery-diff"
  =hx-trigger  "input changed delay:0.4s from:find textarea"
  =hx-swap  "none"
  ;textarea
    =placeholder  "gallery name"
    =is  "multiline-input"
    =autocomplete  "off"
    =name  "name"
    ; {(trip name.gal)}
    ==
==
::
++  kids-view
  ;div.frw.wf
    =id  "kids-view"
  ;*  %+  turn  ~(tap by kids.bowl)
    |=  [=pith pail=pail:neo]
    =/  pic=photo  !<(photo +.pail)
    =/  pic-at  (trip (snag 0 (pout pith)))
    ~&  pic-at
    ;div
      =class  "p2 w-1/3"
      :: =hx-boost  "true"
      ;img.wf.ha 
        =hx-get      "{(en-tape:pith:neo (weld /neo/hawk here.bowl))}/{pic-at}"
        =hx-trigger  "click"
        =hx-target   "closest ha-wk"
        =hx-swap     "innerHTML"
        =src  (trip data.pic)
      ;
      ==
    ==
  ==

++  new-photo
  ;div
  ;form.fr.p2.wf
  =hx-post  "/neo/hawk{(en-tape:pith:neo here.bowl)}?stud=gallery-diff"
  =hx-on-submit  "this.reset()"
  =hx-target  "#kids-view"
  =hx-swap  "afterbegin"
  ;textarea
    =class  "bg-slate-50 border w-3/4"
    =placeholder  "add image"
    =is  "multiline-input"
    =autocomplete  "off"
    =name  "add-photo"
    ;
    ==
  ;date-now;
  ;button
    =class  "w-1/4"
    =type   "submit"
    ;  add
    ==
==
  ==
--