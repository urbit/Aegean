|%
+$  rosters  (map =id =roster)
+$  id  @ta
+$  tag   @ta
+$  roster
  $:  owner=@p                :: source of truth
      tags=(set tag)          :: metadata for roster itself
      members=(set @p)        :: objects of roster
      shared=?                :: subs and admins enabled?
      admins=(set @p)         :: can modify roster
      subscribers=(set @p)    :: can sub to roster
  ==
+$  update  [=id =op]
+$  action  
  $%  [%create =id]
      [%delete =id]
      [%invited =id]  :: called remotely
      [%blocked =id]  :: called remotely
      [%update =update]
  ==
::
+$  op
  $%  [%add-member =ship]
      [%remove-member =ship]
      [%add-tag =tag]
      [%remove-tag =tag]
      [%set-shared share=?]
      [%add-admin =ship]
      [%remove-admin =ship]
      [%add-subscriber =ship]
      [%remove-subscriber =ship]
  ==
--