
-- Import block breaks
INSERT INTO prism_actions (action_time, action_type, player, world, x, y, z, data)
SELECT FROM_UNIXTIME(`co_blocks`.time), 
'block-break', 
`co_blocks`.user, 
(CASE `co_blocks`.wid WHEN 1 THEN "world" ELSE (CASE `co_blocks`.wid WHEN 2 THEN "world_nether" ELSE "world_the_end" END) END), 
SUBSTRING_INDEX( `co_blocks`.bcords , '.', 1 ), 
SUBSTRING_INDEX(SUBSTRING_INDEX( `co_blocks`.bcords , '.', 2 ),'.',-1), 
SUBSTRING_INDEX(SUBSTRING_INDEX( `co_blocks`.bcords , '.', -2 ),'.',1), 
CONCAT(CONCAT(CONCAT(CONCAT("{\"block_id\":", "", `co_blocks`.type), "", ",\"block_data\":"), "", `co_blocks`.data), "", "}")
FROM `co_blocks`
WHERE (`co_blocks`.user NOT LIKE '%#%') AND (`co_blocks`.action = 0) ORDER BY id ASC;

-- Import block placements
INSERT INTO prism_actions (action_time, action_type, player, world, x, y, z, data)
SELECT FROM_UNIXTIME(`co_blocks`.time), 
'block-place', 
`co_blocks`.user, 
(CASE `co_blocks`.wid WHEN 1 THEN "world" ELSE (CASE `co_blocks`.wid WHEN 2 THEN "world_nether" ELSE "world_the_end" END) END), 
SUBSTRING_INDEX( `co_blocks`.bcords , '.', 1 ), 
SUBSTRING_INDEX(SUBSTRING_INDEX( `co_blocks`.bcords , '.', 2 ),'.',-1), 
SUBSTRING_INDEX(SUBSTRING_INDEX( `co_blocks`.bcords , '.', -2 ),'.',1), 
CONCAT(CONCAT(CONCAT(CONCAT("{\"block_id\":", "", `co_blocks`.type), "", ",\"block_data\":"), "", `co_blocks`.data), "", "}")
FROM `co_blocks`
WHERE `co_blocks`.user NOT LIKE '%#%' AND `co_blocks`.action = 0 ORDER BY id ASC;

-- Import explosions (tnt)
INSERT INTO prism_actions (action_time, action_type, player, world, x, y, z, data)
SELECT FROM_UNIXTIME(`co_blocks`.time), 
'tnt-explode', 
'TNT', 
(CASE `co_blocks`.wid WHEN 1 THEN "world" ELSE (CASE `co_blocks`.wid WHEN 2 THEN "world_nether" ELSE "world_the_end" END) END), 
SUBSTRING_INDEX( `co_blocks`.bcords , '.', 1 ), 
SUBSTRING_INDEX(SUBSTRING_INDEX( `co_blocks`.bcords , '.', 2 ),'.',-1), 
SUBSTRING_INDEX(SUBSTRING_INDEX( `co_blocks`.bcords , '.', -2 ),'.',1), 
CONCAT(CONCAT(CONCAT(CONCAT("{\"block_id\":", "", `co_blocks`.type), "", ",\"block_data\":"), "", `co_blocks`.data), "", "}")
FROM `co_blocks`
WHERE `co_blocks`.user LIKE '#tnt' AND `co_blocks`.action = 0 ORDER BY id ASC;

-- Import explosions
INSERT INTO prism_actions (action_time, action_type, player, world, x, y, z, data)
SELECT FROM_UNIXTIME(`co_blocks`.time), 
'creeper-explode', 
'Creeper', 
(CASE `co_blocks`.wid WHEN 1 THEN "world" ELSE (CASE `co_blocks`.wid WHEN 2 THEN "world_nether" ELSE "world_the_end" END) END), 
SUBSTRING_INDEX( `co_blocks`.bcords , '.', 1 ), 
SUBSTRING_INDEX(SUBSTRING_INDEX( `co_blocks`.bcords , '.', 2 ),'.',-1), 
SUBSTRING_INDEX(SUBSTRING_INDEX( `co_blocks`.bcords , '.', -2 ),'.',1), 
CONCAT(CONCAT(CONCAT(CONCAT("{\"block_id\":", "", `co_blocks`.type), "", ",\"block_data\":"), "", `co_blocks`.data), "", "}")
FROM `co_blocks`
WHERE `co_blocks`.user LIKE '#creeper' AND `co_blocks`.action = 0 ORDER BY id ASC;

-- Import vines growing
INSERT INTO prism_actions (action_time, action_type, player, world, x, y, z, data)
SELECT FROM_UNIXTIME(`co_blocks`.time), 
'block-form', 
'Vine', 
(CASE `co_blocks`.wid WHEN 1 THEN "world" ELSE (CASE `co_blocks`.wid WHEN 2 THEN "world_nether" ELSE "world_the_end" END) END), 
SUBSTRING_INDEX( `co_blocks`.bcords , '.', 1 ), 
SUBSTRING_INDEX(SUBSTRING_INDEX( `co_blocks`.bcords , '.', 2 ),'.',-1), 
SUBSTRING_INDEX(SUBSTRING_INDEX( `co_blocks`.bcords , '.', -2 ),'.',1), 
CONCAT(CONCAT(CONCAT(CONCAT("{\"block_id\":", "", `co_blocks`.type), "", ",\"block_data\":"), "", `co_blocks`.data), "", "}")
FROM `co_blocks`
WHERE `co_blocks`.user LIKE '#vine' AND `co_blocks`.action = 1 ORDER BY id ASC;

-- Import signs placed
INSERT INTO prism_actions (action_time, action_type, player, world, x, y, z, data)
SELECT FROM_UNIXTIME(`co_blocks`.time), 
'block-form', 
'Vine', 
(CASE `co_blocks`.wid WHEN 1 THEN "world" ELSE (CASE `co_blocks`.wid WHEN 2 THEN "world_nether" ELSE "world_the_end" END) END), 
SUBSTRING_INDEX( `co_blocks`.bcords , '.', 1 ), 
SUBSTRING_INDEX(SUBSTRING_INDEX( `co_blocks`.bcords , '.', 2 ),'.',-1), 
SUBSTRING_INDEX(SUBSTRING_INDEX( `co_blocks`.bcords , '.', -2 ),'.',1), 
CONCAT(CONCAT(CONCAT(CONCAT("{\"block_id\":", "", `co_blocks`.type), "", ",\"block_data\":"), "", `co_blocks`.data), "", "}")
FROM `co_blocks`
WHERE `co_blocks`.user LIKE '#vine' AND `co_blocks`.action = 1 ORDER BY id ASC;