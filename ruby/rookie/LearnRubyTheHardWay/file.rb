#!/usr/bin/ruby

file = ARGV.first

txt = open(file)
print txt.read 
