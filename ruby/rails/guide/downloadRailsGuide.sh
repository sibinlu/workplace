#!/bin/sh

git clone git://github.com/rails/rails.git
sudo gem install redcarpet
cd rails/guides/
ruby rails_guides.rb cd output/
cd output/
open index.html
