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
  ;div.fr.flex.flex-wrap
    =id  "kids-view"
  ;*  %+  turn  ~(tap by kids.bowl)
    |=  [=pith =vase]
    =/  pic=photo  !<(photo vase)
    ~&  pic
    ;div
      =class  "p2 flex-[0_0_32.3333%]"
      ;img 
        =src  (trip data.pic)
      ;
      ==
    ==
  ==
::
++  new-photo
  ;div
  ;form.fr.p2.wfc
  =hx-post  "/neo/hawk{(en-tape:pith:neo here.bowl)}?stud=gallery-diff"
  =hx-on-submit  "this.reset()"
  =hx-target  "#kids-view"
  =hx-swap  "afterbegin"
  ;textarea
    =class  "bg-slate-50 border w-3-4"
    =placeholder  "add image"
    =is  "multiline-input"
    =autocomplete  "off"
    =name  "add-photo"
    ;
    ==
  ;date-now;
  ;button
    =class  "w-1-4"
    =type  "submit"
    ;  add
    ==
==
  ==
--