
-- PRISM Import Script
-- for LOGBLOCK
--
--
-- Run this script in your MySQL server console, or an application
-- that runs SQL queries, like phpMyAdmin, etc.
--
-- LogBlocks stores data in a different table per world.
-- Please change the following world name for every world
-- you wish to import. For example, 'world_nether', etc.

SET @world = 'world';


-- DO NOT edit below this line.

-- TEMP ONLY, for dev
TRUNCATE TABLE prism_actions;

-- block-break
INSERT INTO prism_actions (action_time,action_type,player,world,x,y,z,data)
  SELECT `lb-world`.date, "block-break", `lb-players`.playername, @world, `lb-world`.x, `lb-world`.y, `lb-world`.z, CONCAT('{"block_id":',`lb-world`.type,',"block_subid":',`lb-world`.data,'}')
  FROM `lb-world`
  JOIN `lb-players` ON `lb-players`.playerid = `lb-world`.playerid
  WHERE `lb-world`.type = 0;

-- block-place
INSERT INTO prism_actions (action_time,action_type,player,world,x,y,z,data)
  SELECT `lb-world`.date, "block-place", `lb-players`.playername, @world, `lb-world`.x, `lb-world`.y, `lb-world`.z, CONCAT('{"block_id":',`lb-world`.type,',"block_subid":',`lb-world`.data,'}')
  FROM `lb-world`
  JOIN `lb-players` ON `lb-players`.playerid = `lb-world`.playerid
  WHERE `lb-world`.replaced IN (0, 8, 9, 10, 11);

-- leaf-decay
INSERT INTO prism_actions (action_time,action_type,player,world,x,y,z,data)
  SELECT `lb-world`.date, "leaf-decay", `lb-players`.playername, @world, `lb-world`.x, `lb-world`.y, `lb-world`.z, CONCAT('{"block_id":',`lb-world`.type,',"block_subid":',`lb-world`.data,'}')
  FROM `lb-world`
  JOIN `lb-players` ON `lb-players`.playerid = `lb-world`.playerid
  WHERE `lb-world`.replaced = 18;