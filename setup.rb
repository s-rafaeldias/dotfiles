WORKING_DIR = Dir.pwd
XDG_CONFIG_HOME = ENV.fetch 'XDG_CONFIG_HOME', '~/.config'

# Shell files
Dir.glob("#{WORKING_DIR}/shell/*").each do |f|
  system "ln -sf ~/.#{f}"
end

# Create necessary folders
system "mkdir -p #{XDG_CONFIG_HOME}/nvim/lua"
system "mkdir -p #{XDG_CONFIG_HOME}/nvim/plugin"

# Nvim files
Dir.glob("#{WORKING_DIR}/nvim/**/**.*").each do |f|
  filename = f.delete_prefix "#{WORKING_DIR}/nvim/"
  target_filename = "#{XDG_CONFIG_HOME}/nvim/#{filename}"

  system "ln -sf #{f} #{target_filename}"
end
