dir = File.dirname(__FILE__)
require "#{dir}/../spec/spec_helper"

Dir["#{dir}/**/*_spec.rb"].each do |spec_file|
  require spec_file
end