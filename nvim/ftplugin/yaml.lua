local filename = vim.fn.expand("%:t")

if filename == "docker-compose.yaml" then
	vim.bo.filetype = "yaml.docker-compose"
end
