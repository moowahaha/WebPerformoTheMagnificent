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
  self.rubyforge_name       = self.name
  self.extra_deps         = [['selenium-webdriver','>= 0.0.18']]
end

require 'newgem/tasks'
Dir['tasks/*.rake'].each { |t| load t }

