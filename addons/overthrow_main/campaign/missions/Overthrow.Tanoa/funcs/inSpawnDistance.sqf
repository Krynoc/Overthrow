({(alive _x or typename (_x getVariable ["player_uid",false]) == "STRING") and (_this distance _x) < OT_spawnDistance} count ((allPlayers - entities "HeadlessClient_F") + (spawner getVariable ["track",[]])) > 0)