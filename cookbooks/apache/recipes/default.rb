#
# Cookbook:: apache
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.
#Install apache package


include_recipe 'apache::motd'
include_recipe 'apache::install_agent'


template '/etc/scalyr-agent-2/node_info.json' do
	source 'node_info.json.erb'
	owner 'apache'
	group 'apache'
	variables(
	api_key: '0lKxW849DUajlVwoqw1mnBkAJ95y_f4QyRuQRT4tt/Pc-',
	node_fqdn: node['fqdn']
	)
end
