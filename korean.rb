# coding: utf-8
require_relative 'soseol.rb'
output_file = File.open("output.rb", "w")

include Soseol

maker = Soseol::Converting.new
maker.initiallize

File.open('in.txt',"r:UTF-8").each_line do |line|
  #line = line.rstrip
  #line = line.split(//)
  #puts line
  output = maker.make_split_line(line)
  puts maker.output_word
  output_file.write(maker.output_word)
   File.open('output.rb', 'a') { |file| file.write(maker.output_word) }
end

exec 'ruby output.rb'
output_file.close
