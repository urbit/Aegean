/@  image-link
:-  [%image-link %node]
|=  =image-link
^-  manx
;div
  ;img.w-full.block
    =src  (trip (@t image-link))
    ;
  ==
  ;input.w-full.block.p-1.border.border-slate-400.rounded
    =type  "text"
    =value  (trip (@t image-link))
    ;
  ==
==
