|%
+$  suspects  (map ship (set ship))
+$  enemies  (map ship (set tag))
+$  tag  @ta
+$  action  
  $%  [%accuse =ship]
      [%unaccuse =ship]
      [%add-tag =ship =tag]
      [%remove-tag =ship =tag]
      ::[%switch-public ~]
  ==
+$  update
  $%  [%accuse =ship]
      [%unaccuse =ship]
  ==
--