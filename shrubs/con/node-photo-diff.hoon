/@  node
/@  photo-diff
:-  [%node %photo-diff]
|=  nod=node
^-  photo-diff
=/  diff  `@tas`(crip (~(got by (malt a.g:(snag 0 c.nod))) %name))
?>  ?=(?(%add-comment %del-comment) diff)
?-  diff
    %add-comment  
  =/  what=@t  (crip (~(got by (malt a.g:(snag 0 c.nod))) %value))
  [diff what]
  ::
    %del-comment  [diff *@p *@da]
==