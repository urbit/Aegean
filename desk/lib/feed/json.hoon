/-  *feed
|%
++  enjs-store
  |=  =store
  ^-  json
  %-  pairs:enjs:format
  %+  turn
    ~(tap by store)
  |=  [=ref val=(unit entry)]
  :-  (spat ref)
  ?~  val  ~
  (enjs-entry [ref (need val)])
::
++  enjs-entry
  |=  [=ref =entry]
  ^-  json
  =/  author  -.ref
  =/  date=@da  (need (slaw %da +<.ref))
  ::  =/  desk  +>-.ref 
  %-  pairs:enjs:format
  :~  [%author [%s author]]
      [%time (time:enjs:format date)]
      ::  [%desk [%s desk]]
      ::
      :-  %text
      ?~  text.entry  ~
      [%s (need text.entry)]
      ::
      :-  %quote
      ?~  quote.entry  ~
      [%s (spat (need quote.entry))]
      ::
      :-  %tags
      :-  %a
      %+  turn
        ~(tap in tags.entry)
      |=  tag=@ta  [%s tag]
      ::
      ::  Only handling [%media %url @t] for now
      :-  %link
      ?~  link.entry  ~
      =/  rich  (need link.entry)
      ?-    -.rich
          %preview
        ~
          %media
        ?-    -.media.rich
            %url
          [%s url.media.rich]
            %scry
          ~
        ==
      ==
  ==
::
++  dejs-interaction
  |=  =json
  ^-  interaction
  %.  json
  %-  of:dejs:format
  :~  [%boost pa:dejs:format]
      [%report pa:dejs:format]
      [%save pa:dejs:format]
      [%hide pa:dejs:format]
  ==
--