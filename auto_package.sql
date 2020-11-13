SELECT gs.wh_id
FROM sm_goods_store gs
INNER JOIN sm_goods g ON gs.goods_id = g.id
WHERE gs.central_wh_id = 126
  AND g.cat_id IN (3194,3196)
GROUP BY gs.wh_id;


SELECT
  gos.mchid,
  IF(gs.central_wh_id = 0, gs.wh_id, gs.central_wh_id) AS central_wh_id,
    gos.wh_id,
    gos.goods_id,
    g.sku,
    gos.current_date,
    gos.tomorrow_goods_num,
    g.rate_id,
    gs.is_auto_sorting,
    gs.efficiency,
    str.original_goods_id,
    sg.sku AS original_sku,
    sg.is_labeling
  FROM
    INNER JOIN sm_goods g ON gos.goods_id = g.id
    INNER JOIN sm_goods_store gs ON gos.goods_id = gs.goods_id AND gs.wh_id = gos.wh_id
  LEFT JOIN sm_sorting_task_rate str ON str.id = g.rate_id AND gs.is_auto_sorting = 1
  LEFT JOIN sm_goods sg ON sg.id = str.original_goods_id
WHERE
    gos.wh_id IN (126)
  AND g.cat_id in(3194, 3196) 
  AND gos.tomorrow_goods_num > 0 
  AND `current_date` = date_format(now(), '%Y-%m-%d');