#
# Cookbook Name:: chkrootkit-cookbook
# Recipe:: cron
#
# Copyright (c) 2017 The Authors, All Rights Reserved.

template "#{node['chkrootkit']['package_directory']}/running-chkrootkit.sh" do
  source 'running-chkrootkit.sh'
  owner 'root'
  group 'root'
  mode '0755'
end

cron 'chkrootkit' do
  hour '*'
  minute '0'
  user 'root'
  command "#{node['chkrootkit']['package_directory']}/running-chkrootkit.sh"
  mailto node['chkrootkit']['notification_email']
end
