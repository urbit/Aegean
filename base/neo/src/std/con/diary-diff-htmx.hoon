/@  diary-diff
:-  [%diary-diff %htmx]
|=  =diary-diff
|=  =bowl:neo
?-  -.diary-diff
    %put-entry
  =/  tape  (trip txt.diary-diff)
  =/  subject-end  (fall (find [10]~ tape) 56)
  =/  subject  (scag subject-end tape)
  =/  id  (scow %da id.diary-diff)
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
    %del-entry
  ;div: deled
==
