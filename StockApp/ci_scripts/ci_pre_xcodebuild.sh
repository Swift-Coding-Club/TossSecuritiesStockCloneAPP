#!/bin/sh

#  ci_pre_xcodebuild.sh
#  StockApp
#
#  Created by 서원지 on 2022/12/10.
#  
cd ..
 
echo ">>> SETUP ENVIRONMENT"
echo 'export GEM_HOME=$HOME/gems' >>~/.bash_profile
echo 'export PATH=$HOME/gems/bin:$PATH' >>~/.bash_profile
export GEM_HOME=$HOME/gems
export PATH="$GEM_HOME/bin:$PATH"
 
echo ">>> INSTALL BUNDLER"
gem install bundler --install-dir $GEM_HOME
 
echo ">>> INSTALL DEPENDENCIES"
bundle install
 
echo ">>> INSTALL PODS"
bundle exec pod install
