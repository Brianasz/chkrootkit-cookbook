#
# Cookbook Name:: chkrootkit-cookbook
# Recipe:: install
#
# Copyright (c) 2017 The Authors, All Rights Reserved.

user = node['chkrootkit']['user']

if node['platform_family'] == 'rhel'
  yum_package 'glibc-static.x86_64' do
    action :install
  end

  yum_package 'gcc' do 
    action :install
  end
elsif node['platform_family'] == 'debian'
  apt_package 'glibc-static.x86_64' do
    action :install
  end

  apt_package 'gcc' do
    action :install
  end
end

directory "#{node['chkrootkit']['package_directory']}" do
  owner "#{user}"
  group "#{user}"
  mode  '0755'
  action :create
end

cookbook_file "#{node['chkrootkit']['package_directory']}/chkrootkit.tar.gz" do
  source 'chkrootkit.tar.gz'
  owner "#{user}"
  group "#{user}"
  mode '0755'
  action :create
end

bash 'Decompress chkrootkit .tar.gz package' do
  code <<-EOH
    cd "#{node['chkrootkit']['package_directory']}"
    tar xvf chkrootkit.tar.gz
    EOH
  not_if { ::File.exist?("#{node['chkrootkit']['package_directory']}/chkrootkit-0.52") }
end

bash 'Compile chkrootkit package' do
  code <<-EOH
    cd "#{node['chkrootkit']['package_directory']}/chkrootkit-0.52"
    make sense
    EOH
  not_if { ::File.exist?("#{node['chkrootkit']['installation_directory']}/chklastlog") }
end
