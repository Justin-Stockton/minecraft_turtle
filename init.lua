local url = "https://raw.githubusercontent.com/Justin-stockton/minecraft_turtles/refs/heads/main/downloader.lua"
local res = http.get(url)
local file = fs.open("downloader.lua", "w")
file.write(res.readAll())
file.close()
