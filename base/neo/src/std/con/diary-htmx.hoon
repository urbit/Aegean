/@  diary
:-  [%diary %htmx]
|=  dia=diary
|=  =bowl:neo
^-  manx
|^  shell
++  form-put-entry
  ::
  ;form.fc.g2
    =hx-post  "{(en-tape:pith:neo :(weld /neo/hawk here.bowl))}?stud=diary-diff"
    =hx-on-submit  "this.reset()"
    =hx-target  "this"
    =hx-swap  "afterend"
    =head  "put-entry"
    ;date-now;
    ;textarea.p2.border.br1
      =placeholder  ". . . text"
      =is  "multiline-input"
      =required  ""
      =autocomplete  "off"
      ;
    ==
    ;button.p2.b1.br1.wfc.hover
      ; create
    ==
  ==
  ::
++  link-entry
  ::
  |=  [pax=pith vax=vase]
  =/  tape  (trip !<(@t vax))
  =/  subject-end  (fall (find [10]~ tape) 56)
  =/  subject  (scag subject-end tape)
  =/  id  (trip (snag 0 (pout pax)))
  ;div.fr.g2
    ;button.p2.br1.grow.fr.g2.b1.hover
      =hx-get  "{(en-tape:pith:neo (weld /neo/hawk here.bowl))}/{id}"
      =hx-target  "closest ha-wk"
      =hx-swap  "innerHTML"
      ;span: {id}
      ;span.font-bold: {subject}
    ==
    ;button.p2.br1.fr.g2.b1.hover
      ; X
    ==
  ==
  ::
++  shell
  ::
  ;div.p2
    =label  "Diary"
    =here  (en-tape:pith:neo here.bowl)
    ;div.ma.fc.g2
      =style  "max-width: 650px;"
      ;+  form-put-entry
      ;*  (turn ~(tap by kids.bowl) link-entry)
    ==
  ==
--
