#!/usr/bin/ruby
#Difference between puts & print
puts "a"
puts "b"

print "a"
print "b"

puts
puts "###############################"

#Format
formatter = "%{param1}  %{param2} "
puts formatter % {param1: "abc"  , param2: "123"}

puts "###############################"

print "input sth: "
param =$stdin.gets.chomp
puts "the input : #{param}"


puts "###############################"

param = ARGV.first
puts "hi, #{param}"


puts "###############################"
