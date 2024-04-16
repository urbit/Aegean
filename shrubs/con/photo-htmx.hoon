/@  photo
/@  comment
:-  [%photo %htmx]
|=  pic=photo
|=  =bowl:neo
^-  manx
|^  view
 ::
++  view
;div.wf
  ;img.wf.ha
    =src  (trip data.pic)
    ;
    ==
  ;+  new-comment
  ;+  kids-view
==
++  new-comment 
  ;form.fr.p2.wf
  =hx-post  "/neo/hawk{(en-tape:pith:neo here.bowl)}?stud=photo-diff"
  =hx-on-submit  "this.reset()"
  =hx-target  "#comment-view"
  =hx-swap  "afterbegin"
  ;textarea
    =class  "bg-slate-50 border w-3/4"
    =placeholder  "leave a comment"
    =is  "multiline-input"
    =autocomplete  "off"
    =name  "add-comment"
  ;
  ==
  ;button
    =class  "w-1/4"
    =type   "submit"
    ;  post
  ==
  ==
::
++  kids-view
    ;div.frw.wf
    =id  "comment-view"
    ;*  %+  turn  ~(tap by kids.bowl)
      |=  [=pith pail=pail:neo]
      ~&  >  ['pail-comment' pail]
      =/  com=comment  !<(comment +.pail)
      ~&  >>  ['pith' pith]
      ;div
        =class  "p2 w-1/3"
        ;p:(trip what.com)
        ==
  ==
--
