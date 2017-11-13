#
# Cookbook Name:: chkrootkit-cookbook
# Recipe:: default
#
# Copyright (c) 2017 The Authors, All Rights Reserved.

include_recipe 'chkrootkit::install'
include_recipe 'chkrootkit::cron'
