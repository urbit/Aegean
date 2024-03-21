::  /ted/sso/hoon
::
/-  spider
/+  *strandio
=,  strand=strand:spider
^-  thread:spider
|=  arg=vase
=/  m  (strand ,vase)
^-  form:m
=+  !<(=ship arg)
;<  =time  bind:m  get-time
=.  time  (sub time (mod time ~s10))
::
::  remote scry for eauth URL
;<  ~  bind:m  (keen /sso-eauth [ship /e/x/(scot %da time)//eauth/url])
::
::XX  fail if takes longer than 15s
;<  [* roar=(unit roar:ames)]  bind:m  (take-tune /sso-eauth)
?~  roar  (strand-fail:strand %no-response ~)
?~  data=q.dat.u.roar  (strand-fail:strand %no-data ~)
::
=/  tune  ((soft (unit @t)) q.u.data)
?~  tune  (strand-fail:strand %no-url ~)
::
=/  eauth-url  (trip (need u.tune))
=/  url=cord  (crip (scag (sub (lent eauth-url) 8) eauth-url))
(pure:m !>(url))
::
