--
-- trash.lua
-- Copyright (C) 2021 dindybutts <lewdavatar at gmail dot com>
--
-- Distributed under terms of the GPLv3 license.
--

require 'os'
require 'io'
require 'string'

local utils = require "mp.utils"

currently_played_file = ""

-- the file by moving it to the Trash

function move_current_file()
	currently_played_file = mp.get_property("path")
	--os.execute("mv '" .. mp.get_property("path") .. "' ~/")
	print(mp.get_property("path"), string.format("~/temp/%s", mp.get_property("path")))
	--print(mp.get_property("working-directory"), mp.get_property("path"))
end

--mp.add_forced_key_binding("d", "move_current_file", move_current_file)
mp.add_key_binding("END", "move_current_file", move_current_file)
