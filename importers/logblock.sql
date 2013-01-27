
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

-- @todo - use var properly in table names


-- During development, it appears that logblock does not track
-- the following events, which Prism does track:

-- block-fall
-- block-shift
-- bonemeal-use
-- container-access
-- crop-trample
-- entity-break
-- entity-follow
-- entity-kill
-- entity-spawn
-- entity-shear
-- fireball: true
-- hangingitem-break
-- hangingitem-place
-- item-drop
-- item-pickup
-- lava-ignite
-- lightning
-- player-command
-- player-join
-- player-quit
-- sheep-eat
-- spawnegg-use
-- tnt-prime

-- DO NOT edit below this line.

-- TEMP ONLY, for dev
TRUNCATE TABLE prism_actions;

-- block-break
INSERT INTO prism_actions (action_time,action_type,player,world,x,y,z,data)
  SELECT `lb-world`.date, "block-break", `lb-players`.playername, @world, `lb-world`.x, `lb-world`.y, `lb-world`.z, CONCAT('{"block_id":',`lb-world`.replaced,',"block_subid":',`lb-world`.data,'}')
  FROM `lb-world`
  JOIN `lb-players` ON `lb-players`.playerid = `lb-world`.playerid
  WHERE `lb-world`.type = 0
  AND `lb-players`.playername NOT IN ("Creeper","Fire","TNT","WaterFlow")

-- water-flow
INSERT INTO prism_actions (action_time,action_type,player,world,x,y,z,data)
  SELECT `lb-world`.date, "water-flow", "Water", @world, `lb-world`.x, `lb-world`.y, `lb-world`.z, '{"block_id":9,"block_subid":0}'
  FROM `lb-world`
  JOIN `lb-players` ON `lb-players`.playerid = `lb-world`.playerid AND `lb-players`.playername = "WaterFlow"
  WHERE `lb-world`.type IN (8,9) AND `lb-world`.replace = 0;

-- water-break
INSERT INTO prism_actions (action_time,action_type,player,world,x,y,z,data)
  SELECT `lb-world`.date, "water-break", "Water", @world, `lb-world`.x, `lb-world`.y, `lb-world`.z, CONCAT('{"block_id":',`lb-world`.replaced,',"block_subid":',`lb-world`.data,'}')
  FROM `lb-world`
  JOIN `lb-players` ON `lb-players`.playerid = `lb-world`.playerid AND `lb-players`.playername = "WaterFlow"
  WHERE `lb-world`.type IN (8,9);

-- lava-flow
INSERT INTO prism_actions (action_time,action_type,player,world,x,y,z,data)
  SELECT `lb-world`.date, "lava-flow", "Lava", @world, `lb-world`.x, `lb-world`.y, `lb-world`.z, '{"block_id":11,"block_subid":0}'
  FROM `lb-world`
  JOIN `lb-players` ON `lb-players`.playerid = `lb-world`.playerid AND `lb-players`.playername = "LavaFlow"
  WHERE `lb-world`.type IN (10,11) AND `lb-world`.replace = 0;

-- lava-break
INSERT INTO prism_actions (action_time,action_type,player,world,x,y,z,data)
  SELECT `lb-world`.date, "lava-break", "Lava", @world, `lb-world`.x, `lb-world`.y, `lb-world`.z, CONCAT('{"block_id":',`lb-world`.replaced,',"block_subid":',`lb-world`.data,'}')
  FROM `lb-world`
  JOIN `lb-players` ON `lb-players`.playerid = `lb-world`.playerid AND `lb-players`.playername = "LavaFlow"
  WHERE `lb-world`.type IN (10,11);

-- creeper-explode
INSERT INTO prism_actions (action_time,action_type,player,world,x,y,z,data)
  SELECT `lb-world`.date, "creeper-explode", "creeper", @world, `lb-world`.x, `lb-world`.y, `lb-world`.z, CONCAT('{"block_id":',`lb-world`.replaced,',"block_subid":',`lb-world`.data,'}')
  FROM `lb-world`
  JOIN `lb-players` ON `lb-players`.playerid = `lb-world`.playerid AND `lb-players`.playername = "Creeper"
  WHERE `lb-world`.type = 0;

-- tnt-explode
INSERT INTO prism_actions (action_time,action_type,player,world,x,y,z,data)
  SELECT `lb-world`.date, "creeper-explode", "tnt", @world, `lb-world`.x, `lb-world`.y, `lb-world`.z, CONCAT('{"block_id":',`lb-world`.replaced,',"block_subid":',`lb-world`.data,'}')
  FROM `lb-world`
  JOIN `lb-players` ON `lb-players`.playerid = `lb-world`.playerid AND `lb-players`.playername = "TNT"
  WHERE `lb-world`.type = 0;

-- block-place
INSERT INTO prism_actions (action_time,action_type,player,world,x,y,z,data)
  SELECT `lb-world`.date, "block-place", `lb-players`.playername, @world, `lb-world`.x, `lb-world`.y, `lb-world`.z, CONCAT('{"block_id":',`lb-world`.type,',"block_subid":',`lb-world`.data,'}')
  FROM `lb-world`
  JOIN `lb-players` ON `lb-players`.playerid = `lb-world`.playerid
  WHERE `lb-world`.replaced IN (0, 8, 9, 10, 11, 78);

-- tree-grow
INSERT INTO prism_actions (action_time,action_type,player,world,x,y,z,data)
  SELECT `lb-world`.date, "tree-grow", `lb-players`.playername, @world, `lb-world`.x, `lb-world`.y, `lb-world`.z, CONCAT('{"block_id":',`lb-world`.type,',"block_subid":',`lb-world`.data,'}')
  FROM `lb-world`
  JOIN `lb-players` ON `lb-players`.playerid = `lb-world`.playerid
  WHERE `lb-world`.type IN (17,18) AND `lb-world`.replace = 0;

-- @todo mushroom grow

-- leaf-decay
INSERT INTO prism_actions (action_time,action_type,player,world,x,y,z,data)
  SELECT `lb-world`.date, "leaf-decay", `lb-players`.playername, @world, `lb-world`.x, `lb-world`.y, `lb-world`.z, CONCAT('{"block_id":',`lb-world`.replaced,',"block_subid":',`lb-world`.data,'}')
  FROM `lb-world`
  JOIN `lb-players` ON `lb-players`.playerid = `lb-world`.playerid
  WHERE `lb-world`.replaced = 18;

-- lighter
INSERT INTO prism_actions (action_time,action_type,player,world,x,y,z,data)
  SELECT `lb-world`.date, "lighter", `lb-players`.playername, @world, `lb-world`.x, `lb-world`.y, `lb-world`.z, CONCAT('{"block_id":',`lb-world`.type,',"block_subid":',`lb-world`.data,'}')
  FROM `lb-world`
  JOIN `lb-players` ON `lb-players`.playerid = `lb-world`.playerid
  WHERE `lb-world`.replaced = 0 AND `lb-world`.type = 51;

-- block-burn
INSERT INTO prism_actions (action_time,action_type,player,world,x,y,z,data)
  SELECT `lb-world`.date, "block-burn", "Environment", @world, `lb-world`.x, `lb-world`.y, `lb-world`.z, CONCAT('{"block_id":',`lb-world`.replaced,',"block_subid":',`lb-world`.data,'}')
  FROM `lb-world`
  JOIN `lb-players` ON `lb-players`.playerid = `lb-world`.playerid AND `lb-players`.playername = "Fire"
  WHERE `lb-world`.type = 0;

-- lava-bucket
INSERT INTO prism_actions (action_time,action_type,player,world,x,y,z,data)
  SELECT `lb-world`.date, "lava-bucket", `lb-players`.playername, @world, `lb-world`.x, `lb-world`.y, `lb-world`.z, '{"block_id":0,"block_subid":0}'
  FROM `lb-world`
  JOIN `lb-players` ON `lb-players`.playerid = `lb-world`.playerid
  WHERE `lb-world`.type = 11 AND `lb-world`.replaced = 0;

-- water-bucket
INSERT INTO prism_actions (action_time,action_type,player,world,x,y,z,data)
  SELECT `lb-world`.date, "water-bucket", `lb-players`.playername, @world, `lb-world`.x, `lb-world`.y, `lb-world`.z, '{"block_id":0,"block_subid":0}'
  FROM `lb-world`
  JOIN `lb-players` ON `lb-players`.playerid = `lb-world`.playerid
  WHERE `lb-world`.type = 9 AND `lb-world`.replaced = 0;

-- block-form
INSERT INTO prism_actions (action_time,action_type,player,world,x,y,z,data)
  SELECT `lb-world`.date, "block-form", "Environment", @world, `lb-world`.x, `lb-world`.y, `lb-world`.z, CONCAT('{"block_id":',`lb-world`.type,',"block_subid":0}')
  FROM `lb-world`
  JOIN `lb-players` ON `lb-players`.playerid = `lb-world`.playerid AND `lb-players`.playername = "SnowForm"
  WHERE `lb-world`.type IN (78,79) AND `lb-world`.replaced = 0;

-- enderman-pickup
INSERT INTO prism_actions (action_time,action_type,player,world,x,y,z,data)
  SELECT `lb-world`.date, "block-burn", "Environment", @world, `lb-world`.x, `lb-world`.y, `lb-world`.z, CONCAT('{"block_id":',`lb-world`.replaced,',"block_subid":',`lb-world`.data,'}')
  FROM `lb-world`
  JOIN `lb-players` ON `lb-players`.playerid = `lb-world`.playerid AND `lb-players`.playername = "Enderman"
  WHERE `lb-world`.type = 0;


-- @todo item-insert
-- @todo item-remove
-- @todo block-use
-- @todo sign-change
-- @todo world-edit
-- @todo block-fade

-- @todo block-spread
-- @todo enderman-place
-- @todo player-chat
-- @todo player-death