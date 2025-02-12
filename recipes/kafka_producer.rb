# frozen_string_literal: true
#
# Cookbook Name:: opennms-cookbook
# Recipe:: kafka_producer
#
# Copyright 2015-2022, ConvergeOne
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
mv = Opennms::Helpers.major(node['opennms']['version'])
template_dir = if node['opennms']['conf']['cookbook'] == 'opennms'
                 "horizon-#{format(mv, version: node['opennms']['version'])}/"
               else
                 ''
               end

template "#{node['opennms']['conf']['home']}/etc/org.opennms.features.kafka.producer.cfg" do
  source "#{template_dir}org.opennms.features.kafka.producer.cfg.erb"
  owner 'root'
  group 'root'
  mode 00664
  only_if { mv.to_i == 26}
  notifies :restart, 'service[opennms]', :delayed
end

template "#{node['opennms']['conf']['home']}/etc/org.opennms.features.kafka.producer.client.cfg" do
  source "#{template_dir}org.opennms.features.kafka.producer.client.cfg.erb"
  owner 'root'
  group 'root'
  mode 00664
  only_if { mv.to_i == 26}
  notifies :restart, 'service[opennms]', :delayed
end

template "#{node['opennms']['conf']['home']}/etc/org.apache.karaf.features.cfg" do
  source "#{template_dir}org.apache.karaf.features.cfg.erb"
  owner 'root'
  group 'root'
  mode 00664
  only_if { mv.to_i == 26}
  notifies :restart, 'service[opennms]', :delayed
end
