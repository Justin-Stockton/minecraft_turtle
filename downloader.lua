local user = "Justin-Stockton"
local repo = "minecraft_turtle"
local branch = "main"

local args = { ... }
if #args < 1 then
	print("Usage: downloader <program_name>")
	return
end

local programName = args[1]
local url =
	string.format("https://raw.githubusercontent.com/%s/%s/refs/heads/%s/%s.lua", user, repo, branch, programName)

print("Downloading '" .. programName .. "' from GitHub...")
local response = http.get(url)

if response and response.getResponseCode() == 200 then
	local content = response.readAll()
	local file = fs.open(programName .. ".lua", "w")
	file.write(content)
	file.close()
	print("Successfully downloaded and saved as '" .. programName .. "'")
else
	print("Error: Could not download file.")
	if response then
		print("HTTP Status: " .. response.getResponseCode())
	end
end
