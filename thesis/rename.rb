#!/usr/bin/env ruby

require 'fileutils'

files = Dir.glob("**/YourName*")

puts files

files.each do |file|
  newfile = file.sub("YourName-thesis","KyleThompson-thesis")
  puts newfile
  FileUtils.mv(file,newfile)
end
