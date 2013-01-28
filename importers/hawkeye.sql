-- PRISM Import Script
-- for Hawkeye Reloaded
--
-- This script has to modify the hawkeye data slightly
-- so we can import it properly. Please BACKUP your
-- hawkeye table.
--
-- Run this script in your MySQL server console, or an application
-- that runs SQL queries, like phpMyAdmin, etc.
--


-- TEMP ONLY, for dev
-- http://is.gd/Q8BQQT
TRUNCATE TABLE prism_actions;


-- Normalize the hawkeye data so we can avoid a ton of conditions
UPDATE hawkeye SET hawkeye.data = CONCAT(hawkeye.data, ':0') WHERE LOCATE(":", hawkeye.data) = 0 AND hawkeye.action IN (0,1,17,18,20,26,27,34);

-- block-break
INSERT INTO prism_actions (action_time,action_type,player,world,x,y,z,data)
  SELECT hawkeye.date, "block-break", hawk_players.player, hawk_worlds.world, hawkeye.x, hawkeye.y, hawkeye.z, CONCAT('{"block_id":',SUBSTRING_INDEX(hawkeye.data,':',1),',"block_subid":', SUBSTRING_INDEX(hawkeye.data,':',-1), '}')
  FROM hawkeye
  JOIN hawk_players ON hawkeye.player_id = hawk_players.player_id
  JOIN hawk_worlds ON hawkeye.world_id = hawk_worlds.world_id
  WHERE hawkeye.action = 0;

-- block-place
INSERT INTO prism_actions (action_time,action_type,player,world,x,y,z,data)
  SELECT hawkeye.date, "block-place", hawk_players.player, hawk_worlds.world, hawkeye.x, hawkeye.y, hawkeye.z, CONCAT('{"block_id":',SUBSTRING_INDEX(SUBSTRING_INDEX(hawkeye.data,'-',-1),':',1),',"block_subid":', SUBSTRING_INDEX(SUBSTRING_INDEX(hawkeye.data,'-',-1),':',-1), '}')
  FROM hawkeye
  JOIN hawk_players ON hawkeye.player_id = hawk_players.player_id
  JOIN hawk_worlds ON hawkeye.world_id = hawk_worlds.world_id
  WHERE hawkeye.action = 1;

-- tree-grow
INSERT INTO prism_actions (action_time,action_type,player,world,x,y,z,data)
  SELECT hawkeye.date, "tree-grow", hawk_players.player, hawk_worlds.world, hawkeye.x, hawkeye.y, hawkeye.z, CONCAT('{"block_id":',SUBSTRING_INDEX(SUBSTRING_INDEX(hawkeye.data,'-',-1),':',1),',"block_subid":', SUBSTRING_INDEX(SUBSTRING_INDEX(hawkeye.data,'-',-1),':',-1), '}')
  FROM hawkeye
  JOIN hawk_players ON hawkeye.player_id = hawk_players.player_id
  JOIN hawk_worlds ON hawkeye.world_id = hawk_worlds.world_id
  WHERE hawkeye.action = 34;

-- creeper-explode
INSERT INTO prism_actions (action_time,action_type,player,world,x,y,z,data)
  SELECT hawkeye.date, "creeper-explode", "creeper", hawk_worlds.world, hawkeye.x, hawkeye.y, hawkeye.z, CONCAT('{"block_id":',SUBSTRING_INDEX(hawkeye.data,':',1),',"block_subid":', SUBSTRING_INDEX(hawkeye.data,':',-1), '}')
  FROM hawkeye
  JOIN hawk_players ON hawkeye.player_id = hawk_players.player_id
  JOIN hawk_worlds ON hawkeye.world_id = hawk_worlds.world_id
  WHERE hawkeye.action = 17 AND hawk_players.player = "Creeper";

-- tnt-explode
INSERT INTO prism_actions (action_time,action_type,player,world,x,y,z,data)
  SELECT hawkeye.date, "tnt-explode", "creeper", hawk_worlds.world, hawkeye.x, hawkeye.y, hawkeye.z, CONCAT('{"block_id":',SUBSTRING_INDEX(hawkeye.data,':',1),',"block_subid":', SUBSTRING_INDEX(hawkeye.data,':',-1), '}')
  FROM hawkeye
  JOIN hawk_players ON hawkeye.player_id = hawk_players.player_id
  JOIN hawk_worlds ON hawkeye.world_id = hawk_worlds.world_id
  WHERE hawkeye.action = 17 AND hawk_players.player = "TNT";

-- lighter
INSERT INTO prism_actions (action_time,action_type,player,world,x,y,z,data)
  SELECT hawkeye.date, "lighter", hawk_players.player, hawk_worlds.world, hawkeye.x, hawkeye.y, hawkeye.z, ""
  FROM hawkeye
  JOIN hawk_players ON hawkeye.player_id = hawk_players.player_id
  JOIN hawk_worlds ON hawkeye.world_id = hawk_worlds.world_id
  WHERE hawkeye.action = 13;

-- block-burn
INSERT INTO prism_actions (action_time,action_type,player,world,x,y,z,data)
  SELECT hawkeye.date, "block-burn", hawk_players.player, hawk_worlds.world, hawkeye.x, hawkeye.y, hawkeye.z, CONCAT('{"block_id":',SUBSTRING_INDEX(hawkeye.data,':',1),',"block_subid":', SUBSTRING_INDEX(hawkeye.data,':',-1), '}')
  FROM hawkeye
  JOIN hawk_players ON hawkeye.player_id = hawk_players.player_id
  JOIN hawk_worlds ON hawkeye.world_id = hawk_worlds.world_id
  WHERE hawkeye.action = 18;

-- leaf-decay
INSERT INTO prism_actions (action_time,action_type,player,world,x,y,z,data)
  SELECT hawkeye.date, "leaf-decay", hawk_players.player, hawk_worlds.world, hawkeye.x, hawkeye.y, hawkeye.z, CONCAT('{"block_id":',SUBSTRING_INDEX(hawkeye.data,':',1),',"block_subid":', SUBSTRING_INDEX(hawkeye.data,':',-1), '}')
  FROM hawkeye
  JOIN hawk_players ON hawkeye.player_id = hawk_players.player_id
  JOIN hawk_worlds ON hawkeye.world_id = hawk_worlds.world_id
  WHERE hawkeye.action = 20;

-- player-chat
INSERT INTO prism_actions (action_time,action_type,player,world,x,y,z,data)
  SELECT hawkeye.date, "player-chat", hawk_players.player, hawk_worlds.world, hawkeye.x, hawkeye.y, hawkeye.z, hawkeye.data
  FROM hawkeye
  JOIN hawk_players ON hawkeye.player_id = hawk_players.player_id
  JOIN hawk_worlds ON hawkeye.world_id = hawk_worlds.world_id
  WHERE hawkeye.action = 3;

-- player-command
INSERT INTO prism_actions (action_time,action_type,player,world,x,y,z,data)
  SELECT hawkeye.date, "player-command", hawk_players.player, hawk_worlds.world, hawkeye.x, hawkeye.y, hawkeye.z, hawkeye.data
  FROM hawkeye
  JOIN hawk_players ON hawkeye.player_id = hawk_players.player_id
  JOIN hawk_worlds ON hawkeye.world_id = hawk_worlds.world_id
  WHERE hawkeye.action = 4;

-- player-join
INSERT INTO prism_actions (action_time,action_type,player,world,x,y,z,data)
  SELECT hawkeye.date, "player-join", hawk_players.player, hawk_worlds.world, hawkeye.x, hawkeye.y, hawkeye.z, ""
  FROM hawkeye
  JOIN hawk_players ON hawkeye.player_id = hawk_players.player_id
  JOIN hawk_worlds ON hawkeye.world_id = hawk_worlds.world_id
  WHERE hawkeye.action = 5;

-- player-quit
INSERT INTO prism_actions (action_time,action_type,player,world,x,y,z,data)
  SELECT hawkeye.date, "player-quit", hawk_players.player, hawk_worlds.world, hawkeye.x, hawkeye.y, hawkeye.z, ""
  FROM hawkeye
  JOIN hawk_players ON hawkeye.player_id = hawk_players.player_id
  JOIN hawk_worlds ON hawkeye.world_id = hawk_worlds.world_id
  WHERE hawkeye.action = 6;

-- lava-bucket
INSERT INTO prism_actions (action_time,action_type,player,world,x,y,z,data)
  SELECT hawkeye.date, "lava-bucket", hawk_players.player, hawk_worlds.world, hawkeye.x, hawkeye.y, hawkeye.z, ""
  FROM hawkeye
  JOIN hawk_players ON hawkeye.player_id = hawk_players.player_id
  JOIN hawk_worlds ON hawkeye.world_id = hawk_worlds.world_id
  WHERE hawkeye.action = 8;

-- water-bucket
INSERT INTO prism_actions (action_time,action_type,player,world,x,y,z,data)
  SELECT hawkeye.date, "water-bucket", hawk_players.player, hawk_worlds.world, hawkeye.x, hawkeye.y, hawkeye.z, ""
  FROM hawkeye
  JOIN hawk_players ON hawkeye.player_id = hawk_players.player_id
  JOIN hawk_worlds ON hawkeye.world_id = hawk_worlds.world_id
  WHERE hawkeye.action = 9;

-- lava-flow
INSERT INTO prism_actions (action_time,action_type,player,world,x,y,z,data)
  SELECT hawkeye.date, "lava-flow", hawk_players.player, hawk_worlds.world, hawkeye.x, hawkeye.y, hawkeye.z, CONCAT('{"block_id":',SUBSTRING_INDEX(SUBSTRING_INDEX(hawkeye.data,'-',-1),':',1),',"block_subid":', SUBSTRING_INDEX(SUBSTRING_INDEX(hawkeye.data,'-',-1),':',-1), '}')
  FROM hawkeye
  JOIN hawk_players ON hawkeye.player_id = hawk_players.player_id
  JOIN hawk_worlds ON hawkeye.world_id = hawk_worlds.world_id
  WHERE hawkeye.action = 26;

-- water-flow
INSERT INTO prism_actions (action_time,action_type,player,world,x,y,z,data)
  SELECT hawkeye.date, "water-flow", hawk_players.player, hawk_worlds.world, hawkeye.x, hawkeye.y, hawkeye.z, CONCAT('{"block_id":',SUBSTRING_INDEX(SUBSTRING_INDEX(hawkeye.data,'-',-1),':',1),',"block_subid":', SUBSTRING_INDEX(SUBSTRING_INDEX(hawkeye.data,'-',-1),':',-1), '}')
  FROM hawkeye
  JOIN hawk_players ON hawkeye.player_id = hawk_players.player_id
  JOIN hawk_worlds ON hawkeye.world_id = hawk_worlds.world_id
  WHERE hawkeye.action = 27;


-- @todo item-drop data = 1x 325 or 1x 5:3
--
--     2 - Sign Place
--     7 - Teleport
--     10 - Open Chest
--     11 - Door Interact
--     12 - PvP Death
--     14 - Lever
--     15 - Button
--     19 - Block Form (logged as player Environment)
--     20 - Leaf Decay (logged as player Environment)
--     21 - Mob Death
--     22 - Other Death
--     23 - Item Drop
--     24 - Item Pickup
--     25 - Block Fade (logged as player Environment)
--     28 - Container Transaction
--     29 - Sign Break
--     30 - Painting Break
--     31 - Painting Place
--     32 - Enderman pickup
--     33 - Enderman place
--     35 - Mushroom grow
--     36 - Mob kill