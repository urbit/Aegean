/@  chat
:-  [%chat %htmx]
|=  cat=chat
|=  =bowl:neo
^-  manx
|^  shell
  ::
++  form-title
  ::
  ;form.fr.g2
    =hx-post  "/neo/hawk{(en-tape:pith:neo here.bowl)}?stud=chat-diff"
    =hx-swap  "none"
    ;input.p2.border.br1.wf.grow
      =type  "text"
      =name  "title"
      =placeholder  "title"
      =is  "atom-input"
      ;
    ==
    ;button.p2.border.br1
      ; save
    ==
  ==
  ::
++  shell
  ::
  ;div.p2
    =label  "Chat: {(trip title.cat)}"
    =here  (en-tape:pith:neo here.bowl)
    ;div.ma.fc.g2
      =style  "max-width: 650px;"
      ;+  form-title
      ;h1.bold.s2: {(trip title.cat)}
      ;div.p2.fc.g1
        ;*  %+  turn  ~(tap in who.cat)
            |=  =ship
            ;span: {(scow %p ship)}
      ==
    ==
  ==
--
