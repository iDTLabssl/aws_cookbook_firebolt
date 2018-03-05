#
# Cookbook Name:: firebolt
# Recipe:: install
#
# Copyright 2014, iDT Labs
#
# All rights reserved - Do Not Redistribute
#

include_recipe "firebolt"


# lets create our log directory
directory "/home/#{node[:firebolt][:user]}/logs" do
  owner "#{node[:firebolt][:user]}"
  group "#{node[:firebolt][:user]}"
  mode 0777
  action :create
end
