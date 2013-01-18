-- First lets make an array of
-- all the actions used in hawkeye's tables.

DECLARE @actions TABLE ( id int, name VARCHAR(32) )


-- http://is.gd/Q8BQQT
INSERT @actions (id, name) VALUES (0, "block-break")
INSERT @actions (id, name) VALUES (1, "block-place")
INSERT @actions (id, name) VALUES (2, "sign-place")
INSERT @actions (id, name) VALUES (3, "discard") -- Prism does not store this information - Chat
INSERT @actions (id, name) VALUES (4, "") -- Command
INSERT @actions (id, name) VALUES (5, "discard") -- Join
INSERT @actions (id, name) VALUES (6, "discard") -- Quit
INSERT @actions (id, name) VALUES (7, "discard") -- Teleport
INSERT @actions (id, name) VALUES (8, "lava-bucket")
INSERT @actions (id, name) VALUES (9, "water-bucket")
INSERT @actions (id, name) VALUES (10, "container-access")
INSERT @actions (id, name) VALUES (11, "discard") -- Door interact - May be added later
INSERT @actions (id, name) VALUES (12, "player-death")
INSERT @actions (id, name) VALUES (13, "flint-steel")
INSERT @actions (id, name) VALUES (14, "discard") -- Lever - May be added later
INSERT @actions (id, name) VALUES (15, "discard") -- Button - May be added later
INSERT @actions (id, name) VALUES (16, "discard") -- Labled as 'other'