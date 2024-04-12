/@  gallery-diff
:-  [%gallery-diff %htmx]
|=  =gallery-diff
|=  =bowl:neo
?-  -.gallery-diff
    %add-photo
    ::=/  pic-src  (trip data.photo.gallery-diff)
    ;div(class "flex-[0_0_33.3333%]")
      ;img 
        =src  (trip data.photo.gallery-diff)
      ;
      ==
    ==
    ::
    %name  *manx
    ::
    %del-photo  *manx
==