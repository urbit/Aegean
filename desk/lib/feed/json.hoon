/-  *feed
|%
++  enjs-store
  |=  =store
  ^-  json
  %-  pairs:enjs:format
  %+  turn
    ~(tap by store)
  |=  [=ref val=(unit entry)]
  :-  (concatenate ref)
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
      [%s (concatenate (need quote.entry))]
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
++  concatenate
  |=  =ref
  ^-  @t
  =/  author  -.ref
  =/  date  +<.ref
  ::  =/  desk  +>-.ref 
  %-  crip
  ;:  weld
      (trip author)
      "/"
      (trip date)
      :: "/"
      :: (trip desk)
  ==
--