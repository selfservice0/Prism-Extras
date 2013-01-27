-- PRISM Import Script
-- for CoreProtect
--
--
-- Run this script in your MySQL server console, or an application
-- that runs SQL queries, like phpMyAdmin, etc.
--

SET @world = "world";
SET @world_id = 1;


-- FOR DEV ONLY
TRUNCATE TABLE prism_actions;

-- block-break
INSERT INTO prism_actions (action_time, action_type, player, world, x, y, z, data)
  SELECT FROM_UNIXTIME(`co_blocks`.time), 'block-break', `co_blocks`.user, @world
    SUBSTRING_INDEX( `co_blocks`.bcords , '.', 1 ),
    SUBSTRING_INDEX(SUBSTRING_INDEX( `co_blocks`.bcords , '.', 2 ),'.',-1),
    SUBSTRING_INDEX(SUBSTRING_INDEX( `co_blocks`.bcords , '.', -2 ),'.',1),
    CONCAT('{"block_id":',`co_blocks`.type,',"block_subid":',`co_blocks`.data,'}')
  FROM `co_blocks`
  WHERE `co_blocks`.user NOT LIKE '%#%' AND (`co_blocks`.action = 0) AND co_blocks`.wid = @world_id;



