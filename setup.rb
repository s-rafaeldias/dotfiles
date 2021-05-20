require 'pathname'

WORKING_DIR     = Dir.pwd
XDG_CONFIG_HOME = ENV.fetch 'XDG_CONFIG_HOME', '~/.config'
NVIM_DIR        = "#{WORKING_DIR}/nvim".freeze

# Shell files
Dir.glob("#{WORKING_DIR}/shell/*").each do |f|
  file = Pathname.new f
  system "ln -sf #{f} ~/.#{file.basename}"
end

# Fish
system "ln -sf #{WORKING_DIR}/fish/config.fish #{XDG_CONFIG_HOME}/fish/config.fish"

# Nvim files
Dir.glob("#{NVIM_DIR}/**/**").each do |f|
  file = Pathname.new f
  path = file.relative_path_from(NVIM_DIR).cleanpath

  if file.directory?
    system "mkdir -p #{XDG_CONFIG_HOME}/nvim/#{path}"
  else
    system "ln -sf #{f} #{XDG_CONFIG_HOME}/nvim/#{path}"
  end
end
