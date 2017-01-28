#!/usr/bin/env ruby

file = "test"

lines = IO.readlines(file)

matrix = []
while (line = lines.shift) do
  matrix << line.split("&")
end

tmatrix = matrix.transpose

lmax = 0
tmatrix.each do |row|
  row.each do |elem|
    lmax = [elem.strip.length,lmax].max
  end
end

File.open("tout",'w') do |f|
  tmatrix.each do |row|
    just_row = row.map{|x| x.strip.ljust(lmax)}
    f.puts just_row.join(" & ") + ' \\\\ \\\\'
  end
end

