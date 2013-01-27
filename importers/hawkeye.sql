-- PRISM Import Script
-- for Hawkeye or Hawkeye Reloaded
--
--
-- Run this script in your MySQL server console, or an application
-- that runs SQL queries, like phpMyAdmin, etc.
--


-- TEMP ONLY, for dev
-- http://is.gd/Q8BQQT
TRUNCATE TABLE prism_actions;


-- Normalize the hawkeye data so we can avoid a ton of conditions
UPDATE hawkeye SET hawkeye.data = CONCAT(hawkeye.data, ':0') WHERE LOCATE(":", hawkeye.data) = 0 AND hawkeye.action = 0;

-- block break
INSERT INTO prism_actions (action_time,action_type,player,world,x,y,z,data)
  SELECT hawkeye.date, "block-break", hawk_players.player, hawk_worlds.world, hawkeye.x, hawkeye.y, hawkeye.z, CONCAT('{"block_id":',SUBSTRING_INDEX(hawkeye.data,':',1),',"block_subid":', SUBSTRING_INDEX(hawkeye.data,':',-1), '}')
  FROM hawkeye
  JOIN hawk_players ON hawkeye.player_id = hawk_players.player_id
  JOIN hawk_worlds ON hawkeye.world_id = hawk_worlds.world_id
  WHERE hawkeye.action = 0;

-- block place, data looks like 0-5:3 or 0-5