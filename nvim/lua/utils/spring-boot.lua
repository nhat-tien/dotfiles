
-- run debug
local function get_test_runner(test_name, debug)
  if debug then
    return 'mvn test -Dmaven.surefire.debug -Dtest="' .. test_name .. '"'
  end
  return 'mvn test -Dtest="' .. test_name .. '"'
end

local function run_java_test_method(debug)
  local utils = require("utils.utils")
  local method_name = utils.get_current_full_method_name("\\#")
  vim.cmd('term ' .. get_test_runner(method_name, debug))
end

local function run_java_test_class(debug)
  local utils = require("utils.utils")
  local class_name = utils.get_current_full_class_name()
  vim.cmd('term ' .. get_test_runner(class_name, debug))
end

local function get_spring_boot_runner(profile, debug)
  local debug_param = ""
  if debug then
    debug_param = ' -Dspring-boot.run.jvmArguments="-Xdebug -Xrunjdwp:transport=dt_socket,server=y,suspend=y,address=5005" '
  end

  local profile_param = ""
  if profile then
    profile_param = " -Dspring-boot.run.profiles=" .. profile .. " "
  end

  return 'mvn spring-boot:run ' .. profile_param .. debug_param
end

local function run_spring_boot(profile, debug)
  vim.cmd('term ' .. get_spring_boot_runner(profile, debug))
end

-- vim.keymap.set("n", "<leader>tm", function() run_java_test_method() end)
-- vim.keymap.set("n", "<leader>TM", function() run_java_test_method(true) end)
-- vim.keymap.set("n", "<leader>tc", function() run_java_test_class() end)
-- vim.keymap.set("n", "<leader>TC", function() run_java_test_class(true) end)
vim.keymap.set("n", "<F9>", function() run_spring_boot() end)
vim.keymap.set("n", "<F10>", function() run_spring_boot("",true) end)
