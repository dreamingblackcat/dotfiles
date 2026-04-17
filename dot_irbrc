require 'irb/completion'
require 'irb/ext/save-history'
IRB.conf[:SAVE_HISTORY] = 10000
IRB.conf[:HISTORY_FILE] = "~/.irb-history"

if defined?(Rails::Console)
  ActiveRecord::Base.logger = nil
  ActiveRecord::Base.logger = Rails.logger.clone
  ActiveRecord::Base.logger.level = Logger::DEBUG
end

# Define a custom prompt
# Eg:
#   my_app (development) >
IRB.conf[:PROMPT] ||= {}
IRB.conf[:PROMPT][:RAILS_APP] = {
  PROMPT_I: "#{`pwd`.split('/').last.gsub("\n", '')} > ",
  PROMPT_N: nil,
  PROMPT_S: nil,
  PROMPT_C: nil,
  RETURN:   "=> %s\n"
}

# Use the custom  prompt
IRB.conf[:PROMPT_MODE] = :RAILS_APP

IRB.conf[:USE_READLINE] = false if ENV['INSIDE_EMACS']
IRB.conf[:MULTILINE] = false if ENV['INSIDE_EMACS']
