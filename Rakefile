require 'rubygems'
gem 'hoe', '>= 2.1.0'
require 'hoe'
require 'fileutils'
require './lib/web_performo'

Hoe.plugin :newgem
# Hoe.plugin :website
# Hoe.plugin :cucumberfeatures

# Generate all the Rake tasks
# Run 'rake -T' to see list of generated tasks (from gem root directory)
$hoe = Hoe.spec 'web_performo' do
  self.developer 'Stephen Hardisty', 'moowahaha@hotmail.com'
  self.post_install_message = 'PostInstall.txt' # TODO remove if post-install message not required
  self.rubyforge_name       = self.name # TODO this is default value
  # self.extra_deps         = [['activesupport','>= 2.0.2']]

end

require 'newgem/tasks'
Dir['lib/tasks/*.rake'].each { |t| load t }

