#!/usr/bin/env ruby

require 'fileutils'

def find_max_chapter()
  chapter_dirs = Dir.glob("Chapter-*")
  
  max_chapter = 0
  chapter_dirs.each do |chapter|
    number = chapter.split("-").last.to_i
    max_chapter = [number,max_chapter].max
  end

  return max_chapter
end

def move_chapter(chapter)
  old_chapter_dir = "Chapter-#{chapter}"
  new_chapter_dir = "Chapter-#{chapter+1}"
  old_tex = "#{old_chapter_dir}/Chapter-#{chapter}.tex"
  new_tex = "#{old_chapter_dir}/Chapter-#{chapter+1}.tex"
  clean_cmd = "(cd #{old_chapter_dir} && make clean)"
  system clean_cmd
  puts "moving #{old_tex} to #{new_tex}"
  puts "moving #{old_chapter_dir} to #{new_chapter_dir}"
end

new_chapter = ARGV[0]

if (new_chapter == nil)
  puts "usage: ruby add_chapter <new chapter number>"
  exit 1
end

max_chapter = find_max_chapter()
chapter = max_chapter
while chapter >= new_chapter.to_i
  move_chapter(chapter)
  chapter -= 1
end

