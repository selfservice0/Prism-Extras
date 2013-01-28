
DECLARE @world TABLE ( id int, name VARCHAR(13) ); -- We'll just make a table to get the world by it's id to avoid messy CASE code.
INSERT INTO @world (id, name) VALUES (1, "world"); -- If you are a user, you can change these world names to your world names. If you use
INSERT INTO @world (id, name) VALUES (2, "world_nether"); -- the default world names, you can leave this as-is.
INSERT INTO @world (id, name) VALUES (3, "world_the_end"); -- You can add more of these lines with more names if you have more than 3 worlds.

-- Import block breaks and placements
INSERT INTO prism_actions (action_time, action_type, player, world, x, y, z, data) -- The stuff
	SELECT FROM_UNIXTIME(`co_blocks`.time), -- Time
		CASE `co_blocks`.action = 0 THEN 'block-break' ELSE 'block-place' END, -- Action type
		`co_blocks`.user, -- Username.
		SELECT name FROM @world WHERE id=`co_blocks`.wid,  -- The world. At the moment we just have 1=world, 2=world_nether, 3=world_the_end
		SUBSTRING_INDEX( `co_blocks`.bcords , '.', 1 ), -- This will get the X coordinate of this action
		SUBSTRING_INDEX(SUBSTRING_INDEX( `co_blocks`.bcords , '.', 2 ),'.',-1), -- Y coordinate
		SUBSTRING_INDEX(SUBSTRING_INDEX( `co_blocks`.bcords , '.', -2 ),'.',1), -- Z
		CONCAT("{\"block_id\":", `co_blocks`.type, ",\"block_data\":", `co_blocks`.data, "}")
	FROM `co_blocks`
	WHERE (`co_blocks`.user NOT LIKE '%#%') AND (`co_blocks`.action < 2 ) ORDER BY id ASC;

-- Import explosions (tnt)
INSERT INTO prism_actions (action_time, action_type, player, world, x, y, z, data)
	SELECT FROM_UNIXTIME(`co_blocks`.time), 
		'tnt-explode', 
		'TNT', 
		SELECT name FROM @world WHERE id=`co_blocks`.wid,
		SUBSTRING_INDEX( `co_blocks`.bcords , '.', 1 ), 
		SUBSTRING_INDEX(SUBSTRING_INDEX( `co_blocks`.bcords , '.', 2 ),'.',-1), 
		SUBSTRING_INDEX(SUBSTRING_INDEX( `co_blocks`.bcords , '.', -2 ),'.',1), 
		CONCAT("{\"block_id\":", `co_blocks`.type, ",\"block_data\":", `co_blocks`.data, "}")
	FROM `co_blocks`
	WHERE `co_blocks`.user LIKE '#tnt' AND `co_blocks`.action = 0 ORDER BY id ASC;

-- Import explosions
INSERT INTO prism_actions (action_time, action_type, player, world, x, y, z, data)
	SELECT FROM_UNIXTIME(`co_blocks`.time), 
		'creeper-explode', 
		'creeper', 
		SELECT name FROM @world WHERE id=`co_blocks`.wid,
		SUBSTRING_INDEX( `co_blocks`.bcords , '.', 1 ), 
		SUBSTRING_INDEX(SUBSTRING_INDEX( `co_blocks`.bcords , '.', 2 ),'.',-1), 
		SUBSTRING_INDEX(SUBSTRING_INDEX( `co_blocks`.bcords , '.', -2 ),'.',1), 
		CONCAT("{\"block_id\":", `co_blocks`.type, ",\"block_data\":", `co_blocks`.data, "}")
	FROM `co_blocks`
	WHERE `co_blocks`.user LIKE '#creeper' AND `co_blocks`.action = 0 ORDER BY id ASC;

-- Import vines growing
INSERT INTO prism_actions (action_time, action_type, player, world, x, y, z, data)
	SELECT FROM_UNIXTIME(`co_blocks`.time), 
		'block-form', 
		'vine', 
		SELECT name FROM @world WHERE id=`co_blocks`.wid, 
		SUBSTRING_INDEX( `co_blocks`.bcords , '.', 1 ), 
		SUBSTRING_INDEX(SUBSTRING_INDEX( `co_blocks`.bcords , '.', 2 ),'.',-1), 
		SUBSTRING_INDEX(SUBSTRING_INDEX( `co_blocks`.bcords , '.', -2 ),'.',1), 
		CONCAT("{\"block_id\":", `co_blocks`.type, ",\"block_data\":", `co_blocks`.data, "}")
	FROM `co_blocks`
	WHERE `co_blocks`.user LIKE '#vine' AND `co_blocks`.action = 1 ORDER BY id ASC;

-- Import signs placed
INSERT INTO prism_actions (action_time, action_type, player, world, x, y, z, data)
	SELECT FROM_UNIXTIME(`co_signs`.time), 
		'sign-change', 
		`co_signs`.user, 
		SELECT name FROM @world WHERE id=`co_blocks`.wid,
		SUBSTRING_INDEX( `co_signs`.bcords , '.', 1 ), 
		SUBSTRING_INDEX(SUBSTRING_INDEX( `co_signs`.bcords , '.', 2 ),'.',-1), 
		SUBSTRING_INDEX(SUBSTRING_INDEX( `co_signs`.bcords , '.', -2 ),'.',1),
		-- {"lines":["1","2","3","4"],"sign_type"="SIGN_POST","facing"="NORTH"}  CO doesn't track the stuff like type and facing, so we just add that last part in.
		CONCAT("{\"lines\":[\"", `co_signs`.line1, "\",\"", `co_signs`.line2, "\",\"", `co_signs`.line3, "\",\"", `co_signs`.line4, "\"],\"sign_type\"=\"SIGN_POST\",\"facing\"=\"NORTH\"}")
	FROM `co_signs`
	WHERE 1=1 ORDER BY id ASC;
	
-- Enderman Pickup/place
	-- (CASE WHEN LEN(@str) > 0 THEN "yes" ELSE "no" END);
	-- Enderman-pickup/drop
INSERT INTO prism_actions (action_time, action_type, player, world, x, y, z, data)
	SELECT FROM_UNIXTIME(`co_blocks`.time)
		CASE WHEN `co_blocks`.action = 0 THEN 'enderman-pickup' ELSE 'enderman-drop' END,
		'enderman',
		SELECT name FROM @world WHERE id=`co_blocks`.wid,
		SUBSTRING_INDEX( `co_signs`.bcords , '.', 1 ), 
		SUBSTRING_INDEX(SUBSTRING_INDEX( `co_signs`.bcords , '.', 2 ),'.',-1), 
		SUBSTRING_INDEX(SUBSTRING_INDEX( `co_signs`.bcords , '.', -2 ),'.',1),
		CONCAT("{\"block_id\":", `co_blocks`.type, ",\"block_data\":", `co_blocks`.data, "}")
	FROM `co_blocks`
	WHERE (`co_blocks`.user LIKE '#enderman') AND (`co_blocks`.action < 2 ) ORDER BY id ASC;
