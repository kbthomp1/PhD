#!/usr/bin/env ruby

require 'fileutils'
require_relative "./integer_to_word.rb"

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
  new_chapter = chapter+1
  old_chapter_dir = "Chapter-#{chapter}"
  new_chapter_dir = "Chapter-#{new_chapter}"
  old_tex = "#{old_chapter_dir}/Chapter-#{chapter}.tex"
  new_tex = "#{old_chapter_dir}/Chapter-#{new_chapter}.tex"

  clean_cmd = "(cd #{old_chapter_dir} && make clean)"
  system clean_cmd

  puts "moving #{old_tex} to #{new_tex}"
  File.open(new_tex,'w') do |f|
    lines = IO.readlines(old_tex)
    while line = lines.shift
      if line.match(/\\label{chapter-.*}/)
        line = "\\label{chapter-#{new_chapter.to_word}}"
      end
      f.puts line
    end
  end
  FileUtils.rm(old_tex)

  puts "moving #{old_chapter_dir} to #{new_chapter_dir}"
  FileUtils.mv(old_chapter_dir,new_chapter_dir)
end

def make_new_chapter(new_chapter)
  new_dir = "Chapter-#{new_chapter}"
  FileUtils.mkdir(new_dir)
  FileUtils.ln_s("chapter-makefile","#{new_dir}/Makefile")
  File.open("#{new_dir}/Chapter-#{new_chapter}.tex",'w') do |f|
    f.puts "\\chapter{New Chapter}"
    f.puts "\\label{chapter-#{new_chapter.to_word}}"
  end
end

new_chapter = ARGV[0]
new_chapter = new_chapter.to_i

if (new_chapter == nil)
  puts "usage: ruby add_chapter <new chapter number>"
  exit 1
end

max_chapter = find_max_chapter()
chapter = max_chapter
while chapter >= new_chapter
  move_chapter(chapter)
  chapter -= 1
end

make_new_chapter(new_chapter)

