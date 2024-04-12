/@  node
/@  gallery-diff
/@  photo
:-  [%node %gallery-diff]
|=  nod=node
^-  gallery-diff
~&  (snag 0 c.nod)
~&  (crip (~(got by (malt a.g:(snag 0 c.nod))) %name))
=/  diff  `@tas`(crip (~(got by (malt a.g:(snag 0 c.nod))) %name))
~&  >>  ['diff' diff]
?>  ?=(?(%name %add-photo %del-photo) diff)
?-  diff  
  %name
=/  new-name  (crip (~(got by (malt a.g:(snag 0 c.nod))) %value))
[%name new-name]
::
  %add-photo
=/  data=@t  (crip (~(got by (malt a.g:(snag 0 c.nod))) %value)) 
~&  (~(got by (malt a.g:(snag 0 c.nod))) %value)
::=/  date     (slav %da (crip (~(got by (malt a.g.id-el)) %value)))
=/  =photo  [*@da data]
[%add-photo photo]
:: 
  %del-photo
[%del-photo *@da]
==