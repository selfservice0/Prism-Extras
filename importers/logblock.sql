
-- PRISM Import Script
-- for LogBlock
--
-- STEP 1: LogBlocks stores data in a different table per world.
-- Please change the following world name for every world
-- you wish to import. For example, 'world_nether', etc.

SET @world = 'world';

-- STEP 2: After changing the world name, also do a search/replace for "lb-world" and change it to "lb-yourWorldName"

-- STEP 3: Run this script in your MySQL server console, or an application
-- that runs SQL queries, like phpMyAdmin, etc.

-- IMPORTANT: Some queries, like chat, commands, etc only work if you have those
-- tables - if those actions are recorded. Be sure to remove any queries for
-- tables you do not have.
--
-- ALSO, know that logblock does not record coordinates for chat or commands
-- so you should only run those queries once.
--


-- block-break
INSERT INTO prism_actions (action_time,action_type,player,world,x,y,z,data)
  SELECT `lb-world`.date, "block-break", `lb-players`.playername, @world, `lb-world`.x, `lb-world`.y, `lb-world`.z, CONCAT('{"block_id":',`lb-world`.replaced,',"block_subid":',`lb-world`.data,'}')
  FROM `lb-world`
  JOIN `lb-players` ON `lb-players`.playerid = `lb-world`.playerid
  WHERE `lb-world`.type = 0
  AND `lb-players`.playername NOT IN ("Creeper","Fire","TNT","WaterFlow","LavaFlow","LeavesDecay");

-- water-flow
INSERT INTO prism_actions (action_time,action_type,player,world,x,y,z,data)
  SELECT `lb-world`.date, "water-flow", "Water", @world, `lb-world`.x, `lb-world`.y, `lb-world`.z, '{"block_id":9,"block_subid":0}'
  FROM `lb-world`
  JOIN `lb-players` ON `lb-players`.playerid = `lb-world`.playerid AND `lb-players`.playername = "WaterFlow"
  WHERE `lb-world`.type IN (8,9) AND `lb-world`.replaced = 0;

-- water-break
INSERT INTO prism_actions (action_time,action_type,player,world,x,y,z,data)
  SELECT `lb-world`.date, "water-break", "Water", @world, `lb-world`.x, `lb-world`.y, `lb-world`.z, CONCAT('{"block_id":',`lb-world`.replaced,',"block_subid":',`lb-world`.data,'}')
  FROM `lb-world`
  JOIN `lb-players` ON `lb-players`.playerid = `lb-world`.playerid AND `lb-players`.playername = "WaterFlow"
  WHERE `lb-world`.type IN (8,9) AND `lb-world`.replaced != 0;

-- lava-flow
INSERT INTO prism_actions (action_time,action_type,player,world,x,y,z,data)
  SELECT `lb-world`.date, "lava-flow", "Lava", @world, `lb-world`.x, `lb-world`.y, `lb-world`.z, '{"block_id":11,"block_subid":0}'
  FROM `lb-world`
  JOIN `lb-players` ON `lb-players`.playerid = `lb-world`.playerid AND `lb-players`.playername = "LavaFlow"
  WHERE `lb-world`.type IN (10,11) AND `lb-world`.replaced = 0;

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
  WHERE `lb-world`.type IN (17,18) AND `lb-world`.replaced = 0;

-- @todo mushroom grow

-- leaf-decay
INSERT INTO prism_actions (action_time,action_type,player,world,x,y,z,data)
  SELECT `lb-world`.date, "leaf-decay", `lb-players`.playername, @world, `lb-world`.x, `lb-world`.y, `lb-world`.z, CONCAT('{"block_id":',`lb-world`.replaced,',"block_subid":',`lb-world`.data,'}')
  FROM `lb-world`
  JOIN `lb-players` ON `lb-players`.playerid = `lb-world`.playerid
  WHERE `lb-world`.replaced = 18 `lb-world`.type = 0;

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
  SELECT `lb-world`.date, "enderman-pickup", "enderman", @world, `lb-world`.x, `lb-world`.y, `lb-world`.z, CONCAT('{"block_id":',`lb-world`.replaced,',"block_subid":',`lb-world`.data,'}')
  FROM `lb-world`
  JOIN `lb-players` ON `lb-players`.playerid = `lb-world`.playerid AND `lb-players`.playername = "Enderman"
  WHERE `lb-world`.type = 0;

-- enderman-place
INSERT INTO prism_actions (action_time,action_type,player,world,x,y,z,data)
  SELECT `lb-world`.date, "enderman-place", "enderman", @world, `lb-world`.x, `lb-world`.y, `lb-world`.z, CONCAT('{"block_id":',`lb-world`.type,',"block_subid":',`lb-world`.data,'}')
  FROM `lb-world`
  JOIN `lb-players` ON `lb-players`.playerid = `lb-world`.playerid AND `lb-players`.playername = "Enderman"
  WHERE `lb-world`.replaced IN (0, 8, 9, 10, 11, 78);

-- @todo item-insert
-- @todo item-remove

-- block-use
INSERT INTO prism_actions (action_time,action_type,player,world,x,y,z,data)
  SELECT `lb-world`.date, "block-use", `lb-players`.playername, @world, `lb-world`.x, `lb-world`.y, `lb-world`.z, CONCAT('{"block_id":',`lb-world`.type,',"block_subid":',`lb-world`.data,'}')
  FROM `lb-world`
  JOIN `lb-players` ON `lb-players`.playerid = `lb-world`.playerid
  WHERE `lb-world`.type = `lb-world`.replaced;

-- Sign changes are stored in a way that we really can't do much with. LB merges
-- each line into a single line so I'm not sure the best way to handle that.

-- player-chat
-- We can't properly import player chat because there are no coordinates associated.
-- Uncomment this to load chat, but with fake coords.
-- INSERT INTO prism_actions (action_time,action_type,player,world,x,y,z,data)
--   SELECT `lb-chat`.date, "player-chat", `lb-players`.playername, @world, 0, 0, 0, `lb-chat`.message
--   FROM `lb-chat`
--   JOIN `lb-players` ON `lb-players`.playerid = `lb-chat`.playerid
--   WHERE LEFT(`lb-chat`.message, 1) != "/";

-- player-command
-- We can't properly import player commands because there are no coordinates associated.
-- Uncomment this to load commands, but with fake coords.
-- INSERT INTO prism_actions (action_time,action_type,player,world,x,y,z,data)
--   SELECT `lb-chat`.date, "player-chat", `lb-players`.playername, @world, 0, 0, 0, `lb-chat`.message
--   FROM `lb-chat`
--   JOIN `lb-players` ON `lb-players`.playerid = `lb-chat`.playerid
--   WHERE LEFT(`lb-chat`.message, 1) = "/";


-- During development, it appears that logblock does not track
-- the following events, which Prism does:

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
-- player-death (they seem to only record kills, not all deaths)
-- player-join
-- player-quit
-- sheep-eat
-- spawnegg-use
-- tnt-prime