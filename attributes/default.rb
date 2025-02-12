# frozen_string_literal: true
onms_home = '/opt/opennms'
# change default yum_timeout to 1200 because opennms packages are slow sometimes.
default['yum_timeout'] = 1200
# yum repo stuff
default['yum']['opennms']['key_url']                      = 'http://yum.opennms.org/OPENNMS-GPG-KEY'
default['yum']['opennms-stable-common']['baseurl']        = 'http://yum.opennms.org/stable/common'
default['yum']['opennms-stable-common']['failovermethod'] = 'roundrobin'
default['yum']['opennms-stable-rhel6']['baseurl']         = 'http://yum.opennms.org/stable/rhel6'
default['yum']['opennms-stable-rhel6']['failovermethod']  = 'roundrobin'
default['yum']['opennms-stable-rhel7']['baseurl']         = 'http://yum.opennms.org/stable/rhel7'
default['yum']['opennms-stable-rhel7']['failovermethod']  = 'roundrobin'
default['yum']['opennms-obsolete-common']['baseurl']        = 'http://yum.opennms.org/obsolete/common'
default['yum']['opennms-obsolete-common']['failovermethod'] = 'roundrobin'
default['yum']['opennms-obsolete-rhel6']['baseurl']         = 'http://yum.opennms.org/obsolete/rhel6'
default['yum']['opennms-obsolete-rhel6']['failovermethod']  = 'roundrobin'
default['yum']['opennms-obsolete-rhel7']['baseurl']         = 'http://yum.opennms.org/obsolete/rhel7'
default['yum']['opennms-obsolete-rhel7']['failovermethod']  = 'roundrobin'
default['yum']['opennms-snapshot-common']['baseurl']        = 'http://yum.opennms.org/snapshot/common'
default['yum']['opennms-snapshot-common']['failovermethod'] = 'roundrobin'
default['yum']['opennms-snapshot-rhel6']['baseurl']         = 'http://yum.opennms.org/snapshot/rhel6'
default['yum']['opennms-snapshot-rhel6']['failovermethod']  = 'roundrobin'
default['yum']['opennms-snapshot-rhel7']['baseurl']         = 'http://yum.opennms.org/snapshot/rhel7'
default['yum']['opennms-snapshot-rhel7']['failovermethod']  = 'roundrobin'
default['yum']['opennms-oldstable-common']['baseurl']        = 'http://yum.opennms.org/oldstable/common'
default['yum']['opennms-oldstable-common']['failovermethod'] = 'roundrobin'
default['yum']['opennms-oldstable-rhel6']['baseurl']         = 'http://yum.opennms.org/oldstable/rhel6'
default['yum']['opennms-oldstable-rhel6']['failovermethod']  = 'roundrobin'
default['yum']['opennms-oldstable-rhel7']['baseurl']         = 'http://yum.opennms.org/oldstable/rhel7'
default['yum']['opennms-oldstable-rhel7']['failovermethod']  = 'roundrobin'
# 6 is eol but I guess folks might still need it
case node['platform_family']
when 'rhel'
  if node['platform_version'].to_f >= 6.0 && node['platform_version'].to_f < 7.0
    default['yum']['base']['baseurl'] = 'https://archive.kernel.org/centos-vault/6.9/os/$basearch/'
    default['yum']['extras']['baseurl'] = 'https://archive.kernel.org/centos-vault/6.9/extras/$basearch/'
    default['yum']['updates']['baseurl'] = 'https://archive.kernel.org/centos-vault/6.9/updates/$basearch/'
    default['yum']['base']['mirrorlist'] = nil
    default['yum']['extras']['mirrorlist'] = nil
    default['yum']['updates']['mirrorlist'] = nil
  end
end
default['build-essential']['compile_time'] = true
# set to -Q to mimic OOTB quick start behavior on RHEL7+ (but you should not do this if using any of the opennms resources)
default['opennms']['start_opts'] = ''
# set to '' if you want to re-enable OOTB behavior (but you should not do this if using any of the opennms resources)
default['opennms']['timeout_start_sec'] = '10min'
default['opennms']['version'] = '28.1.1-1'
default['java']['version'] = '11'
# default['opennms']['version_major'] = "%{version}"
default['opennms']['allow_downgrade'] = false
default['opennms']['stable'] = true
# whether or not to attempt to automatically upgrade opennms
default['opennms']['upgrade'] = false
default['opennms']['upgrade_dirs'] = [
  'etc',
  'etc/datacollection',
  'etc/events',
  'etc/drools-engine.d/ncs',
  'etc/snmp-graph.properties.d',
  'jetty-webapps/opennms',
  'jetty-webapps/opennms/WEB-INF/',
  'jetty-webapps/opennms/WEB-INF/jsp/alarm',
  'jetty-webapps/opennms/WEB-INF/jsp/ncs',
  'jetty-webapps/opennms-remoting/WEB-INF',
]
# whether or not to include the plugin packages
default['opennms']['plugin']['xml'] = false
default['opennms']['plugin']['nsclient'] = false
# populate this with the names of additional packages you want installed.
# examples:
# * opennms-plugin-northbounder-jms
# * opennms-plugin-provisioning-snmp-asset
# * opennms-plugin-provisioning-snmp-hardware-inventory
# * opennms-plugin-provisioning-wsman-asset
default['opennms']['plugin']['addl'] = []
default['opennms']['addl_handlers'] = []
# change to true to generate a random password
default['opennms']['secure_admin'] = false
# opennms.conf
default['opennms']['conf']['home']           = onms_home

default['opennms']['conf']['pidfile']        = "#{onms_home}/logs/opennms.pid"
default['opennms']['conf']['logdir']         = "#{onms_home}/logs"
default['opennms']['conf']['initdir']        = "#{onms_home}/bin"
default['opennms']['conf']['redirect']       = '$LOG_DIRECTORY/output.log'
default['opennms']['conf']['start_timeout']  = 35
default['opennms']['conf']['status_wait']    = 5
default['opennms']['conf']['heap_size']      = 512
default['opennms']['conf']['addl_mgr_opts']  = ''
default['opennms']['conf']['addl_classpath'] = ''
default['opennms']['conf']['use_incgc']      = ''
default['opennms']['conf']['hotspot']        = ''
default['opennms']['conf']['verbose_gc']     = ''
default['opennms']['conf']['runjava_opts']   = ''
default['opennms']['conf']['invoke_url']     = 'http://127.0.0.1:8181/invoke?objectname=OpenNMS:Name=Manager'
default['opennms']['conf']['runas']          = 'root'
default['opennms']['conf']['max_file_descr'] = '20480'
default['opennms']['conf']['max_stack_sgmt'] = '8192'
default['opennms']['conf']['command']        = ''
# TEMPLATES

# whether or not to use all templates or just base.
# Once upon a time there were two different recipes
# for installation (default and notemplates) but now
# the latter just sets this attribute to false.
default['opennms']['templates'] = false
# default cookbook for templates
default['opennms']['default_template_cookbook'] = 'opennms'
default['opennms']['users']['cookbook']                    = node['opennms']['default_template_cookbook']
default['opennms']['conf']['cookbook']                     = node['opennms']['default_template_cookbook']
default['opennms']['services']['cookbook']                 = node['opennms']['default_template_cookbook']
default['opennms']['properties']['cookbook']               = node['opennms']['default_template_cookbook']
default['opennms']['db_reports']['avail']['cookbook']      = node['opennms']['default_template_cookbook']
default['opennms']['categories']['cookbook']               = node['opennms']['default_template_cookbook']
default['opennms']['chart']['cookbook']                    = node['opennms']['default_template_cookbook']
default['opennms']['collectd']['cookbook']                 = node['opennms']['default_template_cookbook']
default['opennms']['datacollection']['cookbook']           = node['opennms']['default_template_cookbook']
default['opennms']['discovery']['cookbook']                = node['opennms']['default_template_cookbook']
default['opennms']['enlinkd']['cookbook']                  = node['opennms']['default_template_cookbook']
default['opennms']['eventd']['cookbook']                   = node['opennms']['default_template_cookbook']
default['opennms']['events_archiver']['cookbook']          = node['opennms']['default_template_cookbook']
default['opennms']['javamail_props']['cookbook']           = node['opennms']['default_template_cookbook']
default['opennms']['javamail_config']['cookbook']          = node['opennms']['default_template_cookbook']
default['opennms']['jcifs']['cookbook']                    = node['opennms']['default_template_cookbook']
default['opennms']['jdbc_dc']['cookbook']                  = node['opennms']['default_template_cookbook']
default['opennms']['jmx_dc']['cookbook']                   = node['opennms']['default_template_cookbook']
default['opennms']['linkd']['cookbook']                    = node['opennms']['default_template_cookbook']
default['opennms']['log4j2']['cookbook']                   = node['opennms']['default_template_cookbook']
default['opennms']['magic_users']['cookbook']              = node['opennms']['default_template_cookbook']
default['opennms']['map']['cookbook']                      = node['opennms']['default_template_cookbook']
default['opennms']['microblog']['cookbook']                = node['opennms']['default_template_cookbook']
default['opennms']['importer']['cookbook']                 = node['opennms']['default_template_cookbook']
default['opennms']['modem']['cookbook']                    = node['opennms']['default_template_cookbook']
default['opennms']['notifd']['cookbook']                   = node['opennms']['default_template_cookbook']
default['opennms']['notification_commands']['cookbook']    = node['opennms']['default_template_cookbook']
default['opennms']['notifications']['cookbook']            = node['opennms']['default_template_cookbook']
default['opennms']['nsclient_datacollection']['cookbook']  = node['opennms']['default_template_cookbook']
default['opennms']['poller']['cookbook']                   = node['opennms']['default_template_cookbook']
default['opennms']['remedy']['cookbook']                   = node['opennms']['default_template_cookbook']
default['opennms']['reportd']['cookbook']                  = node['opennms']['default_template_cookbook']
default['opennms']['response_adhoc_graph']['cookbook']     = node['opennms']['default_template_cookbook']
default['opennms']['response_graph']['cookbook']           = node['opennms']['default_template_cookbook']
default['opennms']['rrd']['cookbook']                      = node['opennms']['default_template_cookbook']
default['opennms']['rtc']['cookbook']                      = node['opennms']['default_template_cookbook']
default['opennms']['site_status_views']['cookbook']        = node['opennms']['default_template_cookbook']
default['opennms']['sms_phonebook']['cookbook']            = node['opennms']['default_template_cookbook']
default['opennms']['snmp_adhoc_graph']['cookbook']         = node['opennms']['default_template_cookbook']
default['opennms']['snmp_iface_poller']['cookbook']        = node['opennms']['default_template_cookbook']
default['opennms']['statsd']['cookbook']                   = node['opennms']['default_template_cookbook']
default['opennms']['support']['cookbook']                  = node['opennms']['default_template_cookbook']
default['opennms']['surveillance_views']['cookbook']       = node['opennms']['default_template_cookbook']
default['opennms']['syslog_north']['cookbook']             = node['opennms']['default_template_cookbook']
default['opennms']['syslogd']['cookbook']                  = node['opennms']['default_template_cookbook']
default['opennms']['threshd']['cookbook']                  = node['opennms']['default_template_cookbook']
default['opennms']['thresholds']['cookbook']               = node['opennms']['default_template_cookbook']
default['opennms']['translator']['cookbook']               = node['opennms']['default_template_cookbook']
default['opennms']['trapd']['cookbook']                    = node['opennms']['default_template_cookbook']
default['opennms']['vacuumd']['cookbook']                  = node['opennms']['default_template_cookbook']
default['opennms']['web_console_view']['cookbook']         = node['opennms']['default_template_cookbook']
default['opennms']['vmware_cim']['cookbook']               = node['opennms']['default_template_cookbook']
default['opennms']['vmware']['cookbook']                   = node['opennms']['default_template_cookbook']
default['opennms']['wmi']['cookbook']                      = node['opennms']['default_template_cookbook']
default['opennms']['xml']['cookbook']                      = node['opennms']['default_template_cookbook']
default['opennms']['xmpp']['cookbook']                     = node['opennms']['default_template_cookbook']
sg = default['opennms']['snmp_graph']
sg['cookbook']                         = node['opennms']['default_template_cookbook']
sg['acmepacket']['cookbook']           = node['opennms']['default_template_cookbook']
sg['adonis']['cookbook']               = node['opennms']['default_template_cookbook']
sg['adsl']['cookbook']                 = node['opennms']['default_template_cookbook']
sg['airport']['cookbook']              = node['opennms']['default_template_cookbook']
sg['aix']['cookbook']                  = node['opennms']['default_template_cookbook']
sg['akcp']['cookbook']                 = node['opennms']['default_template_cookbook']
sg['alvarion']['cookbook']             = node['opennms']['default_template_cookbook']
sg['apc']['cookbook']                  = node['opennms']['default_template_cookbook']
sg['ascend']['cookbook']               = node['opennms']['default_template_cookbook']
sg['asterisk']['cookbook']             = node['opennms']['default_template_cookbook']
sg['bgp_ietf']['cookbook']             = node['opennms']['default_template_cookbook']
sg['bluecoat_sgproxy']['cookbook']     = node['opennms']['default_template_cookbook']
sg['bridgewave']['cookbook']           = node['opennms']['default_template_cookbook']
sg['brocade']['cookbook']              = node['opennms']['default_template_cookbook']
sg['ca_empire']['cookbook']            = node['opennms']['default_template_cookbook']
sg['checkpoint']['cookbook']           = node['opennms']['default_template_cookbook']
sg['cisco']['cookbook']                = node['opennms']['default_template_cookbook']
sg['ciscoNexus']['cookbook']           = node['opennms']['default_template_cookbook']
sg['clavister']['cookbook']            = node['opennms']['default_template_cookbook']
sg['colubris']['cookbook']             = node['opennms']['default_template_cookbook']
sg['cyclades']['cookbook']             = node['opennms']['default_template_cookbook']
sg['dell_openmanage']['cookbook']      = node['opennms']['default_template_cookbook']
sg['dell_rac']['cookbook']             = node['opennms']['default_template_cookbook']
sg['dns']['cookbook']                  = node['opennms']['default_template_cookbook']
sg['ejn']['cookbook']                  = node['opennms']['default_template_cookbook']
sg['equallogic']['cookbook']           = node['opennms']['default_template_cookbook']
sg['ericsson']['cookbook']             = node['opennms']['default_template_cookbook']
sg['extreme_networks']['cookbook']     = node['opennms']['default_template_cookbook']
sg['f5']['cookbook']                   = node['opennms']['default_template_cookbook']
sg['force10']['cookbook']              = node['opennms']['default_template_cookbook']
sg['fortinet']['cookbook']             = node['opennms']['default_template_cookbook']
sg['foundry']['cookbook']              = node['opennms']['default_template_cookbook']
sg['framerelay']['cookbook']           = node['opennms']['default_template_cookbook']
sg['host_resources']['cookbook']       = node['opennms']['default_template_cookbook']
sg['hp']['cookbook']                   = node['opennms']['default_template_cookbook']
sg['hpux']['cookbook']                 = node['opennms']['default_template_cookbook']
sg['hwg']['cookbook']                  = node['opennms']['default_template_cookbook']
sg['ipunity']['cookbook']              = node['opennms']['default_template_cookbook']
sg['jboss']['cookbook']                = node['opennms']['default_template_cookbook']
sg['juniper']['cookbook']              = node['opennms']['default_template_cookbook']
sg['jvm']['cookbook']                  = node['opennms']['default_template_cookbook']
sg['liebert']['cookbook']              = node['opennms']['default_template_cookbook']
sg['lmsensors']['cookbook']            = node['opennms']['default_template_cookbook']
sg['mailmarshal']['cookbook']          = node['opennms']['default_template_cookbook']
sg['mcast']['cookbook']                = node['opennms']['default_template_cookbook']
sg['mge']['cookbook']                  = node['opennms']['default_template_cookbook']
sg['mib2']['cookbook']                 = node['opennms']['default_template_cookbook']
sg['microsoft_exchange']['cookbook']   = node['opennms']['default_template_cookbook']
sg['microsoft']['cookbook']            = node['opennms']['default_template_cookbook']
sg['microsoft_http']['cookbook']       = node['opennms']['default_template_cookbook']
sg['microsoft_iis']['cookbook']        = node['opennms']['default_template_cookbook']
sg['microsoft_lcs']['cookbook']        = node['opennms']['default_template_cookbook']
sg['microsoft_sql']['cookbook']        = node['opennms']['default_template_cookbook']
sg['microsoft_windows']['cookbook']    = node['opennms']['default_template_cookbook']
sg['microsoft_wmi']['cookbook']        = node['opennms']['default_template_cookbook']
sg['mikrotik']['cookbook']             = node['opennms']['default_template_cookbook']
sg['mysql']['cookbook']                = node['opennms']['default_template_cookbook']
sg['netapp']['cookbook']               = node['opennms']['default_template_cookbook']
sg['netbotz']['cookbook']              = node['opennms']['default_template_cookbook']
sg['netenforcer']['cookbook']          = node['opennms']['default_template_cookbook']
sg['netscaler']['cookbook']            = node['opennms']['default_template_cookbook']
sg['netsnmp']['cookbook']              = node['opennms']['default_template_cookbook']
sg['nortel']['cookbook']               = node['opennms']['default_template_cookbook']
sg['novell']['cookbook']               = node['opennms']['default_template_cookbook']
sg['pfsense']['cookbook']              = node['opennms']['default_template_cookbook']
sg['postgresql']['cookbook']           = node['opennms']['default_template_cookbook']
sg['riverbed_steelhead']['cookbook']   = node['opennms']['default_template_cookbook']
sg['servertech']['cookbook']           = node['opennms']['default_template_cookbook']
sg['snmp_informant']['cookbook']       = node['opennms']['default_template_cookbook']
sg['sofaware_embeddedngx']['cookbook'] = node['opennms']['default_template_cookbook']
sg['sun']['cookbook']                  = node['opennms']['default_template_cookbook']
sg['trango']['cookbook']               = node['opennms']['default_template_cookbook']
sg['vmware_cim']['cookbook']           = node['opennms']['default_template_cookbook']
sg['vmware3']['cookbook']              = node['opennms']['default_template_cookbook']
sg['vmware4']['cookbook']              = node['opennms']['default_template_cookbook']
sg['vmware5']['cookbook']              = node['opennms']['default_template_cookbook']
sg['xmp']['cookbook']                  = node['opennms']['default_template_cookbook']
sg['xups']['cookbook']                 = node['opennms']['default_template_cookbook']
sg['zeus']['cookbook']                 = node['opennms']['default_template_cookbook']

# RRD locations
# defaults
default['opennms']['default_rrd_repository'] = "#{onms_home}/share/rrd/snmp/"
def_rrd_repo = "#{onms_home}/share/rrd/snmp/"
default['opennms']['default_response_rrd_repository'] = "#{onms_home}/share/rrd/response"
def_rrd_resp_repo = "#{onms_home}/share/rrd/response"
# specifics
default['opennms']['poller']['example1']['icmp']['rrd_repository']            = def_rrd_resp_repo
default['opennms']['poller']['example1']['dns']['rrd_repository']             = def_rrd_resp_repo
default['opennms']['poller']['example1']['smtp']['rrd_repository']            = def_rrd_resp_repo
default['opennms']['poller']['example1']['http']['rrd_repository']            = def_rrd_resp_repo
default['opennms']['poller']['example1']['http_8080']['rrd_repository']       = def_rrd_resp_repo
default['opennms']['poller']['example1']['http_8000']['rrd_repository']       = def_rrd_resp_repo
default['opennms']['poller']['example1']['https']['rrd_repository']           = def_rrd_resp_repo
default['opennms']['poller']['example1']['hyperichq']['rrd_repository']       = def_rrd_resp_repo
default['opennms']['poller']['example1']['ssh']['rrd_repository']             = def_rrd_resp_repo
default['opennms']['poller']['example1']['pop3']['rrd_repository']            = def_rrd_resp_repo
default['opennms']['poller']['example1']['nrpe']['rrd_repository']            = def_rrd_resp_repo
default['opennms']['poller']['example1']['nrpe_nossl']['rrd_repository']      = def_rrd_resp_repo
default['opennms']['poller']['example1']['opennms_jvm']['rrd_repository']     = def_rrd_resp_repo
default['opennms']['poller']['strafer']['strafeping']['rrd_repository']       = def_rrd_resp_repo
default['opennms']['jdbc_dc']['rrd_repository']                               = def_rrd_repo
default['opennms']['jmx_dc']['rrd_repository']                                = def_rrd_repo
default['opennms']['nsclient_datacollection']['rrd_repository']               = def_rrd_repo
default['opennms']['thresholds']['mib2']['rrd_repository']                    = def_rrd_repo
default['opennms']['thresholds']['hrstorage']['rrd_repository']               = def_rrd_repo
default['opennms']['thresholds']['cisco']['rrd_repository']                   = def_rrd_repo
default['opennms']['thresholds']['netsnmp']['rrd_repository']                 = def_rrd_repo
default['opennms']['thresholds']['netsnmp_memory_linux']['rrd_repository']    = def_rrd_repo
default['opennms']['thresholds']['netsnmp_memory_nonlinux']['rrd_repository'] = def_rrd_repo
default['opennms']['thresholds']['coffee']['rrd_repository']                  = def_rrd_repo
default['opennms']['vmware_cim']['rrd_repository']                            = def_rrd_repo
default['opennms']['vmware']['rrd_repository']                                = def_rrd_repo
default['opennms']['wmi']['rrd_repository']                                   = def_rrd_repo
default['opennms']['xml']['rrd_repository']                                   = def_rrd_repo

# users.xml
default['opennms']['users']['admin']['name']          = 'Administrator'
default['opennms']['users']['admin']['user_comments'] = 'Default administrator, do not delete'
# if you want to change the admin password to something specific you
# only need to change the password attribute - the hash will then get
# changed for you.
default['opennms']['users']['admin']['password']      = 'admin'
default['opennms']['users']['admin']['pwhash']        = '21232F297A57A5A743894A0E4A801FC3'
default['opennms']['users']['salted']                 = false

# non-default daemons
default['opennms']['services']['dhcpd']       = false
default['opennms']['services']['snmp_poller'] = false
default['opennms']['services']['linkd']       = false
default['opennms']['services']['correlator']  = false
default['opennms']['services']['tl1d']        = false
default['opennms']['services']['syslogd']     = false
default['opennms']['services']['xmlrpcd']     = false
default['opennms']['services']['asterisk_gw'] = false
default['opennms']['services']['apm']         = false
# opennms.properties
default['opennms']['properties']['dc']['rrd_base_dir']              = "#{onms_home}/share/rrd"
default['opennms']['properties']['misc']['bin_dir']                 = "#{onms_home}/bin"
default['opennms']['properties']['reporting']['template_dir']       = "#{onms_home}/etc"
default['opennms']['properties']['reporting']['report_dir']         = "#{onms_home}/share/reports"
default['opennms']['properties']['reporting']['report_logo']        = "#{onms_home}/webapps/images/logo.gif"
default['opennms']['properties']['reporting']['scheduler_enabled']  = true
# ICMP
default['opennms']['properties']['icmp']['pinger_class'] = nil # "org.opennms.netmgt.icmp.jni6.Jni6Pinger"
default['opennms']['properties']['icmp']['require_v4']   = nil
default['opennms']['properties']['icmp']['require_v6']   = nil
# SNMP
default['opennms']['properties']['snmp']['strategy_class']             = nil
default['opennms']['properties']['snmp']['smisyntaxes']                = 'opennms-snmp4j-smisyntaxes.properties'
default['opennms']['properties']['snmp']['forward_runtime_exceptions'] = false
default['opennms']['properties']['snmp']['log_factory']                = 'org.snmp4j.log.Log4jLogFactory'
default['opennms']['properties']['snmp']['allow_64bit_ipaddress']      = true
default['opennms']['properties']['snmp']['no_getbulk']                 = false
default['opennms']['properties']['snmp']['allow_snmpv2_in_v1']         = false
# Data collection
default['opennms']['properties']['dc']['store_by_group']          = false
default['opennms']['properties']['dc']['store_by_foreign_source'] = false
default['opennms']['properties']['dc']['rrd_dc_dir']              = '/snmp/'
default['opennms']['properties']['dc']['rrd_binary']              = '/usr/bin/rrdtool'
default['opennms']['properties']['dc']['decimal_format']          = nil
default['opennms']['properties']['dc']['reload_check_interval']   = nil
default['opennms']['properties']['dc']['instrumentation_class']   = nil
default['opennms']['properties']['dc']['enable_check_file_mod']   = nil
default['opennms']['properties']['dc']['cache_timeout']           = nil
default['opennms']['properties']['dc']['force_rescan']            = nil
default['opennms']['properties']['dc']['instance_limiting']       = nil
# Alarmd
default['opennms']['properties']['alarmd']['new_if_cleared_alarm_exists'] = nil
default['opennms']['properties']['alarmd']['legacy_alarm_state']          = nil
# Remote
default['opennms']['properties']['remote']['exclude_service_monitors'] = 'DHCP,NSClient,RadiusAuth,XMP'
default['opennms']['properties']['remote']['min_config_reload_int']    = nil
default['opennms']['properties']['remote']['pb_disconnect_timeout']    = nil
default['opennms']['properties']['remote']['pb_server_port']           = nil
default['opennms']['properties']['remote']['pb_registry_port']         = nil
# Ticketing
default['opennms']['properties']['ticket']['servicelayer']  = 'org.opennms.netmgt.ticketd.DefaultTicketerServiceLayer'
default['opennms']['properties']['ticket']['plugin']        = 'org.opennms.netmgt.ticketd.NullTicketerPlugin'
default['opennms']['properties']['ticket']['enabled']       = nil
default['opennms']['properties']['ticket']['link_template'] = nil
default['opennms']['properties']['ticket']['skip_create_when_cleared'] = false
default['opennms']['properties']['ticket']['skip_close_when_not_cleared'] = false
# Misc
default['opennms']['properties']['misc']['layout_applications_vertically'] = false
default['opennms']['properties']['misc']['webapp_logs_dir']                = '${install.logs.dir}'
default['opennms']['properties']['misc']['headless']                       = true
default['opennms']['properties']['misc']['find_by_service_type_query']     = nil
default['opennms']['properties']['misc']['load_snmp_data_on_init']         = nil
default['opennms']['properties']['misc']['allow_html_fields']              = nil
default['opennms']['properties']['misc']['allow_unsalted']                 = nil
# Reporting
default['opennms']['properties']['reporting']['jasper_version'] = '6.3.0'
default['opennms']['properties']['reporting']['ksc_graphs_per_line'] = 1
# Eventd IPC
default['opennms']['properties']['eventd']['proxy_host']     = nil
default['opennms']['properties']['eventd']['proxy_port']     = nil
default['opennms']['properties']['eventd']['proxy_timeout']  = nil
# RANCID
default['opennms']['properties']['rancid']['enabled']              = nil
default['opennms']['properties']['rancid']['only_rancid_adapter']  = nil
# RTC IPC
default['opennms']['properties']['rtc']['baseurl']   = 'http://localhost:8980/opennms/rtc/post'
default['opennms']['properties']['rtc']['username']  = 'rtc'
default['opennms']['properties']['rtc']['password']  = 'rtc'
default['opennms']['properties']['rtc']['pwhash']    = 'sHMy+HycWKGJC/uUMF0IGlXUXP1KhcqD0GEchFlvYTw40jT9r+zMxOb3F+phWNzX'
# MAP IPC
default['opennms']['properties']['map']['baseurl']   = 'http://localhost:8980/opennms/map/post'
default['opennms']['properties']['map']['username']  = 'map'
default['opennms']['properties']['map']['password']  = 'map'
# JETTY
default['opennms']['properties']['jetty']['port']                   = 8980
default['opennms']['properties']['jetty']['ajp']                    = nil
default['opennms']['properties']['jetty']['host']                   = nil
default['opennms']['properties']['jetty']['req_logging']            = nil
default['opennms']['properties']['jetty']['max_form_content_size']  = nil
default['opennms']['properties']['jetty']['request_header_size']    = nil
default['opennms']['properties']['jetty']['max_form_keys']          = 2000
default['opennms']['properties']['jetty']['https_port']             = nil
default['opennms']['properties']['jetty']['https_host']             = nil
default['opennms']['properties']['jetty']['keystore']               = nil
default['opennms']['properties']['jetty']['ks_password']            = nil
default['opennms']['properties']['jetty']['key_password']           = nil
default['opennms']['properties']['jetty']['cert_alias']             = nil
default['opennms']['properties']['jetty']['exclude_cipher_suites']  = nil
default['opennms']['properties']['jetty']['https_baseurl']          = nil
default['opennms']['properties']['jetty']['datetimeformat']         = nil
default['opennms']['properties']['jetty']['show_stacktrace']        = nil
default['opennms']['properties']['jetty']['topology_entity_cache_duration'] = nil
# JMS NB
default['opennms']['properties']['jms_nbi']['broker_url'] = nil
default['opennms']['properties']['jms_nbi']['activemq_username'] = nil
default['opennms']['properties']['jms_nbi']['activemq_password'] = nil
# UI
default['opennms']['properties']['ui']['acls']                        = nil
default['opennms']['properties']['ui']['ack']                         = false
default['opennms']['properties']['ui']['show_count']                  = false
default['opennms']['properties']['ui']['show_outage_nodes']           = nil
default['opennms']['properties']['ui']['show_problem_nodes']          = nil
default['opennms']['properties']['ui']['show_situations']             = nil
default['opennms']['properties']['ui']['outage_node_count']           = nil
default['opennms']['properties']['ui']['problem_node_count']          = nil
default['opennms']['properties']['ui']['situations_count']            = nil
default['opennms']['properties']['ui']['show_node_status_bar']        = nil
default['opennms']['properties']['ui']['disable_login_success_event'] = nil
default['opennms']['properties']['ui']['max_interface_count']         = nil
default['opennms']['properties']['ui']['center_url']                  = nil
# Asterisk AGI
default['opennms']['properties']['asterisk']['listen_address'] = nil
default['opennms']['properties']['asterisk']['listen_port']    = nil
default['opennms']['properties']['asterisk']['max_pool_size']  = nil
# Provisioning
default['opennms']['properties']['provisioning']['dns_server']                = '127.0.0.1'
default['opennms']['properties']['provisioning']['dns_level']                 = nil
default['opennms']['properties']['provisioning']['reverse_dns_level']         = nil
default['opennms']['properties']['provisioning']['max_concurrent_xtn']        = nil
default['opennms']['properties']['provisioning']['enable_discovery']          = nil
default['opennms']['properties']['provisioning']['enable_deletions']          = nil
default['opennms']['properties']['provisioning']['schedule_existing_rescans'] = nil
default['opennms']['properties']['provisioning']['schedule_updated_rescans']  = nil
# SMS Gateway
default['opennms']['properties']['sms']['serial_ports']  = '/dev/ttyACM0:/dev/ttyACM1:/dev/ttyACM2:/dev/ttyACM3:/dev/ttyACM4:/dev/ttyACM5'
default['opennms']['properties']['sms']['polling']       = true
# Mapping / Geocoding
default['opennms']['properties']['geo']['map_type']       = 'OpenLayers'
default['opennms']['properties']['geo']['api_key']        = ''
default['opennms']['properties']['geo']['geocoder_class'] = nil # "org.opennms.features.poller.remote.gwt.server.geocoding.NullGeocoder"
default['opennms']['properties']['geo']['rate']           = 10
default['opennms']['properties']['geo']['referrer']       = 'http://localhost/'
default['opennms']['properties']['geo']['min_quality']    = 'ZIP'
default['opennms']['properties']['geo']['email']          = ''
default['opennms']['properties']['geo']['tile_url']       = nil # "http://otile1.mqcdn.com/tiles/1.0.0/osm/${z}/${x}/${y}.png"
default['opennms']['properties']['time_series']['strategy'] = 'rrd' # newts
default['opennms']['properties']['graph_engine'] = 'backshift' # auto, png, placeholder, backshift
default['opennms']['properties']['graph_period'] = nil
default['opennms']['properties']['newts']['hostname'] = 'localhost'
default['opennms']['properties']['newts']['keyspace'] = 'newts'
default['opennms']['properties']['newts']['port'] = 9042
default['opennms']['properties']['newts']['username'] = 'cassandra'
default['opennms']['properties']['newts']['password'] = 'cassandra'
default['opennms']['properties']['newts']['read_consistency'] = 'ONE'
default['opennms']['properties']['newts']['write_consistency'] = 'ANY'
default['opennms']['properties']['newts']['max_batch_size'] = 16
default['opennms']['properties']['newts']['ring_buffer_size'] = 8192
default['opennms']['properties']['newts']['ttl'] = 31_540_000
default['opennms']['properties']['newts']['resource_shard'] = 604_800
default['opennms']['properties']['newts']['cache_strategy'] = 'org.opennms.netmgt.newts.support.GuavaSearchableResourceMetadataCache'
default['opennms']['properties']['newts']['cache_max_entries'] = 8192
default['opennms']['properties']['newts']['cache_redis_host'] = 'localhost'
default['opennms']['properties']['newts']['cache_redis_port'] = 6379
default['opennms']['properties']['newts']['nan_on_counter_wrap'] = true
default['opennms']['properties']['newts']['cache_priming_disable'] = false
default['opennms']['properties']['newts']['cache_priming_block_ms'] = 120000
default['opennms']['properties']['statusbox']['elements'] = nil # defaults to 'business-services,nodes-by-alarms,nodes-by-outages' in 21
default['opennms']['properties']['heatmap']['default_mode'] = 'alarms' # outages
default['opennms']['properties']['heatmap']['default_heatmap'] = 'categories' # or 'foreignSources' or 'monitoredServices'
default['opennms']['properties']['heatmap']['category_filter'] = '.*'
default['opennms']['properties']['heatmap']['foreign_source_filter'] = '.*'
default['opennms']['properties']['heatmap']['service_filter'] = '.*'
default['opennms']['properties']['heatmap']['only_unacknowledged'] = false
default['opennms']['properties']['grafana']['show'] = false
default['opennms']['properties']['grafana']['hostname'] = 'localhost'
default['opennms']['properties']['grafana']['port'] = 3000
default['opennms']['properties']['grafana']['api_key'] = ''
default['opennms']['properties']['grafana']['tag'] = ''
default['opennms']['properties']['grafana']['protocol'] = 'http'
default['opennms']['properties']['grafana']['connection_timeout'] = 500
default['opennms']['properties']['grafana']['so_timeout'] = 500
default['opennms']['properties']['grafana']['dashboard_limit'] = 0
default['opennms']['properties']['grafana']['base_path'] = ''
default['opennms']['properties']['vmware']['housekeeping_interval'] = nil
default['opennms']['properties']['alarmlist']['sound_enable'] = false
default['opennms']['properties']['alarmlist']['sound_status'] = 'off' # newalarm, newalarmcount
default['opennms']['properties']['alarmlist']['unackflash'] = false
default['opennms']['properties']['rest_aliases'] = '/rest,/api/v2'
default['opennms']['properties']['maxFlowAgeSeconds'] = nil
default['opennms']['properties']['ingressAndEgressRequired'] = false
default['opennms']['properties']['search_info'] = nil
# database reports - availability
default['opennms']['db_reports']['avail']['cal']['logo']                    = "#{onms_home}/etc/reports/logo.gif"
default['opennms']['db_reports']['avail']['classic']['logo']                = "#{onms_home}/etc/reports/logo.gif"
default['opennms']['db_reports']['avail']['cal']['endDate']['interval']     = 'day'
default['opennms']['db_reports']['avail']['cal']['endDate']['count']        = 1
default['opennms']['db_reports']['avail']['cal']['endDate']['hours']        = 23
default['opennms']['db_reports']['avail']['cal']['endDate']['minutes']      = 59
default['opennms']['db_reports']['avail']['classic']['endDate']['interval'] = 'day'
default['opennms']['db_reports']['avail']['classic']['endDate']['count']    = 1
default['opennms']['db_reports']['avail']['classic']['endDate']['hours']    = 23
default['opennms']['db_reports']['avail']['classic']['endDate']['minutes']  = 59
# categories.xml
default['opennms']['categories']['common_rule'] = "IPADDR != '0.0.0.0'"
default['opennms']['categories']['overall']['enable']   = true
default['opennms']['categories']['overall']['label']    = 'Overall Service Availability'
default['opennms']['categories']['overall']['comment']  = 'This category reflects availability of all services currently being monitored by OpenNMS.'
default['opennms']['categories']['overall']['normal']   = 99.99
default['opennms']['categories']['overall']['warning']  = 97
default['opennms']['categories']['overall']['services'] = []
default['opennms']['categories']['overall']['rule']     = "IPADDR != '0.0.0.0'"
default['opennms']['categories']['interfaces']['enable']   = true
default['opennms']['categories']['interfaces']['label']    = 'Network Interfaces'
default['opennms']['categories']['interfaces']['comment']  = "This category reflects the ability to 'ping' managed devices and SNMP agents.  'Ping', using the ICMP protocol, tests a devices network connectivity/availability."
default['opennms']['categories']['interfaces']['normal']   = 99.99
default['opennms']['categories']['interfaces']['warning']  = 97
default['opennms']['categories']['interfaces']['services'] = %w(ICMP SNMP)
default['opennms']['categories']['interfaces']['rule']     = "(isICMP | isSNMP) & (IPADDR != '0.0.0.0')"
default['opennms']['categories']['email']['enable']   = true
default['opennms']['categories']['email']['label']    = 'Email Servers'
default['opennms']['categories']['email']['comment']  = 'This category includes all managed interfaces which are running an Email service, including SMTP, POP3, or IMAP.  This will include MS Exchange servers running these protocols.'
default['opennms']['categories']['email']['normal']   = 99.99
default['opennms']['categories']['email']['warning']  = 97
default['opennms']['categories']['email']['services'] = %w(SMTP POP3 IMAP)
default['opennms']['categories']['email']['rule']     = 'isSMTP | isPOP3 | isIMAP'
default['opennms']['categories']['web']['enable']   = true
default['opennms']['categories']['web']['label']    = 'Web Servers'
default['opennms']['categories']['web']['comment']  = 'This category includes all managed interfaces which are running an HTTP (Web) server on port 80 or other common ports.'
default['opennms']['categories']['web']['normal']   = 99.99
default['opennms']['categories']['web']['warning']  = 97
default['opennms']['categories']['web']['services'] = ['HTTP', 'HTTPS', 'HTTP-8000', 'HTTP-8080']
default['opennms']['categories']['web']['rule']     = 'isHTTP | isHTTPS | isHTTP-8000 | isHTTP-8080'
default['opennms']['categories']['jmx']['enable']   = true
default['opennms']['categories']['jmx']['label']    = 'JMX Servers'
default['opennms']['categories']['jmx']['comment']  = 'This category includes all managed interfaces which are running JMX servers.'
default['opennms']['categories']['jmx']['normal']   = 99.99
default['opennms']['categories']['jmx']['warning']  = 97
default['opennms']['categories']['jmx']['services'] = %w(JBoss4 JBoss32 JVM)
default['opennms']['categories']['jmx']['rule']     = 'isJBoss4 | isJBoss32 | isJVM'
default['opennms']['categories']['dns']['enable']   = true
default['opennms']['categories']['dns']['label']    = 'DNS and DHCP Servers'
default['opennms']['categories']['dns']['comment']  = 'This category includes all managed interfaces which are running either DNS (name resolution) servers or DHCP servers.'
default['opennms']['categories']['dns']['normal']   = 99.99
default['opennms']['categories']['dns']['warning']  = 97
default['opennms']['categories']['dns']['services'] = %w(DNS DHCP)
default['opennms']['categories']['dns']['rule']     = 'isDNS | isDHCP'
default['opennms']['categories']['db']['enable']   = true
default['opennms']['categories']['db']['label']    = 'Database Servers'
default['opennms']['categories']['db']['comment']  = 'This category includes all managed interfaces which are currently running PostgreSQL, MySQL, SQLServer, or Oracle database servers.'
default['opennms']['categories']['db']['normal']   = 99.99
default['opennms']['categories']['db']['warning']  = 97
default['opennms']['categories']['db']['services'] = %w(MySQL Oracle Postgres SQLServer)
default['opennms']['categories']['db']['rule']     = 'isMySQL | isOracle | isPostgres | isSQLServer'
default['opennms']['categories']['other']['enable']   = true
default['opennms']['categories']['other']['label']    = 'Other Servers'
default['opennms']['categories']['other']['comment']  = 'This category includes all managed interfaces which are running FTP (file transfer protocol) servers or SSH (secure shell) servers.'
default['opennms']['categories']['other']['normal']   = 99.99
default['opennms']['categories']['other']['warning']  = 97
default['opennms']['categories']['other']['services'] = %w(FTP SSH)
default['opennms']['categories']['other']['rule']     = 'isFTP | isSSH'
default['opennms']['categories']['inet']['enable']   = true
default['opennms']['categories']['inet']['label']    = 'Internet Connectivity'
default['opennms']['categories']['inet']['comment']  = "This category reflects the ability to 'ping' the router at the ISP-end of your Internet connection."
default['opennms']['categories']['inet']['normal']   = 99.99
default['opennms']['categories']['inet']['warning']  = 97
default['opennms']['categories']['inet']['services'] = ['ICMP']
default['opennms']['categories']['inet']['rule']     = "ipaddr == '0.0.0.0'"
# chart-configuration.xml
default['opennms']['chart']['severity_enable']  = true
default['opennms']['chart']['outages_enable']   = true
default['opennms']['chart']['inventory_enable'] = true
# collectd-configuration.xml
default['opennms']['collectd']['threads'] = 50
default['opennms']['collectd']['vmware3']['enabled']                     = true
default['opennms']['collectd']['vmware3']['filter']                      = "(IPADDR != '0.0.0.0') &amp; (categoryName == 'VMware3')"
default['opennms']['collectd']['vmware3']['service']['vm']['enabled']    = true
default['opennms']['collectd']['vmware3']['service']['vm']['interval']   = 300_000
default['opennms']['collectd']['vmware3']['service']['vm']['status']     = 'on'
default['opennms']['collectd']['vmware3']['service']['vm']['collection'] = 'default-VirtualMachine3'
default['opennms']['collectd']['vmware3']['service']['vm']['threshold']  = true
default['opennms']['collectd']['vmware3']['service']['host']['enabled']    = true
default['opennms']['collectd']['vmware3']['service']['host']['interval']   = 300_000
default['opennms']['collectd']['vmware3']['service']['host']['status']     = 'on'
default['opennms']['collectd']['vmware3']['service']['host']['collection'] = 'default-HostSystem3'
default['opennms']['collectd']['vmware3']['service']['host']['threshold']  = true
default['opennms']['collectd']['vmware3']['service']['cim_host']['enabled']    = true
default['opennms']['collectd']['vmware3']['service']['cim_host']['interval']   = 300_000
default['opennms']['collectd']['vmware3']['service']['cim_host']['status']     = 'on'
default['opennms']['collectd']['vmware3']['service']['cim_host']['collection'] = 'default-ESX-HostSystem'
default['opennms']['collectd']['vmware3']['service']['cim_host']['threshold']  = true
default['opennms']['collectd']['vmware4']['enabled']                     = true
default['opennms']['collectd']['vmware4']['filter']                      = "(IPADDR != '0.0.0.0') &amp; (categoryName == 'VMware4')"
default['opennms']['collectd']['vmware4']['service']['vm']['enabled']    = true
default['opennms']['collectd']['vmware4']['service']['vm']['interval']   = 300_000
default['opennms']['collectd']['vmware4']['service']['vm']['status']     = 'on'
default['opennms']['collectd']['vmware4']['service']['vm']['collection'] = 'default-VirtualMachine4'
default['opennms']['collectd']['vmware4']['service']['vm']['threshold']  = true
default['opennms']['collectd']['vmware4']['service']['host']['enabled']    = true
default['opennms']['collectd']['vmware4']['service']['host']['interval']   = 300_000
default['opennms']['collectd']['vmware4']['service']['host']['status']     = 'on'
default['opennms']['collectd']['vmware4']['service']['host']['collection'] = 'default-HostSystem4'
default['opennms']['collectd']['vmware4']['service']['host']['threshold']  = true
default['opennms']['collectd']['vmware4']['service']['cim_host']['enabled']    = true
default['opennms']['collectd']['vmware4']['service']['cim_host']['interval']   = 300_000
default['opennms']['collectd']['vmware4']['service']['cim_host']['status']     = 'on'
default['opennms']['collectd']['vmware4']['service']['cim_host']['collection'] = 'default-ESX-HostSystem'
default['opennms']['collectd']['vmware4']['service']['cim_host']['threshold']  = true
default['opennms']['collectd']['vmware5']['enabled']                     = true
default['opennms']['collectd']['vmware5']['filter']                      = "(IPADDR != '0.0.0.0') &amp; (categoryName == 'VMware5')"
default['opennms']['collectd']['vmware5']['service']['vm']['enabled']    = true
default['opennms']['collectd']['vmware5']['service']['vm']['interval']   = 300_000
default['opennms']['collectd']['vmware5']['service']['vm']['status']     = 'on'
default['opennms']['collectd']['vmware5']['service']['vm']['collection'] = 'default-VirtualMachine5'
default['opennms']['collectd']['vmware5']['service']['vm']['threshold']  = true
default['opennms']['collectd']['vmware5']['service']['host']['enabled']    = true
default['opennms']['collectd']['vmware5']['service']['host']['interval']   = 300_000
default['opennms']['collectd']['vmware5']['service']['host']['status']     = 'on'
default['opennms']['collectd']['vmware5']['service']['host']['collection'] = 'default-HostSystem5'
default['opennms']['collectd']['vmware5']['service']['host']['threshold']  = true
default['opennms']['collectd']['vmware5']['service']['cim_host']['enabled']    = true
default['opennms']['collectd']['vmware5']['service']['cim_host']['interval']   = 300_000
default['opennms']['collectd']['vmware5']['service']['cim_host']['status']     = 'on'
default['opennms']['collectd']['vmware5']['service']['cim_host']['collection'] = 'default-ESX-HostSystem'
default['opennms']['collectd']['vmware5']['service']['cim_host']['threshold']  = true
default['opennms']['collectd']['vmware6']['enabled']                     = true
default['opennms']['collectd']['vmware6']['filter']                      = "(IPADDR != '0.0.0.0') &amp; (categoryName == 'VMware6')"
default['opennms']['collectd']['vmware6']['service']['vm']['enabled']    = true
default['opennms']['collectd']['vmware6']['service']['vm']['interval']   = 300_000
default['opennms']['collectd']['vmware6']['service']['vm']['status']     = 'on'
default['opennms']['collectd']['vmware6']['service']['vm']['collection'] = 'default-VirtualMachine6'
default['opennms']['collectd']['vmware6']['service']['vm']['threshold']  = true
default['opennms']['collectd']['vmware6']['service']['host']['enabled']    = true
default['opennms']['collectd']['vmware6']['service']['host']['interval']   = 300_000
default['opennms']['collectd']['vmware6']['service']['host']['status']     = 'on'
default['opennms']['collectd']['vmware6']['service']['host']['collection'] = 'default-HostSystem6'
default['opennms']['collectd']['vmware6']['service']['host']['threshold']  = true
default['opennms']['collectd']['vmware6']['service']['cim_host']['enabled']    = true
default['opennms']['collectd']['vmware6']['service']['cim_host']['interval']   = 300_000
default['opennms']['collectd']['vmware6']['service']['cim_host']['status']     = 'on'
default['opennms']['collectd']['vmware6']['service']['cim_host']['collection'] = 'default-ESX-HostSystem'
default['opennms']['collectd']['vmware6']['service']['cim_host']['threshold']  = true
default['opennms']['collectd']['example1']['enabled']                      = true
default['opennms']['collectd']['example1']['filter']                       = "IPADDR != '0.0.0.0'"
default['opennms']['collectd']['example1']['ipv4_range']['begin']          = '1.1.1.1'
default['opennms']['collectd']['example1']['ipv4_range']['end']            = '254.254.254.254'
default['opennms']['collectd']['example1']['ipv6_range']['begin']          = '::1'
default['opennms']['collectd']['example1']['ipv6_range']['end']            = 'ffff:ffff:ffff:ffff:ffff:ffff:ffff:ffff'
default['opennms']['collectd']['example1']['service']['snmp']['enabled'] = true
default['opennms']['collectd']['example1']['service']['snmp']['interval']   = 300_000
default['opennms']['collectd']['example1']['service']['snmp']['status']     = 'on'
default['opennms']['collectd']['example1']['service']['snmp']['collection'] = 'default'
default['opennms']['collectd']['example1']['service']['snmp']['threshold']  = true
default['opennms']['collectd']['example1']['service']['wmi']['enabled']     = true
default['opennms']['collectd']['example1']['service']['wmi']['interval']   = 300_000
default['opennms']['collectd']['example1']['service']['wmi']['status']     = 'off'
default['opennms']['collectd']['example1']['service']['wmi']['collection'] = 'default'
default['opennms']['collectd']['example1']['service']['wmi']['threshold']  = true
default['opennms']['collectd']['example1']['service']['opennms_jvm']['enabled'] = true
default['opennms']['collectd']['example1']['service']['opennms_jvm']['interval']      = 300_000
default['opennms']['collectd']['example1']['service']['opennms_jvm']['status']        = 'on'
default['opennms']['collectd']['example1']['service']['opennms_jvm']['port']          = 18_980
default['opennms']['collectd']['example1']['service']['opennms_jvm']['retry']         = 2
default['opennms']['collectd']['example1']['service']['opennms_jvm']['timeout']       = 3000
default['opennms']['collectd']['example1']['service']['opennms_jvm']['protocol']      = 'rmi'
default['opennms']['collectd']['example1']['service']['opennms_jvm']['url_path']      = '/jmxrmi'
default['opennms']['collectd']['example1']['service']['opennms_jvm']['rrd_base_name'] = 'java'
default['opennms']['collectd']['example1']['service']['opennms_jvm']['ds_name']       = 'opennms-jvm'
default['opennms']['collectd']['example1']['service']['opennms_jvm']['friendly_name'] = 'opennms-jvm'
default['opennms']['collectd']['example1']['service']['opennms_jvm']['collection']    = 'jsr160'
default['opennms']['collectd']['example1']['service']['opennms_jvm']['threshold']     = true
default['opennms']['collectd']['example1']['service']['postgresql']['enabled'] = true
default['opennms']['collectd']['example1']['service']['postgresql']['interval']   = 300_000
default['opennms']['collectd']['example1']['service']['postgresql']['status']     = 'on'
default['opennms']['collectd']['example1']['service']['postgresql']['collection'] = 'PostgreSQL'
default['opennms']['collectd']['example1']['service']['postgresql']['threshold']  = true
default['opennms']['collectd']['example1']['service']['postgresql']['driver']     = 'org.postgresql.Driver'
default['opennms']['collectd']['example1']['service']['postgresql']['user']       = 'postgres'
default['opennms']['collectd']['example1']['service']['postgresql']['password']   = 'postgres'
default['opennms']['collectd']['example1']['service']['postgresql']['url']        = 'jdbc:postgresql://OPENNMS_JDBC_HOSTNAME:5432/opennms'
# Data Collection
default['opennms']['datacollection']['default']['enabled']          = true
default['opennms']['datacollection']['default']['snmpStorageFlag']  = 'select'
default['opennms']['datacollection']['default']['rrd']['step']      = 300
default['opennms']['datacollection']['default']['rrd']['rras']      = ['RRA:AVERAGE:0.5:1:2016', 'RRA:AVERAGE:0.5:12:1488', 'RRA:AVERAGE:0.5:288:366', 'RRA:MAX:0.5:288:366', 'RRA:MIN:0.5:288:366']
default['opennms']['datacollection']['default']['mib2']             = true
default['opennms']['datacollection']['default']['threecom']         = true
default['opennms']['datacollection']['default']['acme']             = true
default['opennms']['datacollection']['default']['akcp']             = true
default['opennms']['datacollection']['default']['alvarion']         = true
default['opennms']['datacollection']['default']['apc']              = true
default['opennms']['datacollection']['default']['ascend']           = true
default['opennms']['datacollection']['default']['asterisk']         = true
default['opennms']['datacollection']['default']['bluecat']          = true
default['opennms']['datacollection']['default']['bluecoat']         = true
default['opennms']['datacollection']['default']['bridgewave']       = true
default['opennms']['datacollection']['default']['brocade']          = true
default['opennms']['datacollection']['default']['checkpoint']       = true
default['opennms']['datacollection']['default']['cisco']            = true
default['opennms']['datacollection']['default']['ciscoNexus']       = true
default['opennms']['datacollection']['default']['clavister']        = true
default['opennms']['datacollection']['default']['colubris']         = true
default['opennms']['datacollection']['default']['concord']          = true
default['opennms']['datacollection']['default']['cyclades']         = true
default['opennms']['datacollection']['default']['dell']             = true
default['opennms']['datacollection']['default']['ericsson']         = true
default['opennms']['datacollection']['default']['equallogic']       = true
default['opennms']['datacollection']['default']['extreme']          = true
default['opennms']['datacollection']['default']['f5']               = true
default['opennms']['datacollection']['default']['fortinet']         = true
default['opennms']['datacollection']['default']['force10']          = true
default['opennms']['datacollection']['default']['foundry']          = true
default['opennms']['datacollection']['default']['hp']               = true
default['opennms']['datacollection']['default']['hwg']              = true
default['opennms']['datacollection']['default']['ibm']              = true
default['opennms']['datacollection']['default']['ipunity']          = true
default['opennms']['datacollection']['default']['juniper']          = true
default['opennms']['datacollection']['default']['konica']           = true
default['opennms']['datacollection']['default']['kyocera']          = true
default['opennms']['datacollection']['default']['lexmark']          = true
default['opennms']['datacollection']['default']['liebert']          = true
default['opennms']['datacollection']['default']['makelsan']         = true
default['opennms']['datacollection']['default']['mge']              = true
default['opennms']['datacollection']['default']['microsoft']        = true
default['opennms']['datacollection']['default']['mikrotik']         = true
default['opennms']['datacollection']['default']['netapp']           = true
default['opennms']['datacollection']['default']['netbotz']          = true
default['opennms']['datacollection']['default']['netenforcer']      = true
default['opennms']['datacollection']['default']['netscaler']        = true
default['opennms']['datacollection']['default']['netscalserver']    = true
default['opennms']['datacollection']['default']['netsnmp']          = true
default['opennms']['datacollection']['default']['nortel']           = true
default['opennms']['datacollection']['default']['novell']           = true
default['opennms']['datacollection']['default']['paloalto']         = true
default['opennms']['datacollection']['default']['pfsense']          = true
default['opennms']['datacollection']['default']['powerware']        = true
default['opennms']['datacollection']['default']['postgres']         = true
default['opennms']['datacollection']['default']['ref_cpq_im']       = false # these are true >= 22, see base_templates recipe
default['opennms']['datacollection']['default']['ref_mib2_if']      = false
default['opennms']['datacollection']['default']['ref_mib2_pe']      = false
default['opennms']['datacollection']['default']['riverbed']         = true
default['opennms']['datacollection']['default']['savin']            = true
default['opennms']['datacollection']['default']['servertech']       = true
default['opennms']['datacollection']['default']['sofaware']         = true
default['opennms']['datacollection']['default']['sun']              = true
default['opennms']['datacollection']['default']['trango']           = true
default['opennms']['datacollection']['default']['wmi']              = true
default['opennms']['datacollection']['default']['xmp']              = true
default['opennms']['datacollection']['default']['zeus']             = true
default['opennms']['datacollection']['default']['vmware3']          = true
default['opennms']['datacollection']['default']['vmware4']          = true
default['opennms']['datacollection']['default']['vmware5']          = true
default['opennms']['datacollection']['default']['vmware6']          = true
default['opennms']['datacollection']['default']['vmwarecim']        = true
default['opennms']['datacollection']['ejn']['enabled']          = true
default['opennms']['datacollection']['ejn']['snmpStorageFlag']  = 'select'
default['opennms']['datacollection']['ejn']['rrd']['step']      = 180
default['opennms']['datacollection']['ejn']['rrd']['rras']      = ['RRA:AVERAGE:0.5:1:3360', 'RRA:AVERAGE:0.5:20:1488', 'RRA:AVERAGE:0.5:480:366', 'RRA:MAX:0.5:480:366', 'RRA:MIN:0.5:480:366']
default['opennms']['datacollection']['ejn']['rrd']['rras']      = ['RRA:AVERAGE:0.5:1:3360', 'RRA:AVERAGE:0.5:20:1488', 'RRA:AVERAGE:0.5:480:366', 'RRA:MAX:0.5:480:366', 'RRA:MIN:0.5:480:366']
# discovery-configuration.xml
default['opennms']['discovery']['threads']          = 1
default['opennms']['discovery']['pps']              = 1
default['opennms']['discovery']['init_sleep_ms']    = 30_000
default['opennms']['discovery']['restart_sleep_ms'] = 86_400_000
default['opennms']['discovery']['retries']          = 1
default['opennms']['discovery']['timeout']          = 2000
default['opennms']['discovery']['foreign_source']   = nil
# enlinkd-configuration.xml
default['opennms']['enlinkd']['threads'] = 5
default['opennms']['enlinkd']['init_sleep_time'] = 60_000
default['opennms']['enlinkd']['rescan_interval'] = 86_400_000
default['opennms']['enlinkd']['cdp'] = true
default['opennms']['enlinkd']['bridge'] = true
default['opennms']['enlinkd']['lldp'] = true
default['opennms']['enlinkd']['ospf'] = true
default['opennms']['enlinkd']['isis'] = true
default['opennms']['enlinkd']['topology_interval'] = 30000
default['opennms']['enlinkd']['bridge_topo_interval'] = 300000
default['opennms']['enlinkd']['max_bft'] = 100
default['opennms']['enlinkd']['disco_bridge_threads'] = 1

# eventd-configuration.xml
default['opennms']['eventd']['tcp_address']            = '127.0.0.1'
default['opennms']['eventd']['tcp_port']               = 5817
default['opennms']['eventd']['udp_address']            = '127.0.0.1'
default['opennms']['eventd']['udp_port']               = 5817
default['opennms']['eventd']['receivers']              = 5
default['opennms']['eventd']['get_next_eventid']       = "SELECT nextval('eventsNxtId')"
default['opennms']['eventd']['sock_so_timeout_req']    = true
default['opennms']['eventd']['socket_so_timeout_period'] = 3000
# events-archiver-configuration.xml
default['opennms']['events_archiver']['age'] = '7d'
default['opennms']['events_archiver']['separator'] = '#'
# javamail-configuration.properties
default['opennms']['javamail_props']['from_address']          = nil
default['opennms']['javamail_props']['mail_host']             = nil
default['opennms']['javamail_props']['mailer']                = nil
default['opennms']['javamail_props']['transport']             = nil
default['opennms']['javamail_props']['debug']                 = nil
default['opennms']['javamail_props']['smtpport']              = nil
default['opennms']['javamail_props']['smtpssl']               = nil
default['opennms']['javamail_props']['quitwait']              = nil
default['opennms']['javamail_props']['use_JMTA']              = nil
default['opennms']['javamail_props']['authenticate']          = nil
default['opennms']['javamail_props']['authenticate_user']     = nil
default['opennms']['javamail_props']['authenticate_password'] = nil
default['opennms']['javamail_props']['starttls']              = nil
default['opennms']['javamail_props']['message_content_type']  = nil
default['opennms']['javamail_props']['charset']               = nil
# javamail-configuration.xml
default['opennms']['javamail_config']['default_read_config_name'] = 'localhost'
default['opennms']['javamail_config']['default_send_config_name'] = 'localhost'
default['opennms']['javamail_config']['default_read']['attempt_interval'] = 1000
default['opennms']['javamail_config']['default_read']['delete_all_mail']  = false
default['opennms']['javamail_config']['default_read']['mail_folder']      = 'INBOX'
default['opennms']['javamail_config']['default_read']['debug']            = true
default['opennms']['javamail_config']['default_read']['properties']       = { 'mail.pop3.apop.enable' => false, 'mail.pop3.rsetbeforequit' => false }
default['opennms']['javamail_config']['default_read']['host']             = '127.0.0.1'
default['opennms']['javamail_config']['default_read']['port']             = 110
default['opennms']['javamail_config']['default_read']['ssl_enable']       = false
default['opennms']['javamail_config']['default_read']['start_tls']        = false
default['opennms']['javamail_config']['default_read']['transport']        = 'pop3'
default['opennms']['javamail_config']['default_read']['user']             = 'opennms'
default['opennms']['javamail_config']['default_read']['password']         = 'opennms'
default['opennms']['javamail_config']['default_send']['attempt_interval']   = 3000
default['opennms']['javamail_config']['default_send']['use_authentication'] = false
default['opennms']['javamail_config']['default_send']['use_jmta']           = true
default['opennms']['javamail_config']['default_send']['debug']              = true
default['opennms']['javamail_config']['default_send']['host']               = '127.0.0.1'
default['opennms']['javamail_config']['default_send']['port']               = 25
default['opennms']['javamail_config']['default_send']['char_set']           = 'us-ascii'
default['opennms']['javamail_config']['default_send']['mailer']             = 'smtpsend'
default['opennms']['javamail_config']['default_send']['content_type']       = 'text/plain'
default['opennms']['javamail_config']['default_send']['encoding']           = '7-bit'
default['opennms']['javamail_config']['default_send']['quit_wait']          = true
default['opennms']['javamail_config']['default_send']['ssl_enable']         = false
default['opennms']['javamail_config']['default_send']['start_tls']          = false
default['opennms']['javamail_config']['default_send']['transport']          = 'smtp'
default['opennms']['javamail_config']['default_send']['to']                 = 'root@localhost'
default['opennms']['javamail_config']['default_send']['from']               = 'root@[127.0.0.1]'
default['opennms']['javamail_config']['default_send']['subject']            = 'OpenNMS Test Message'
default['opennms']['javamail_config']['default_send']['body']               = 'This is an OpenNMS test message.'
default['opennms']['javamail_config']['default_send']['user']               = 'opennms'
default['opennms']['javamail_config']['default_send']['password']           = 'opennms'
# jcifs.properties
default['opennms']['jcifs']['loglevel']      = 1
default['opennms']['jcifs']['wins']          = nil
default['opennms']['jcifs']['lmhosts']       = nil
default['opennms']['jcifs']['resolve_order'] = nil
default['opennms']['jcifs']['hostname']      = nil
default['opennms']['jcifs']['retry_count']   = nil
default['opennms']['jcifs']['username']      = nil
default['opennms']['jcifs']['password']      = nil
default['opennms']['jcifs']['client_laddr']  = nil
# jdbc-datacollection-config.xml
default['opennms']['jdbc_dc']['enable_default'] = true
default['opennms']['jdbc_dc']['default']['rrd']['step'] = 300
default['opennms']['jdbc_dc']['default']['rrd']['rras'] = ['RRA:AVERAGE:0.5:1:2016', 'RRA:AVERAGE:0.5:12:1488', 'RRA:AVERAGE:0.5:288:366', 'RRA:MAX:0.5:288:366', 'RRA:MIN:0.5:288:366']
default['opennms']['jdbc_dc']['default']['event_count']['enabled'] = true
default['opennms']['jdbc_dc']['default']['event_count']['interval'] = '1 day'
default['opennms']['jdbc_dc']['default']['node_count']['enabled'] = true
default['opennms']['jdbc_dc']['enable_mysql_stats']   = true
default['opennms']['jdbc_dc']['mysql']['rrd']['step'] = 300
default['opennms']['jdbc_dc']['mysql']['rrd']['rras'] = ['RRA:AVERAGE:0.5:1:2016', 'RRA:AVERAGE:0.5:12:1488', 'RRA:AVERAGE:0.5:288:366', 'RRA:MAX:0.5:288:366', 'RRA:MIN:0.5:288:366']
default['opennms']['jdbc_dc']['mysql']['uptime']             = true
default['opennms']['jdbc_dc']['mysql']['bytes_rx']           = true
default['opennms']['jdbc_dc']['mysql']['bytes_tx']           = true
default['opennms']['jdbc_dc']['mysql']['delete']             = true
default['opennms']['jdbc_dc']['mysql']['delete_multi']       = true
default['opennms']['jdbc_dc']['mysql']['insert']             = true
default['opennms']['jdbc_dc']['mysql']['insert_select']      = true
default['opennms']['jdbc_dc']['mysql']['select']             = true
default['opennms']['jdbc_dc']['mysql']['stmt_execute']       = true
default['opennms']['jdbc_dc']['mysql']['update']             = true
default['opennms']['jdbc_dc']['mysql']['update_multi']       = true
default['opennms']['jdbc_dc']['mysql']['tmp_disk_tables']    = true
default['opennms']['jdbc_dc']['mysql']['tmp_tables']         = true
default['opennms']['jdbc_dc']['mysql']['key_buffer_size']    = true
default['opennms']['jdbc_dc']['mysql']['cache_block_size']   = true
default['opennms']['jdbc_dc']['mysql']['key_blocks_unused']  = true
default['opennms']['jdbc_dc']['mysql']['key_read_requests']  = true
default['opennms']['jdbc_dc']['mysql']['key_reads']          = true
default['opennms']['jdbc_dc']['mysql']['key_write_requests'] = true
default['opennms']['jdbc_dc']['mysql']['key_writes']         = true
default['opennms']['jdbc_dc']['mysql']['open_files']         = true
default['opennms']['jdbc_dc']['mysql']['open_tables']        = true
default['opennms']['jdbc_dc']['mysql']['table_open_cache']   = true
default['opennms']['jdbc_dc']['mysql']['questions']          = true
default['opennms']['jdbc_dc']['mysql']['slow_queries']       = true
default['opennms']['jdbc_dc']['mysql']['connections']        = true
default['opennms']['jdbc_dc']['mysql']['threads_created']    = true
default['opennms']['jdbc_dc']['mysql']['threads_cached']     = true
default['opennms']['jdbc_dc']['mysql']['threads_connected']  = true
default['opennms']['jdbc_dc']['mysql']['threads_running']    = true
default['opennms']['jdbc_dc']['enable_pgsql_stats']       = true
default['opennms']['jdbc_dc']['pgsql']['rrd']['step']     = 300
default['opennms']['jdbc_dc']['pgsql']['rrd']['rras']     = ['RRA:AVERAGE:0.5:1:2016', 'RRA:AVERAGE:0.5:12:1488', 'RRA:AVERAGE:0.5:288:366', 'RRA:MAX:0.5:288:366', 'RRA:MIN:0.5:288:366']
default['opennms']['jdbc_dc']['pgsql']['tablespace_size'] = true
default['opennms']['jdbc_dc']['pgsql']['stat_database']   = true
# jms-northbounder-config.xml
default['opennms']['jms_nbi']['cookbook']               = 'opennms'
default['opennms']['jms_nbi']['enabled']                = false
default['opennms']['jms_nbi']['nagles_delay']           = 1000
default['opennms']['jms_nbi']['batch_size']             = 100
default['opennms']['jms_nbi']['queue_size']             = 300_000
default['opennms']['jms_nbi']['message_format']         = 'ALARM ID:${alarmId} NODE:${nodeLabel}; ${logMsg}'
default['opennms']['jms_nbi']['send_as_object_message'] = false
default['opennms']['jms_nbi']['first_occurence_only']   = true
default['opennms']['jms_nbi']['jms_destination']        = 'SingleAlarmQueue'
# jmx-datacollection-config.xml
default['opennms']['jmx_dc']['enable_jboss']         = true
default['opennms']['jmx_dc']['jboss']['rrd']['step'] = 300
default['opennms']['jmx_dc']['jboss']['rrd']['rras'] = ['RRA:AVERAGE:0.5:1:2016', 'RRA:AVERAGE:0.5:12:1488', 'RRA:AVERAGE:0.5:288:366', 'RRA:MAX:0.5:288:366', 'RRA:MIN:0.5:288:366']
default['opennms']['jmx_dc']['jboss']['system_info']['enabled']    = true
default['opennms']['jmx_dc']['jboss']['default_ds_mcp']['enabled'] = true
default['opennms']['jmx_dc']['jboss']['jms_xa_cp']['enabled']      = false
default['opennms']['jmx_dc']['jboss']['jms_dm']['enabled']         = false
default['opennms']['jmx_dc']['jboss']['jms_queue']['enabled']      = false
default['opennms']['jmx_dc']['jboss']['jms_queue']['name']         = 'A'
default['opennms']['jmx_dc']['jboss']['jms_topic']['enabled']      = false
default['opennms']['jmx_dc']['jboss']['jms_topic']['name']         = 'SecuredTopic'
default['opennms']['jmx_dc']['jboss']['jms_topic']['object_name']  = 'jboss.mq.destination:service=Topic,name=securedTopic'
default['opennms']['jmx_dc']['jboss']['jms_topic']['short_name']   = 'ST'
default['opennms']['jmx_dc']['jboss']['global_request_processor']['enabled']     = true
default['opennms']['jmx_dc']['jboss']['global_request_processor']['object_name'] = 'jboss.web:type=GlobalRequestProcessor,name=http-0.0.0.0-8080'
default['opennms']['jmx_dc']['jboss']['thread_pool']['enabled']     = true
default['opennms']['jmx_dc']['jboss']['thread_pool']['object_name'] = 'jboss.web:type=ThreadPool,name=http-0.0.0.0-8080'
default['opennms']['jmx_dc']['enable_opennms']        = true
default['opennms']['jmx_dc']['jsr160']['rrd']['step'] = 300
default['opennms']['jmx_dc']['jsr160']['rrd']['rras'] = ['RRA:AVERAGE:0.5:1:2016', 'RRA:AVERAGE:0.5:12:1488', 'RRA:AVERAGE:0.5:288:366', 'RRA:MAX:0.5:288:366', 'RRA:MIN:0.5:288:366']
default['opennms']['jmx_dc']['jsr160']['queued']['enabled']                         = true
default['opennms']['jmx_dc']['jsr160']['pollerd']['enabled']                        = true
default['opennms']['jmx_dc']['jsr160']['kafka']['enabled']                          = true
default['opennms']['jmx_dc']['jsr160']['vacuumd']['enabled']                        = true
default['opennms']['jmx_dc']['jsr160']['collectd']['enabled']                       = true
default['opennms']['jmx_dc']['jsr160']['capsd']['enabled']                          = true
default['opennms']['jmx_dc']['jsr160']['jetty']['enabled']                          = true
default['opennms']['jmx_dc']['jsr160']['statsd']['enabled']                         = true
default['opennms']['jmx_dc']['jsr160']['trapd']['enabled']                          = true
default['opennms']['jmx_dc']['jsr160']['notifd']['enabled']                         = true
default['opennms']['jmx_dc']['jsr160']['jvm_memory']['enabled']                     = true
default['opennms']['jmx_dc']['jsr160']['jvm_threading']['enabled']                  = true
default['opennms']['jmx_dc']['jsr160']['jvm_class_loading']['enabled']              = true
default['opennms']['jmx_dc']['jsr160']['jvm_memory_pool_eden_space']['enabled']     = true
default['opennms']['jmx_dc']['jsr160']['jvm_memory_pool_survivor_space']['enabled'] = true
default['opennms']['jmx_dc']['jsr160']['jvm_memory_perm_gen']['enabled']            = true
default['opennms']['jmx_dc']['jsr160']['jvm_memory_pool_old_gen']['enabled']        = true
default['opennms']['jmx_dc']['jsr160']['jvm_gc_copy']['enabled']                    = true
default['opennms']['jmx_dc']['jsr160']['jvm_gc_mark_sweep_compact']['enabled']      = true
default['opennms']['jmx_dc']['jsr160']['jvm_gc_par_new']['enabled']                 = true
default['opennms']['jmx_dc']['jsr160']['jvm_gc_concurrent_mark_sweep']['enabled']   = true
default['opennms']['jmx_dc']['jsr160']['jvm_gc_ps_mark_sweep']['enabled']           = true
default['opennms']['jmx_dc']['jsr160']['jvm_gc_ps_scavenge']['enabled']             = true
# linkd-configuration.xml
default['opennms']['linkd']['threads']                      = 5
default['opennms']['linkd']['initial_sleep_time']           = 3_600_000
default['opennms']['linkd']['snmp_poll_interval']           = 18_000_000
default['opennms']['linkd']['discovery_link_interval']      = 1_800_000
default['opennms']['linkd']['package']                      = 'example1'
default['opennms']['linkd']['filter']                       = "IPADDR != '0.0.0.0'"
default['opennms']['linkd']['range_begin']                  = '1.1.1.1'
default['opennms']['linkd']['range_end']                    = '254.254.254.254'
default['opennms']['linkd']['iproutes']['enable_netscreen'] = true
default['opennms']['linkd']['iproutes']['enable_samsung']   = true
default['opennms']['linkd']['iproutes']['enable_cisco']     = true
default['opennms']['linkd']['iproutes']['enable_darwin']    = true
default['opennms']['linkd']['vlan']['enable_3com']          = true
default['opennms']['linkd']['vlan']['enable_3com3870']      = true
default['opennms']['linkd']['vlan']['enable_nortel']        = true
default['opennms']['linkd']['vlan']['enable_intel']         = true
default['opennms']['linkd']['vlan']['enable_hp']            = true
default['opennms']['linkd']['vlan']['enable_cisco']         = true
default['opennms']['linkd']['vlan']['enable_extreme']       = true
# log4j2.xml
default['opennms']['log4j2']['default_route']['size'] = '10MB'
default['opennms']['log4j2']['default_route']['rollover'] = 8
default['opennms']['log4j2']['instrumentation']['size'] = '100MB'
default['opennms']['log4j2']['instrumentation']['rollover'] = 1
default['opennms']['log4j2']['size'] = '100MB'
default['opennms']['log4j2']['access_point_monitor'] = 'WARN'
default['opennms']['log4j2']['ackd'] = 'WARN'
default['opennms']['log4j2']['actiond'] = 'WARN'
default['opennms']['log4j2']['alarmd'] = 'WARN'
default['opennms']['log4j2']['asterisk_gateway'] = 'WARN'
default['opennms']['log4j2']['archiver'] = 'WARN'
default['opennms']['log4j2']['bsmd'] = 'WARN'
default['opennms']['log4j2']['capsd'] = 'WARN'
default['opennms']['log4j2']['collectd'] = 'WARN'
default['opennms']['log4j2']['correlator'] = 'WARN'
default['opennms']['log4j2']['dhcpd'] = 'WARN'
default['opennms']['log4j2']['discovery'] = 'WARN'
default['opennms']['log4j2']['eventd'] = 'WARN'
default['opennms']['log4j2']['event_translator'] = 'WARN'
default['opennms']['log4j2']['icmp'] = 'WARN'
default['opennms']['log4j2']['ipc'] = 'WARN'
default['opennms']['log4j2']['jetty_server'] = 'WARN'
default['opennms']['log4j2']['linkd'] = 'WARN'
default['opennms']['log4j2']['enlinkd'] = 'WARN'
default['opennms']['log4j2']['manager'] = 'DEBUG'
default['opennms']['log4j2']['map'] = 'WARN'
default['opennms']['log4j2']['minion'] = 'WARN'
default['opennms']['log4j2']['model_importer'] = 'WARN'
default['opennms']['log4j2']['notifd'] = 'WARN'
default['opennms']['log4j2']['oss_qosd'] = 'WARN'
default['opennms']['log4j2']['oss_qosdrx'] = 'WARN'
default['opennms']['log4j2']['passive'] = 'WARN'
default['opennms']['log4j2']['perspective_pollerd'] = 'WARN'
default['opennms']['log4j2']['poller'] = 'WARN'
default['opennms']['log4j2']['provisiond'] = 'WARN'
default['opennms']['log4j2']['queued'] = 'WARN'
default['opennms']['log4j2']['reportd'] = 'WARN'
default['opennms']['log4j2']['reports'] = 'WARN'
default['opennms']['log4j2']['rtc'] = 'WARN'
default['opennms']['log4j2']['syslogd'] = 'WARN'
default['opennms']['log4j2']['telemetryd'] = 'WARN'
default['opennms']['log4j2']['scriptd'] = 'WARN'
default['opennms']['log4j2']['snmp'] = 'WARN'
default['opennms']['log4j2']['snmp_poller'] = 'WARN'
default['opennms']['log4j2']['syslogd'] = 'WARN'
default['opennms']['log4j2']['threshd'] = 'WARN'
default['opennms']['log4j2']['tl1d'] = 'WARN'
default['opennms']['log4j2']['trapd'] = 'WARN'
default['opennms']['log4j2']['trouble_ticketer'] = 'WARN'
default['opennms']['log4j2']['vacuumd'] = 'WARN'
default['opennms']['log4j2']['web'] = 'WARN'
default['opennms']['log4j2']['xmlrpcd'] = 'WARN'

# magic-users.properties
default['opennms']['magic_users']['admin_users']     = 'admin'
default['opennms']['magic_users']['ro_users']        = ''
default['opennms']['magic_users']['dashboard_users'] = ''
default['opennms']['magic_users']['provision_users'] = ''
default['opennms']['magic_users']['remoting_users']  = ''
default['opennms']['magic_users']['rest_users']      = 'iphone'
# map.properties
default['opennms']['map']['severity']['critical']['label'] = 'Critical'
default['opennms']['map']['severity']['critical']['color'] = 'red'
default['opennms']['map']['severity']['critical']['flash'] = true
default['opennms']['map']['severity']['major']['label'] = 'Major'
default['opennms']['map']['severity']['major']['color'] = 'orange'
default['opennms']['map']['severity']['minor']['label'] = 'Minor'
default['opennms']['map']['severity']['minor']['color'] = 'yellow'
default['opennms']['map']['severity']['warning']['label'] = 'Warning'
default['opennms']['map']['severity']['warning']['color'] = 'cyan'
default['opennms']['map']['severity']['normal']['label'] = 'Normal'
default['opennms']['map']['severity']['normal']['color'] = 'green'
default['opennms']['map']['severity']['cleared']['label'] = 'Cleared'
default['opennms']['map']['severity']['cleared']['color'] = 'white'
default['opennms']['map']['severity']['indeterminate']['label'] = 'Indeterminate'
default['opennms']['map']['severity']['indeterminate']['color'] = 'lightblue'
default['opennms']['map']['severity']['default'] = 'normal'
default['opennms']['map']['link']['ethernet']['text']      = 'Ethernet'
default['opennms']['map']['link']['fastethernet']['text']  = 'Fast Ethernet'
default['opennms']['map']['link']['fastethernet2']['text'] = 'Fast Ethernet'
default['opennms']['map']['link']['gigaethernet']['text']  = 'GigaBit Ethernet'
default['opennms']['map']['link']['gigaethernet2']['text'] = 'GigaBit Ethernet'
default['opennms']['map']['link']['serial']['text']        = 'Serial Line'
default['opennms']['map']['link']['framerelay']['text']    = 'Frame Relay'
default['opennms']['map']['link']['ieee80211']['text']     = 'WIFI'
default['opennms']['map']['link']['unknown']['text']       = 'Unknown'
default['opennms']['map']['link']['dwo']['text']           = 'DWO Connection'
default['opennms']['map']['link']['summary']['text']       = 'SummaryLink'
default['opennms']['map']['link']['default']               = 9999
default['opennms']['map']['multilink']['max']              = 3
default['opennms']['map']['multilink']['status']           = 'best'
default['opennms']['map']['multilink']['ignore_color']     = 'yellow'
default['opennms']['map']['linkstatus']['up_color']        = 'green'
default['opennms']['map']['linkstatus']['good_color']      = 'green'
default['opennms']['map']['linkstatus']['down_color']      = 'red'
default['opennms']['map']['linkstatus']['down_flash']      = 'true'
default['opennms']['map']['linkstatus']['bad_color']       = 'red'
default['opennms']['map']['linkstatus']['bad_flash']       = 'true'
default['opennms']['map']['linkstatus']['admindown_color'] = 'blue'
default['opennms']['map']['linkstatus']['testing_color']   = 'orange'
default['opennms']['map']['linkstatus']['unknown_color']   = 'grey'
default['opennms']['map']['status']['nodedown']['color']      = 'red'
default['opennms']['map']['status']['nodedown']['text']       = 'NodeDown'
default['opennms']['map']['status']['interfacedown']['color'] = 'orange'
default['opennms']['map']['status']['interfacedown']['text']  = 'InterfaceDown'
default['opennms']['map']['status']['linkdown']['color']      = 'orange'
default['opennms']['map']['status']['linkdown']['text']       = 'SNMPLinkDown'
default['opennms']['map']['status']['servicedown']['color']   = 'yellow'
default['opennms']['map']['status']['servicedown']['text']    = 'NodeLostService'
default['opennms']['map']['status']['undefined']['color']     = 'grey'
default['opennms']['map']['status']['undefined']['text']      = 'SeeEventDetails'
default['opennms']['map']['status']['nodeup']['color']        = 'green'
default['opennms']['map']['status']['nodeup']['text']         = 'NodeUp'
default['opennms']['map']['status']['default']                = 'nodeup'
default['opennms']['map']['status']['unknown_uei']            = 'undefined'
default['opennms']['map']['avail']['normal']['min']           = '99'
default['opennms']['map']['avail']['normal']['color']         = 'green'
default['opennms']['map']['avail']['warning']['min']          = '97'
default['opennms']['map']['avail']['warning']['color']        = 'yellow'
default['opennms']['map']['avail']['critical']['min']         = '0'
default['opennms']['map']['avail']['critical']['color']       = 'red'
default['opennms']['map']['avail']['critical']['flash']       = true
default['opennms']['map']['avail']['undefined']['min']        = '-1'
default['opennms']['map']['avail']['undefined']['color']      = 'grey'
default['opennms']['map']['avail']['enable']                  = true
default['opennms']['map']['icon']['desktop']          = 'png/desktop.png'
default['opennms']['map']['icon']['infrastructure']   = 'png/infrastructure.png'
default['opennms']['map']['icon']['laptop']           = 'png/laptop.png'
default['opennms']['map']['icon']['opennms']          = 'png/opennms.png'
default['opennms']['map']['icon']['other']            = 'png/other.png'
default['opennms']['map']['icon']['printer']          = 'png/printer.png'
default['opennms']['map']['icon']['server']           = 'png/server.png'
default['opennms']['map']['icon']['telephony']        = 'png/telephony.png'
default['opennms']['map']['icon']['unspecified']      = 'png/unspecified.png'
default['opennms']['map']['icon']['map']              = 'map.gif'
default['opennms']['map']['icon']['fileserver']       = 'png/fileserver.png'
default['opennms']['map']['icon']['firewall']         = 'png/firewall.png'
default['opennms']['map']['icon']['mainframe']        = 'png/mainframe.png'
default['opennms']['map']['icon']['multilayerswitch'] = 'png/multilayerswitch.png'
default['opennms']['map']['icon']['pix']              = 'png/pix.png'
default['opennms']['map']['icon']['router']           = 'png/router.png'
default['opennms']['map']['icon']['switch']           = 'png/switch.png'
default['opennms']['map']['icon']['vax']              = 'png/vax.png'
default['opennms']['map']['icon']['default_map']      = 'map'
default['opennms']['map']['icon']['default_node']     = 'unspecified'
default['opennms']['map']['cmenu']['node']['link']              = 'element/node.jsp?node=ELEMENT_ID'
default['opennms']['map']['cmenu']['node']['params']            = 'toolbar,width=1280,height=800, left=0, top=0, scrollbars=1, resizable=1'
default['opennms']['map']['cmenu']['telnet']['enabled']         = false
default['opennms']['map']['cmenu']['telnet']['link']            = 'telnet://ELEMENT_HOSTNAME'
default['opennms']['map']['cmenu']['ping']['link']              = 'map/response/ping.jsp?node=ELEMENT_ID'
default['opennms']['map']['cmenu']['ping']['params']            = 'toolbar,width=300,height=300, left=0, top=0, scrollbars=1, resizable=1'
default['opennms']['map']['cmenu']['traceroute']['link']        = 'map/response/traceroute.jsp?node=ELEMENT_ID'
default['opennms']['map']['cmenu']['traceroute']['params']      = 'toolbar,width=300,height=300, left=0, top=0, scrollbars=1, resizable=1'
default['opennms']['map']['cmenu']['alarms']['link']            = 'alarm/list.htm?sortby=id&acktype=unack&limit=20&filter=node%3DELEMENT_ID'
default['opennms']['map']['cmenu']['alarms']['params']          = 'toolbar,width=1280,height=800, left=0, top=0, scrollbars=1, resizable=1'
default['opennms']['map']['cmenu']['events']['link']            = 'event/list?filter=node%3DELEMENT_ID'
default['opennms']['map']['cmenu']['events']['params']          = 'toolbar,width=1280,height=800, left=0, top=0, scrollbars=1, resizable=1'
default['opennms']['map']['cmenu']['resource_graphs']['link']   = 'graph/chooseresource.htm?parentResourceType=node&parentResource=ELEMENT_ID&reports=all'
default['opennms']['map']['cmenu']['resource_graphs']['params'] = 'toolbar,width=1280,height=800, left=0, top=0, scrollbars=1, resizable=1'
default['opennms']['map']['severity']['map'] = 'worst'
default['opennms']['map']['enable']['reload']      = false
default['opennms']['map']['enable']['contextmenu'] = true
default['opennms']['map']['enable']['doubleclick'] = true
# microblog-configuration.xml
default['opennms']['microblog']['default_profile']['name']                = 'twitter' # or 'identica'
default['opennms']['microblog']['default_profile']['authen_username']     = 'yourusername' # relevant for identica only
default['opennms']['microblog']['default_profile']['authen_password']     = 'yourpassword' # relevant for identica only
default['opennms']['microblog']['default_profile']['oauth_ckey']          = nil # relevant for twitter only
default['opennms']['microblog']['default_profile']['oauth_csecret']       = nil # relevant for twitter only
default['opennms']['microblog']['default_profile']['oauth_atoken']        = nil # relevant for twitter only
default['opennms']['microblog']['default_profile']['oauth_atoken_secret'] = nil # relevant for twitter only
# model-importer.properties / provisiond-configuration.xml
default['opennms']['importer']['requisition_dir']    = "#{onms_home}/etc/imports"
default['opennms']['importer']['foreign_source_dir'] = "#{onms_home}/etc/foreign-sources"
default['opennms']['importer']['import_url']         = 'file:/path/to/dump.xml'
default['opennms']['importer']['schedule']           = '0 0 0 1 1 ? 2023'
default['opennms']['importer']['threads']            = 8
default['opennms']['importer']['scan_threads']       = 10
default['opennms']['importer']['rescan_threads']     = 10
default['opennms']['importer']['write_threads']      = 8
# modemConfig.properties
# NOTE: Predefined options are: mac2412, mac2414, macFA22, macFA24, macFA42, macFA44, acm0, acm1, acm2, acm3, acm4, acm5.
# To define your own, you'll need to populate custom_modem with the following keys defined: name, port, model, manufacturer, baudrate, and optionally pin. The defaults for all predefined modems are:
# port: /dev/tty(\.usbmodem)?#{name}
# model: w760i
# manufacturer: Sony Ericsson
# baudrate: 57600
default['opennms']['modem']['model'] = 'mac2412'
default['opennms']['custom_modem'] = nil
# notifd-configuration.xml
default['opennms']['notifd']['status'] = 'off'
default['opennms']['notifd']['match_all'] = true
default['opennms']['notifd']['auto_ack']['service_unresponsive'] = true
default['opennms']['notifd']['auto_ack']['service_lost']         = true
default['opennms']['notifd']['auto_ack']['interface_down']       = true
default['opennms']['notifd']['auto_ack']['node_down']            = true
default['opennms']['notifd']['auto_ack']['widespread_outage']    = true
# notificationCommands.xml
# Control which default commands are enabled. New commands can be created with the notif_command LWRP.
default['opennms']['notification_commands']['java_pager_email']   = true
default['opennms']['notification_commands']['java_email']         = true
default['opennms']['notification_commands']['text_page']          = true
default['opennms']['notification_commands']['numeric_page']       = true
default['opennms']['notification_commands']['xmpp_message']       = true
default['opennms']['notification_commands']['xmpp_group_message'] = true
default['opennms']['notification_commands']['irc_cat']            = true
default['opennms']['notification_commands']['call_work_phone']    = true
default['opennms']['notification_commands']['call_mobile_phone']  = true
default['opennms']['notification_commands']['call_home_phone']    = true
default['opennms']['notification_commands']['microblog_update']   = true
default['opennms']['notification_commands']['microblog_reply']    = true
default['opennms']['notification_commands']['microblog_dm']       = true
default['opennms']['notification_commands']['browser']            = true
# notifications.xml
default['opennms']['notifications']['interface_down']['enabled']          = true
default['opennms']['notifications']['interface_down']['status']           = 'on'
default['opennms']['notifications']['interface_down']['rule']             = "IPADDR != '0.0.0.0'"
default['opennms']['notifications']['interface_down']['destination_path'] = 'Email-Admin'
default['opennms']['notifications']['interface_down']['text_message']     = "All services are down on interface %interfaceresolve% (%interface%) \non node %nodelabel%.  New Outage records have been created \nand service level availability calculations will be impacted \nuntil this outage is resolved.  "
default['opennms']['notifications']['interface_down']['subject']          = 'Notice #%noticeid%: %interfaceresolve% (%interface%) on node %nodelabel% down.'
default['opennms']['notifications']['interface_down']['numeric_message']  = '111-%noticeid%'
default['opennms']['notifications']['node_down']['enabled']          = true
default['opennms']['notifications']['node_down']['status']           = 'on'
default['opennms']['notifications']['node_down']['destination_path'] = 'Email-Admin'
default['opennms']['notifications']['node_down']['rule']             = "IPADDR != '0.0.0.0'"
default['opennms']['notifications']['node_down']['text_message']     = "All services are down on node %nodelabel%.  New Outage records have \nbeen created and service level availability calculations will \nbe impacted until this outage is resolved.  "
default['opennms']['notifications']['node_down']['subject']          = 'Notice #%noticeid%: node %nodelabel% down.'
default['opennms']['notifications']['node_down']['numeric_message']  = '111-%noticeid%'
default['opennms']['notifications']['node_lost_service']['enabled']          = true
default['opennms']['notifications']['node_lost_service']['status']           = 'on'
default['opennms']['notifications']['node_lost_service']['destination_path'] = 'Email-Admin'
default['opennms']['notifications']['node_lost_service']['rule']             = "IPADDR != '0.0.0.0'"
default['opennms']['notifications']['node_lost_service']['text_message']     = "The %service% service poll on interface %interfaceresolve% (%interface%) \non node %nodelabel% failed at %time%. "
default['opennms']['notifications']['node_lost_service']['subject']          = 'Notice #%noticeid%: %service% down on %interfaceresolve% (%interface%) on node %nodelabel%.'
default['opennms']['notifications']['node_lost_service']['numeric_message']  = '111-%noticeid%'
default['opennms']['notifications']['node_added']['enabled']          = true
default['opennms']['notifications']['node_added']['status']           = 'on'
default['opennms']['notifications']['node_added']['destination_path'] = 'Email-Admin'
default['opennms']['notifications']['node_added']['rule']             = "IPADDR != '0.0.0.0'"
default['opennms']['notifications']['node_added']['text_message']     = "OpenNMS has discovered a new node named\n%parm[nodelabel]%. Please be advised."
default['opennms']['notifications']['node_added']['subject']          = 'Notice #%noticeid%: %parm[nodelabel]% discovered.'
default['opennms']['notifications']['node_added']['numeric_message']  = '111-%noticeid%'
default['opennms']['notifications']['interface_deleted']['enabled']          = true
default['opennms']['notifications']['interface_deleted']['status']           = 'on'
default['opennms']['notifications']['interface_deleted']['destination_path'] = 'Email-Admin'
default['opennms']['notifications']['interface_deleted']['rule']             = "IPADDR != '0.0.0.0'"
default['opennms']['notifications']['interface_deleted']['text_message']     = "Due to extended downtime or operator action, the interface %interfaceresolve% (%interface%) \non node %nodelabel% has been deleted from OpenNMS's polling database."
default['opennms']['notifications']['interface_deleted']['subject']          = 'Notice #%noticeid%: [OpenNMS] %interfaceresolve% (%interface%) on node %nodelabel% deleted.'
default['opennms']['notifications']['interface_deleted']['numeric_message']  = '111-%noticeid%'
default['opennms']['notifications']['high_threshold']['enabled']          = true
default['opennms']['notifications']['high_threshold']['status']           = 'on'
default['opennms']['notifications']['high_threshold']['destination_path'] = 'Email-Admin'
default['opennms']['notifications']['high_threshold']['description']      = 'A monitored device has hit a high threshold'
default['opennms']['notifications']['high_threshold']['rule']             = "IPADDR != '0.0.0.0'"
default['opennms']['notifications']['high_threshold']['text_message']     = 'A Threshold has been exceeded on node: %nodelabel%, interface:%interface%. The parameter %parm[ds]% reached a value of %parm[value]% while the threshold is %parm[threshold]%. This alert will be rearmed when %parm[ds]% reaches %parm[rearm]%.'
default['opennms']['notifications']['high_threshold']['subject']          = 'Notice #%noticeid%: High Threshold for %parm[ds]% on node %nodelabel%.'
default['opennms']['notifications']['high_threshold']['numeric_message']  = nil
default['opennms']['notifications']['low_threshold']['enabled']          = true
default['opennms']['notifications']['low_threshold']['status']           = 'on'
default['opennms']['notifications']['low_threshold']['destination_path'] = 'Email-Admin'
default['opennms']['notifications']['low_threshold']['description']      = 'A monitored device has hit a low threshold'
default['opennms']['notifications']['low_threshold']['rule']             = "IPADDR != '0.0.0.0'"
default['opennms']['notifications']['low_threshold']['text_message']     = 'A Threshold has been exceeded on node: %nodelabel%, interface:%interface%. The parameter %parm[ds]% reached a value of %parm[value]% while the threshold is %parm[threshold]%. This alert will be rearmed when %parm[ds]% reaches %parm[rearm]%.'
default['opennms']['notifications']['low_threshold']['subject']          = 'Notice #%noticeid%: Low Threshold for %parm[ds]% on node %nodelabel%.'
default['opennms']['notifications']['low_threshold']['numeric_message']  = nil
default['opennms']['notifications']['low_threshold_rearmed']['enabled']          = true
default['opennms']['notifications']['low_threshold_rearmed']['status']           = 'on'
default['opennms']['notifications']['low_threshold_rearmed']['destination_path'] = 'Email-Admin'
default['opennms']['notifications']['low_threshold_rearmed']['description']      = 'A monitored device has recovered from a low threshold'
default['opennms']['notifications']['low_threshold_rearmed']['rule']             = "IPADDR != '0.0.0.0'"
default['opennms']['notifications']['low_threshold_rearmed']['text_message']     = 'A Threshold has returned to normal on node: %nodelabel%, interface:%interface%. The parameter %parm[ds]% reached a value of %parm[value]% with a rearm threshold of %parm[rearm]%. This threshold for this alert was %parm[threshold]%.'
default['opennms']['notifications']['low_threshold_rearmed']['subject']          = 'Notice #%noticeid%: Low Threshold Rearmed for %parm[ds]% on node %nodelabel%.'
default['opennms']['notifications']['low_threshold_rearmed']['numeric_message']  = nil
default['opennms']['notifications']['high_threshold_rearmed']['enabled']          = true
default['opennms']['notifications']['high_threshold_rearmed']['status']           = 'on'
default['opennms']['notifications']['high_threshold_rearmed']['destination_path'] = 'Email-Admin'
default['opennms']['notifications']['high_threshold_rearmed']['description']      = 'A monitored device has recovered from a high threshold'
default['opennms']['notifications']['high_threshold_rearmed']['rule']             = "IPADDR != '0.0.0.0'"
default['opennms']['notifications']['high_threshold_rearmed']['text_message']     = 'A Threshold has returned to normal on node: %nodelabel%, interface:%interface%. The parameter %parm[ds]% reached a value of %parm[value]% with a rearm threshold of %parm[rearm]%. This threshold for this alert was %parm[threshold]%.'
default['opennms']['notifications']['high_threshold_rearmed']['subject']          = 'Notice #%noticeid%: High Threshold Rearmed for %parm[ds]% on node %nodelabel%.'
default['opennms']['notifications']['high_threshold_rearmed']['numeric_message']  = nil
# nsclient-datacollection-config.xml
default['opennms']['nsclient_datacollection']['enable_default']                   = true
default['opennms']['nsclient_datacollection']['default']['rrd']['step']           = 300
default['opennms']['nsclient_datacollection']['default']['rrd']['rras']           = ['RRA:AVERAGE:0.5:1:2016', 'RRA:AVERAGE:0.5:12:1488', 'RRA:AVERAGE:0.5:288:366', 'RRA:MAX:0.5:288:366', 'RRA:MIN:0.5:288:366']
default['opennms']['nsclient_datacollection']['default']['processor']['enabled']  = true
default['opennms']['nsclient_datacollection']['default']['processor']['interval'] = 3_600_000
default['opennms']['nsclient_datacollection']['default']['system']['enabled'] = true
default['opennms']['nsclient_datacollection']['default']['system']['interval'] = 86_400_000
default['opennms']['nsclient_datacollection']['default']['iis']['enabled'] = true
default['opennms']['nsclient_datacollection']['default']['iis']['interval'] = 86_400_000
default['opennms']['nsclient_datacollection']['default']['exchange']['enabled'] = true
default['opennms']['nsclient_datacollection']['default']['exchange']['interval'] = 86_400_000
default['opennms']['nsclient_datacollection']['default']['dns']['enabled'] = true
default['opennms']['nsclient_datacollection']['default']['dns']['interval'] = 86_400_000
default['opennms']['nsclient_datacollection']['default']['sqlserver']['enabled'] = true
default['opennms']['nsclient_datacollection']['default']['sqlserver']['interval'] = 86_400_000
default['opennms']['nsclient_datacollection']['default']['biztalk']['enabled'] = true
default['opennms']['nsclient_datacollection']['default']['biztalk']['interval'] = 86_400_000
default['opennms']['nsclient_datacollection']['default']['live']['enabled'] = true
default['opennms']['nsclient_datacollection']['default']['live']['interval'] = 86_400_000
default['opennms']['nsclient_datacollection']['default']['mailmarshal']['enabled'] = true
default['opennms']['nsclient_datacollection']['default']['mailmarshal']['interval'] = 86_400_000
# poller-configuration.xml
default['opennms']['poller']['threads']                         = 30
default['opennms']['poller']['service_unresponsive_enabled']    = false
default['opennms']['poller']['node_outage']['status']           = 'on'
default['opennms']['poller']['node_outage']['critical_service'] = 'ICMP'
default['opennms']['poller']['example1']['enabled'] = true
default['opennms']['poller']['example1']['filter'] = "IPADDR != '0.0.0.0'"
default['opennms']['poller']['example1']['ipv4_range']['begin'] = '1.1.1.1'
default['opennms']['poller']['example1']['ipv4_range']['end']   = '254.254.254.254'
default['opennms']['poller']['example1']['ipv6_range']['begin'] = '::1'
default['opennms']['poller']['example1']['ipv6_range']['end']   = 'ffff:ffff:ffff:ffff:ffff:ffff:ffff:ffff'
default['opennms']['poller']['example1']['rrd']['step']   = 300
default['opennms']['poller']['example1']['rrd']['rras']   = ['RRA:AVERAGE:0.5:1:2016', 'RRA:AVERAGE:0.5:12:1488', 'RRA:AVERAGE:0.5:288:366', 'RRA:MAX:0.5:288:366', 'RRA:MIN:0.5:288:366']
default['opennms']['poller']['example1']['icmp']['interval']       = 300_000
default['opennms']['poller']['example1']['icmp']['user_defined']   = false
default['opennms']['poller']['example1']['icmp']['status']         = 'on'
default['opennms']['poller']['example1']['icmp']['retry']          = 2
default['opennms']['poller']['example1']['icmp']['timeout']        = 3000
default['opennms']['poller']['example1']['icmp']['rrd_base_name']  = 'icmp'
default['opennms']['poller']['example1']['icmp']['ds_name']        = 'icmp'
default['opennms']['poller']['example1']['dns']['interval']             = 300_000
default['opennms']['poller']['example1']['dns']['user_defined']         = false
default['opennms']['poller']['example1']['dns']['status']               = 'on'
default['opennms']['poller']['example1']['dns']['retry']                = 2
default['opennms']['poller']['example1']['dns']['timeout']              = 5000
default['opennms']['poller']['example1']['dns']['port']                 = 53
default['opennms']['poller']['example1']['dns']['lookup']               = 'localhost'
default['opennms']['poller']['example1']['dns']['fatal_response_codes'] = '2,3,5'
default['opennms']['poller']['example1']['dns']['rrd_base_name']  = 'dns'
default['opennms']['poller']['example1']['dns']['ds_name']        = 'dns'
default['opennms']['poller']['example1']['smtp']['interval']       = 300_000
default['opennms']['poller']['example1']['smtp']['user_defined']   = false
default['opennms']['poller']['example1']['smtp']['status']         = 'on'
default['opennms']['poller']['example1']['smtp']['retry']          = 1
default['opennms']['poller']['example1']['smtp']['timeout']        = 3000
default['opennms']['poller']['example1']['smtp']['port']           = 25
default['opennms']['poller']['example1']['smtp']['rrd_base_name']  = 'smtp'
default['opennms']['poller']['example1']['smtp']['ds_name']        = 'smtp'
default['opennms']['poller']['example1']['ftp']['interval']       = 300_000
default['opennms']['poller']['example1']['ftp']['user_defined']   = false
default['opennms']['poller']['example1']['ftp']['status']         = 'on'
default['opennms']['poller']['example1']['ftp']['retry']          = 1
default['opennms']['poller']['example1']['ftp']['timeout']        = 3000
default['opennms']['poller']['example1']['ftp']['port']           = 21
default['opennms']['poller']['example1']['ftp']['userid']         = ''
default['opennms']['poller']['example1']['ftp']['password']       = ''
default['opennms']['poller']['example1']['snmp']['interval']       = 300_000
default['opennms']['poller']['example1']['snmp']['user_defined']   = false
default['opennms']['poller']['example1']['snmp']['status']         = 'on'
default['opennms']['poller']['example1']['snmp']['oid']            = '.1.3.6.1.2.1.1.2.0'
default['opennms']['poller']['example1']['http']['interval']       = 300_000
default['opennms']['poller']['example1']['http']['user_defined']   = false
default['opennms']['poller']['example1']['http']['status']         = 'on'
default['opennms']['poller']['example1']['http']['retry']          = 1
default['opennms']['poller']['example1']['http']['timeout']        = 3000
default['opennms']['poller']['example1']['http']['port']           = 80
default['opennms']['poller']['example1']['http']['url']            = '/'
default['opennms']['poller']['example1']['http']['rrd_base_name']  = 'http'
default['opennms']['poller']['example1']['http']['ds_name']        = 'http'
default['opennms']['poller']['example1']['http_8080']['interval']       = 300_000
default['opennms']['poller']['example1']['http_8080']['user_defined']   = false
default['opennms']['poller']['example1']['http_8080']['status']         = 'on'
default['opennms']['poller']['example1']['http_8080']['retry']          = 1
default['opennms']['poller']['example1']['http_8080']['timeout']        = 3000
default['opennms']['poller']['example1']['http_8080']['port']           = 8080
default['opennms']['poller']['example1']['http_8080']['url']            = '/'
default['opennms']['poller']['example1']['http_8080']['rrd_base_name']  = 'http-8080'
default['opennms']['poller']['example1']['http_8080']['ds_name']        = 'http-8080'
default['opennms']['poller']['example1']['http_8000']['interval']       = 300_000
default['opennms']['poller']['example1']['http_8000']['user_defined']   = false
default['opennms']['poller']['example1']['http_8000']['status']         = 'on'
default['opennms']['poller']['example1']['http_8000']['retry']          = 1
default['opennms']['poller']['example1']['http_8000']['timeout']        = 3000
default['opennms']['poller']['example1']['http_8000']['port']           = 8000
default['opennms']['poller']['example1']['http_8000']['url']            = '/'
default['opennms']['poller']['example1']['http_8000']['rrd_base_name']  = 'http-8000'
default['opennms']['poller']['example1']['http_8000']['ds_name']        = 'http-8000'
default['opennms']['poller']['example1']['https']['interval']       = 300_000
default['opennms']['poller']['example1']['https']['user_defined']   = false
default['opennms']['poller']['example1']['https']['status']         = 'on'
default['opennms']['poller']['example1']['https']['retry']          = 1
default['opennms']['poller']['example1']['https']['timeout']        = 5000
default['opennms']['poller']['example1']['https']['port']           = 443
default['opennms']['poller']['example1']['https']['url']            = '/'
default['opennms']['poller']['example1']['https']['rrd_base_name']  = 'https'
default['opennms']['poller']['example1']['https']['ds_name']        = 'https'
default['opennms']['poller']['example1']['hyperic_agent']['interval']       = 300_000
default['opennms']['poller']['example1']['hyperic_agent']['user_defined']   = false
default['opennms']['poller']['example1']['hyperic_agent']['status']         = 'on'
default['opennms']['poller']['example1']['hyperic_agent']['retry']          = 1
default['opennms']['poller']['example1']['hyperic_agent']['timeout']        = 2200
default['opennms']['poller']['example1']['hyperic_agent']['port']           = 2144
default['opennms']['poller']['example1']['hyperichq']['interval']       = 300_000
default['opennms']['poller']['example1']['hyperichq']['user_defined']   = false
default['opennms']['poller']['example1']['hyperichq']['status']         = 'on'
default['opennms']['poller']['example1']['hyperichq']['retry']          = 1
default['opennms']['poller']['example1']['hyperichq']['timeout']        = 3000
default['opennms']['poller']['example1']['hyperichq']['rrd_base_name']  = 'hyperic-hq'
default['opennms']['poller']['example1']['hyperichq']['ds_name']        = 'hyperic-hq'
default['opennms']['poller']['example1']['hyperichq']['page_sequence']['login']['path'] = '/Login.do'
default['opennms']['poller']['example1']['hyperichq']['page_sequence']['login']['port'] = 7080
default['opennms']['poller']['example1']['hyperichq']['page_sequence']['login']['success_match'] = '(HQ Login)|(Sign in to Hyperic HQ)'
default['opennms']['poller']['example1']['hyperichq']['page_sequence']['auth']['path'] = '/j_security_check.do'
default['opennms']['poller']['example1']['hyperichq']['page_sequence']['auth']['port'] = 7080
default['opennms']['poller']['example1']['hyperichq']['page_sequence']['auth']['method'] = 'POST'
default['opennms']['poller']['example1']['hyperichq']['page_sequence']['auth']['failure_match'] = '(?s)(The username or password provided does not match our records)|(You are not signed in)'
default['opennms']['poller']['example1']['hyperichq']['page_sequence']['auth']['failure_message'] = 'HQ Login in Failed'
default['opennms']['poller']['example1']['hyperichq']['page_sequence']['auth']['success_match'] = 'HQ Dashboard'
default['opennms']['poller']['example1']['hyperichq']['page_sequence']['auth']['parameters']['j_username'] = 'hqadmin'
default['opennms']['poller']['example1']['hyperichq']['page_sequence']['auth']['parameters']['j_password'] = 'hqadmin'
default['opennms']['poller']['example1']['hyperichq']['page_sequence']['logout']['path'] = '/Logout.do'
default['opennms']['poller']['example1']['hyperichq']['page_sequence']['logout']['port'] = 7080
default['opennms']['poller']['example1']['hyperichq']['page_sequence']['logout']['success_match'] = 'HQ Login'
default['opennms']['poller']['example1']['mysql']['interval']       = 300_000
default['opennms']['poller']['example1']['mysql']['user_defined']   = false
default['opennms']['poller']['example1']['mysql']['status']         = 'on'
default['opennms']['poller']['example1']['mysql']['retry']          = 1
default['opennms']['poller']['example1']['mysql']['timeout']        = 3000
default['opennms']['poller']['example1']['mysql']['port']           = 3306
default['opennms']['poller']['example1']['mysql']['banner']         = '*'
default['opennms']['poller']['example1']['sqlserver']['interval']       = 300_000
default['opennms']['poller']['example1']['sqlserver']['user_defined']   = false
default['opennms']['poller']['example1']['sqlserver']['status']         = 'on'
default['opennms']['poller']['example1']['sqlserver']['retry']          = 1
default['opennms']['poller']['example1']['sqlserver']['timeout']        = 3000
default['opennms']['poller']['example1']['sqlserver']['port']           = 1433
default['opennms']['poller']['example1']['sqlserver']['banner']         = '*'
default['opennms']['poller']['example1']['oracle']['interval']       = 300_000
default['opennms']['poller']['example1']['oracle']['user_defined']   = false
default['opennms']['poller']['example1']['oracle']['status']         = 'on'
default['opennms']['poller']['example1']['oracle']['retry']          = 1
default['opennms']['poller']['example1']['oracle']['timeout']        = 3000
default['opennms']['poller']['example1']['oracle']['port']           = 1521
default['opennms']['poller']['example1']['oracle']['banner']         = '*'
default['opennms']['poller']['example1']['postgres']['interval']       = 300_000
default['opennms']['poller']['example1']['postgres']['user_defined']   = false
default['opennms']['poller']['example1']['postgres']['status']         = 'on'
default['opennms']['poller']['example1']['postgres']['retry']          = 1
default['opennms']['poller']['example1']['postgres']['timeout']        = 3000
default['opennms']['poller']['example1']['postgres']['port']           = 5432
default['opennms']['poller']['example1']['postgres']['banner']         = '*'
default['opennms']['poller']['example1']['ssh']['interval']       = 300_000
default['opennms']['poller']['example1']['ssh']['user_defined']   = false
default['opennms']['poller']['example1']['ssh']['status']         = 'on'
default['opennms']['poller']['example1']['ssh']['retry']          = 1
default['opennms']['poller']['example1']['ssh']['timeout']        = 3000
default['opennms']['poller']['example1']['ssh']['port']           = 22
default['opennms']['poller']['example1']['ssh']['banner']         = 'SSH'
default['opennms']['poller']['example1']['ssh']['rrd_base_name']  = 'ssh'
default['opennms']['poller']['example1']['ssh']['ds_name']        = 'ssh'
default['opennms']['poller']['example1']['imap']['interval']       = 300_000
default['opennms']['poller']['example1']['imap']['user_defined']   = false
default['opennms']['poller']['example1']['imap']['status']         = 'on'
default['opennms']['poller']['example1']['imap']['retry']          = 1
default['opennms']['poller']['example1']['imap']['timeout']        = 3000
default['opennms']['poller']['example1']['imap']['port']           = 143
default['opennms']['poller']['example1']['pop3']['interval']       = 300_000
default['opennms']['poller']['example1']['pop3']['user_defined']   = false
default['opennms']['poller']['example1']['pop3']['status']         = 'on'
default['opennms']['poller']['example1']['pop3']['retry']          = 1
default['opennms']['poller']['example1']['pop3']['timeout']        = 3000
default['opennms']['poller']['example1']['pop3']['port']           = 110
default['opennms']['poller']['example1']['pop3']['rrd_base_name']  = 'pop3'
default['opennms']['poller']['example1']['pop3']['ds_name']        = 'pop3'
default['opennms']['poller']['example1']['nrpe']['interval']       = 300_000
default['opennms']['poller']['example1']['nrpe']['user_defined']   = false
default['opennms']['poller']['example1']['nrpe']['status']         = 'on'
default['opennms']['poller']['example1']['nrpe']['retry']          = 3
default['opennms']['poller']['example1']['nrpe']['timeout']        = 3000
default['opennms']['poller']['example1']['nrpe']['port']           = 5666
default['opennms']['poller']['example1']['nrpe']['command']        = '_NRPE_CHECK'
default['opennms']['poller']['example1']['nrpe']['padding']        = 2
default['opennms']['poller']['example1']['nrpe']['ds_name']        = 'nrpe'
default['opennms']['poller']['example1']['nrpe_nossl']['interval']       = 300_000
default['opennms']['poller']['example1']['nrpe_nossl']['user_defined']   = false
default['opennms']['poller']['example1']['nrpe_nossl']['status']         = 'on'
default['opennms']['poller']['example1']['nrpe_nossl']['usessl']         = false
default['opennms']['poller']['example1']['nrpe_nossl']['retry']          = 3
default['opennms']['poller']['example1']['nrpe_nossl']['timeout']        = 3000
default['opennms']['poller']['example1']['nrpe_nossl']['port']           = 5666
default['opennms']['poller']['example1']['nrpe_nossl']['command']        = '_NRPE_CHECK'
default['opennms']['poller']['example1']['nrpe_nossl']['padding']        = 2
default['opennms']['poller']['example1']['nrpe_nossl']['ds_name']        = 'nrpe'
default['opennms']['poller']['example1']['win_task_sched']['interval']     = 300_000
default['opennms']['poller']['example1']['win_task_sched']['user_defined'] = false
default['opennms']['poller']['example1']['win_task_sched']['status']       = 'on'
default['opennms']['poller']['example1']['win_task_sched']['service_name'] = 'Task Scheduler'
default['opennms']['poller']['example1']['opennms_jvm']['interval']       = 300_000
default['opennms']['poller']['example1']['opennms_jvm']['user_defined']   = false
default['opennms']['poller']['example1']['opennms_jvm']['status']         = 'on'
default['opennms']['poller']['example1']['opennms_jvm']['retry']          = 2
default['opennms']['poller']['example1']['opennms_jvm']['timeout']        = 3000
default['opennms']['poller']['example1']['opennms_jvm']['port']           = 18_980
default['opennms']['poller']['example1']['opennms_jvm']['factory']        = 'PASSWORD-CLEAR'
default['opennms']['poller']['example1']['opennms_jvm']['username']       = 'admin'
default['opennms']['poller']['example1']['opennms_jvm']['ds_name']        = 'opennms-jvm'
default['opennms']['poller']['example1']['opennms_jvm']['friendly_name']  = 'opennms-jvm'
default['opennms']['poller']['example1']['opennms_jvm']['password']       = node['opennms']['users']['admin']['password']
default['opennms']['poller']['example1']['vmware_host']['interval']       = 300_000
default['opennms']['poller']['example1']['vmware_host']['user_defined']   = false
default['opennms']['poller']['example1']['vmware_host']['status']         = 'on'
default['opennms']['poller']['example1']['vmware_host']['retry']          = 2
default['opennms']['poller']['example1']['vmware_host']['timeout']        = 3000
default['opennms']['poller']['example1']['vmware_entity']['interval']       = 300_000
default['opennms']['poller']['example1']['vmware_entity']['user_defined']   = false
default['opennms']['poller']['example1']['vmware_entity']['status']         = 'on'
default['opennms']['poller']['example1']['vmware_entity']['retry']          = 2
default['opennms']['poller']['example1']['vmware_entity']['timeout']        = 3000
default['opennms']['poller']['strafer']['enabled'] = true
default['opennms']['poller']['strafer']['filter'] = "IPADDR != '0.0.0.0'"
default['opennms']['poller']['strafer']['ipv4_range']['begin'] = '10.1.1.1'
default['opennms']['poller']['strafer']['ipv4_range']['end']   = '10.1.1.10'
default['opennms']['poller']['strafer']['ipv6_range']['enabled'] = false
default['opennms']['poller']['strafer']['ipv6_range']['begin'] = '::1'
default['opennms']['poller']['strafer']['ipv6_range']['end']   = 'ffff:ffff:ffff:ffff:ffff:ffff:ffff:ffff'
default['opennms']['poller']['strafer']['rrd']['step'] = '300'
default['opennms']['poller']['strafer']['rrd']['rras'] = ['RRA:AVERAGE:0.5:1:2016', 'RRA:AVERAGE:0.5:12:1488', 'RRA:AVERAGE:0.5:288:366', 'RRA:MAX:0.5:288:366', 'RRA:MIN:0.5:288:366']
default['opennms']['poller']['strafer']['strafeping']['interval']           = 300_000
default['opennms']['poller']['strafer']['strafeping']['user_defined']       = false
default['opennms']['poller']['strafer']['strafeping']['status']             = 'on'
default['opennms']['poller']['strafer']['strafeping']['retry']              = 0
default['opennms']['poller']['strafer']['strafeping']['timeout']            = 3000
default['opennms']['poller']['strafer']['strafeping']['ping_count']         = 20
default['opennms']['poller']['strafer']['strafeping']['failure_ping_count'] = 20
default['opennms']['poller']['strafer']['strafeping']['wait_interval']      = 50
default['opennms']['poller']['strafer']['strafeping']['rrd_base_name']      = 'strafeping'
# remedy.properties
default['opennms']['remedy']['username']                     = 'opennmstnn'
default['opennms']['remedy']['password']                     = 'TNNwsC4ll'
default['opennms']['remedy']['authentication']               = 'ARSystem'
default['opennms']['remedy']['locale']                       = 'it_IT'
default['opennms']['remedy']['timezone']                     = 'CET'
default['opennms']['remedy']['endpoint']                     = 'http://172.20.0.76:8180/arsys/services/ARService?server=itts3h&webService=HPD_IncidentInterface_WS'
default['opennms']['remedy']['portname']                     = 'HPD_IncidentInterface_WSPortTypeSoap'
default['opennms']['remedy']['createendpoint']               = 'http://172.20.0.76:8180/arsys/services/ARService?server=itts3h&webService=HPD_IncidentInterface_Create_WS'
default['opennms']['remedy']['createportname']               = 'HPD_IncidentInterface_Create_WSPortTypeSoap'
default['opennms']['remedy']['targetgroups']                 = 'TNnet:Tetranet'
default['opennms']['remedy']['assignedgroups']               = { 'TNnet' => 'TNnet', 'Tetranet' => 'TNnet - Tetranet' }
default['opennms']['remedy']['assignedsupportcompanies']     = { 'TNnet' => 'Trentino Network srl', 'Tetranet' => 'Trentino Network srl' }
default['opennms']['remedy']['assignedsupportorganizations'] = { 'TNnet' => 'Centro Gestione Rete', 'Tetranet' => 'Centro Gestione Rete' }
default['opennms']['remedy']['assignedgroup']                = 'TNnet'
default['opennms']['remedy']['firstname']                    = 'Opennms'
default['opennms']['remedy']['lastname']                     = 'Tnn'
default['opennms']['remedy']['serviceCI']                    = 'Trentino Network Connettivit\uFFFD [C.TNNCN]'
default['opennms']['remedy']['serviceCIReconID']             = 'RE00505688005e3s-nTg4KEI5gFSov'
default['opennms']['remedy']['assignedsupportcompany']       = 'Trentino Network srl'
default['opennms']['remedy']['assignedsupportorganization']  = 'Centro Gestione Rete'
default['opennms']['remedy']['categorizationtier1']          = 'Incident'
default['opennms']['remedy']['categorizationtier2']          = 'Generic'
default['opennms']['remedy']['categorizationtier3']          = 'Non bloccante'
default['opennms']['remedy']['service_type']                  = 'Infrastructure Event'
default['opennms']['remedy']['reported_source']               = 'Direct Input'
default['opennms']['remedy']['impact']                       = '4-Minor/Localized'
default['opennms']['remedy']['urgency']                      = '4-Low'
default['opennms']['remedy']['reason_reopen']                = 'Pending Original Incident'
default['opennms']['remedy']['resolution']                   = 'Chiusura da OpenNMS Web Service'
default['opennms']['remedy']['reason_resolved']              = 'Automated Resolution Reported'
default['opennms']['remedy']['reason_cancelled']             = 'No longer a Causal CI'
# reportd-configuration.xml
default['opennms']['reportd']['persist_reports'] = 'yes'
default['opennms']['reportd']['storage_location'] = "#{onms_home}/share/reports/"
# response adhoc graphs
default['opennms']['response_adhoc_graph']['command_prefix'] = nil # lets you customize the entire command prefix
# respons-graph.properties
# There's a response_graph LWRP to add new response graphs. This just lets you change
# some defaults and disable the out-of-the-box graphs
default['opennms']['response_graph']['image_format']        = 'png' # can be gif, jpg or png but only png works with both rrdtool and jrobin
default['opennms']['response_graph']['command_prefix']      = nil # lets you customize the entire command prefix
default['opennms']['response_graph']['default_font_size']   = 7
default['opennms']['response_graph']['title_font_size']     = 10
default['opennms']['response_graph']['icmp']                = true
default['opennms']['response_graph']['avail']               = true
default['opennms']['response_graph']['dhcp']                = true
default['opennms']['response_graph']['dns']                 = true
default['opennms']['response_graph']['http']                = true
default['opennms']['response_graph']['https']               = true
default['opennms']['response_graph']['http_8080']           = true
default['opennms']['response_graph']['http_8000']           = true
default['opennms']['response_graph']['mail']                = true
default['opennms']['response_graph']['pop3']                = true
default['opennms']['response_graph']['radius']              = true
default['opennms']['response_graph']['smtp']                = true
default['opennms']['response_graph']['ssh']                 = true
default['opennms']['response_graph']['jboss']               = true
default['opennms']['response_graph']['snmp']                = true
default['opennms']['response_graph']['ldap']                = true
default['opennms']['response_graph']['strafeping']          = true
# you'll need to define more colors if your ping count is higher than 20
# Also only prints STACKs for numbers with 2 colors defined.
default['opennms']['response_graph']['strafeping_colors'][20] = ['#f0f0f0']
default['opennms']['response_graph']['strafeping_colors'][19] = ['#dddddd', '#ff0000']
default['opennms']['response_graph']['strafeping_colors'][18] = ['#cacaca']
default['opennms']['response_graph']['strafeping_colors'][17] = ['#b7b7b7']
default['opennms']['response_graph']['strafeping_colors'][16] = ['#a4a4a4']
default['opennms']['response_graph']['strafeping_colors'][15] = ['#919191']
default['opennms']['response_graph']['strafeping_colors'][14] = ['#7e7e7e']
default['opennms']['response_graph']['strafeping_colors'][13] = ['#6b6b6b']
default['opennms']['response_graph']['strafeping_colors'][12] = ['#585858']
default['opennms']['response_graph']['strafeping_colors'][11] = ['#454545']
default['opennms']['response_graph']['strafeping_colors'][10] = ['#535353', '#dd00ff']
default['opennms']['response_graph']['strafeping_colors'][9] = ['#666666']
default['opennms']['response_graph']['strafeping_colors'][8]  = ['#797979']
default['opennms']['response_graph']['strafeping_colors'][7]  = ['#8c8c8c']
default['opennms']['response_graph']['strafeping_colors'][6]  = ['#9f9f9f']
default['opennms']['response_graph']['strafeping_colors'][5]  = ['#b2b2b2']
default['opennms']['response_graph']['strafeping_colors'][4]  = ['#c5c5c5', '#7e00ff']
default['opennms']['response_graph']['strafeping_colors'][3]  = ['#d8d8d8', '#5e00ff']
default['opennms']['response_graph']['strafeping_colors'][2]  = ['#ebebeb', '#0059ff']
default['opennms']['response_graph']['strafeping_colors'][1]  = ['#fefefe', '#00b8ff']
default['opennms']['response_graph']['memcached_bytes']     = true
default['opennms']['response_graph']['memcached_bytesrw']   = true
default['opennms']['response_graph']['memcached_uptime']    = true
default['opennms']['response_graph']['memcached_rusage']    = true
default['opennms']['response_graph']['memcached_items']     = true
default['opennms']['response_graph']['memcached_conns']     = true
default['opennms']['response_graph']['memcached_tconns']    = false
default['opennms']['response_graph']['memcached_cmds']      = true
default['opennms']['response_graph']['memcached_gets']      = true
default['opennms']['response_graph']['memcached_evictions'] = true
default['opennms']['response_graph']['memcached_threads']   = true
default['opennms']['response_graph']['memcached_struct']    = true
default['opennms']['response_graph']['ciscoping_time']      = true
# because I'm lazy, you can't disable ciscoping_success. Feel free to add logic to not print a comma and \ on the last graph in the list if you want.

# rrd-configuration.properties
default['opennms']['rrd']['strategy_class']                          = nil
default['opennms']['rrd']['interface_jar']                           = nil
default['opennms']['rrd']['jrrd']                                    = nil
default['opennms']['rrd']['file_extension']                          = nil
default['opennms']['rrd']['queue']['use']                            = true
default['opennms']['rrd']['queue']['writethreads']                   = 2
default['opennms']['rrd']['queue']['queuecreates']                   = false
default['opennms']['rrd']['queue']['prioritize_significant_updates'] = false
default['opennms']['rrd']['queue']['max_insig_update_seconds']       = 0
default['opennms']['rrd']['queue']['modulus']                        = 10_000
default['opennms']['rrd']['queue']['insig_hwmark']                   = 0
default['opennms']['rrd']['queue']['sig_hwmark']                     = 0
default['opennms']['rrd']['queue']['queue_hwmark']                   = 0
default['opennms']['rrd']['queue']['log_cat']                        = nil
default['opennms']['rrd']['queue']['write_thread']['sleep_time']     = 50
default['opennms']['rrd']['queue']['write_thread']['exit_delay']     = 60_000
default['opennms']['rrd']['jrobin']['backend_factory']               = nil
default['opennms']['rrd']['usetcp']                                  = false
default['opennms']['rrd']['tcp']['host']                             = nil
default['opennms']['rrd']['tcp']['port']                             = nil
# rtc-configuration.xml
default['opennms']['rtc']['updaters']                      = 10
default['opennms']['rtc']['senders']                       = 5
default['opennms']['rtc']['rolling_window']                = '24h'
default['opennms']['rtc']['max_events_before_resend']      = 100
default['opennms']['rtc']['low_threshold_interval']        = '20s'
default['opennms']['rtc']['high_threshold_interval']       = '45s'
default['opennms']['rtc']['user_refresh_interval']         = '2m'
default['opennms']['rtc']['errors_before_url_unsubscribe'] = 5
# site-status-views.xml
default['opennms']['site_status_views']['default_view']['name'] = 'default'
# Array of single element hashes of {label => name}, like [{"Routers" => "Routers"}, {"Switches" => "Switches"}, {"Servers" => "Servers"}]
# which duplicates the default setting.
# If it was just be a single hash but then you wouldn't get defined ordering of elements.
default['opennms']['site_status_views']['default_view']['rows'] = nil
# smsPhonebook.properties
default['opennms']['sms_phonebook']['entries'] = { '127.0.0.1' => '+19195551212' }
# snmp-adhoc-graph.properties
default['opennms']['snmp_adhoc_graph']['image_format'] = 'png' # or gif, or jpg, but png is te only cross-tool compatible format
default['opennms']['snmp_adhoc_graph']['command_prefix'] = nil # lets you customize entire command prefix
# snmp-graph.properties / snmp-graph.properties.d/*
default['opennms']['snmp_graph']['image_format']         = 'png' # or gif, or jpg, but png is the only cross-tool compatible format
default['opennms']['snmp_graph']['command_prefix']       = nil # lets you customize the entire command prefix
default['opennms']['snmp_graph']['default_font_size']    = 7
default['opennms']['snmp_graph']['title_font_size']      = 10
default['opennms']['snmp_graph']['default_ksc_graph']    = 'mib2.HCbits'
default['opennms']['snmp_graph']['include_dir']          = 'snmp-graph.properties.d'
default['opennms']['snmp_graph']['include_rescan']       = nil
# default['opennms']['snmp_graph']['onms_queued_updates']  = true
# default['opennms']['snmp_graph']['onms_queued_pending']  = true
default['opennms']['snmp_graph']['acmepacket']['enabled'] = true
default['opennms']['snmp_graph']['adonis']['enabled']    = true
default['opennms']['snmp_graph']['adsl']['enabled']      = true
default['opennms']['snmp_graph']['airport']['enabled']   = true
default['opennms']['snmp_graph']['aix']['enabled']       = true
default['opennms']['snmp_graph']['akcp']['enabled']      = true
default['opennms']['snmp_graph']['alvarion']['enabled']  = true
default['opennms']['snmp_graph']['apc']['enabled']       = true
default['opennms']['snmp_graph']['ascend']['enabled']    = true
default['opennms']['snmp_graph']['asterisk']['enabled']  = true
default['opennms']['snmp_graph']['bgp_ietf']['enabled']  = true
default['opennms']['snmp_graph']['bluecoat_sgproxy']['enabled'] = true
default['opennms']['snmp_graph']['bridgewave']['enabled'] = true
default['opennms']['snmp_graph']['brocade']['enabled'] = true
default['opennms']['snmp_graph']['ca_empire']['enabled'] = true
default['opennms']['snmp_graph']['checkpoint']['enabled'] = true
default['opennms']['snmp_graph']['cisco']['enabled'] = true
default['opennms']['snmp_graph']['ciscoNexus']['enabled'] = true
default['opennms']['snmp_graph']['clavister']['enabled'] = true
default['opennms']['snmp_graph']['colubris']['enabled']  = true
default['opennms']['snmp_graph']['cyclades']['enabled']  = true
default['opennms']['snmp_graph']['dell_openmanage']['enabled'] = true
default['opennms']['snmp_graph']['dell_rac']['enabled']  = true
default['opennms']['snmp_graph']['dns']['enabled']       = true
default['opennms']['snmp_graph']['ejn']['enabled']       = true
default['opennms']['snmp_graph']['equallogic']['enabled'] = true
default['opennms']['snmp_graph']['ericsson']['enabled'] = true
default['opennms']['snmp_graph']['extreme_networks']['enabled'] = true
default['opennms']['snmp_graph']['f5']['enabled']        = true
default['opennms']['snmp_graph']['force10']['enabled']   = true
default['opennms']['snmp_graph']['fortinet']['enabled']  = true
default['opennms']['snmp_graph']['foundry']['enabled']   = true
default['opennms']['snmp_graph']['framerelay']['enabled'] = true
default['opennms']['snmp_graph']['host_resources']['enabled'] = true
default['opennms']['snmp_graph']['hp']['enabled']        = true
default['opennms']['snmp_graph']['hpux']['enabled']      = true
default['opennms']['snmp_graph']['hwg']['enabled']       = true
default['opennms']['snmp_graph']['ipunity']['enabled']   = true
default['opennms']['snmp_graph']['jboss']['enabled']     = true
default['opennms']['snmp_graph']['juniper']['enabled']   = true
default['opennms']['snmp_graph']['jvm']['enabled']       = true
default['opennms']['snmp_graph']['liebert']['enabled']   = true
default['opennms']['snmp_graph']['lmsensors']['enabled'] = true
default['opennms']['snmp_graph']['mailmarshal']['enabled'] = true
default['opennms']['snmp_graph']['mcast']['enabled']     = true
default['opennms']['snmp_graph']['mge']['enabled']       = true
default['opennms']['snmp_graph']['mib2']['enabled']      = true
default['opennms']['snmp_graph']['microsoft_exchange']['enabled'] = true
default['opennms']['snmp_graph']['microsoft']['enabled'] = true
default['opennms']['snmp_graph']['microsoft_http']['enabled'] = true
default['opennms']['snmp_graph']['microsoft_iis']['enabled']  = true
default['opennms']['snmp_graph']['microsoft_lcs']['enabled']  = true
default['opennms']['snmp_graph']['microsoft_sql']['enabled']  = true
default['opennms']['snmp_graph']['microsoft_windows']['enabled'] = true
default['opennms']['snmp_graph']['microsoft_wmi']['enabled'] = true
default['opennms']['snmp_graph']['mikrotik']['enabled']  = true
default['opennms']['snmp_graph']['mysql']['enabled']     = true
default['opennms']['snmp_graph']['netapp']['enabled']    = true
default['opennms']['snmp_graph']['netbotz']['enabled']   = true
default['opennms']['snmp_graph']['netenforcer']['enabled'] = true
default['opennms']['snmp_graph']['netscaler']['enabled'] = true
default['opennms']['snmp_graph']['netsnmp']['enabled']   = true
default['opennms']['snmp_graph']['nortel']['enabled']    = true
default['opennms']['snmp_graph']['novell']['enabled']    = true
default['opennms']['snmp_graph']['pfsense']['enabled']   = true
default['opennms']['snmp_graph']['postgresql']['enabled'] = true
default['opennms']['snmp_graph']['riverbed_steelhead']['enabled'] = true
default['opennms']['snmp_graph']['servertech']['enabled'] = true
default['opennms']['snmp_graph']['snmp_informant']['enabled'] = true
default['opennms']['snmp_graph']['sofaware_embeddedngx']['enabled'] = true
default['opennms']['snmp_graph']['sun']['enabled']       = true
default['opennms']['snmp_graph']['trango']['enabled']    = true
default['opennms']['snmp_graph']['vmware_cim']['enabled'] = true
default['opennms']['snmp_graph']['vmware3']['enabled']   = true
default['opennms']['snmp_graph']['vmware4']['enabled']   = true
default['opennms']['snmp_graph']['vmware5']['enabled']   = true
default['opennms']['snmp_graph']['xmp']['enabled']       = true
default['opennms']['snmp_graph']['xups']['enabled']      = true
default['opennms']['snmp_graph']['zeus']['enabled']      = true
# snmp-interface-poller-configuration.xml
default['opennms']['snmp_iface_poller']['threads']                               = 30
default['opennms']['snmp_iface_poller']['service']                               = 'SNMP'
default['opennms']['snmp_iface_poller']['upvalues']                               = 1
default['opennms']['snmp_iface_poller']['downvalues']                               = 2
# array of service names
default['opennms']['snmp_iface_poller']['node_outage']                           = %w(ICMP SNMP)
default['opennms']['snmp_iface_poller']['example1']['filter']                    = "IPADDR != '0.0.0.0'"
default['opennms']['snmp_iface_poller']['example1']['ipv4_range']['begin']       = '1.1.1.1'
default['opennms']['snmp_iface_poller']['example1']['ipv4_range']['end']         = '1.1.1.1'
default['opennms']['snmp_iface_poller']['example1']['ipv6_range']['begin']       = '::1'
default['opennms']['snmp_iface_poller']['example1']['ipv6_range']['end']         = '::1'
default['opennms']['snmp_iface_poller']['example1']['interface']['name']         = 'Ethernet'
default['opennms']['snmp_iface_poller']['example1']['interface']['criteria']     = 'snmpiftype = 6'
default['opennms']['snmp_iface_poller']['example1']['interface']['interval']     = 300_000
default['opennms']['snmp_iface_poller']['example1']['interface']['user_defined'] = false
default['opennms']['snmp_iface_poller']['example1']['interface']['status']       = 'on'
# statsd-configuration.xml
default['opennms']['statsd']['throughput']['top_n_inOctets']               = false
default['opennms']['statsd']['response_time_reports']['top_10_weekly']     = false
default['opennms']['statsd']['response_time_reports']['top_10_this_month'] = false
default['opennms']['statsd']['response_time_reports']['top_10_last_month'] = false
default['opennms']['statsd']['response_time_reports']['top_10_this_year']  = false
# support.properties
default['opennms']['support']['queueid'] = ''
default['opennms']['support']['timeout'] = 6000
default['opennms']['support']['retry']   = 0
# surveillance-views.xml
default['opennms']['surveillance_views']['default_view'] = 'default'
default['opennms']['surveillance_views']['default']      = true
# syslog-northbounder-configuration.xml
default['opennms']['syslog_north']['use_defaults']       = true
default['opennms']['syslog_north']['enabled']            = false
default['opennms']['syslog_north']['nagles_delay']       = 1000
default['opennms']['syslog_north']['batch_size']         = 100
default['opennms']['syslog_north']['queue_size']         = 300_000
default['opennms']['syslog_north']['message_format']     = 'ALARM ID:${alarmId} NODE:${nodeLabel}; ${logMsg}'
default['opennms']['syslog_north']['destination']['name']            = 'localTest'
default['opennms']['syslog_north']['destination']['host']            = '127.0.0.1'
default['opennms']['syslog_north']['destination']['port']            = '514'
default['opennms']['syslog_north']['destination']['ip_protocol']     = 'UDP'
default['opennms']['syslog_north']['destination']['facility']        = 'LOCAL0'
default['opennms']['syslog_north']['destination']['max_length']      = 1024
default['opennms']['syslog_north']['destination']['send_local_name'] = true
default['opennms']['syslog_north']['destination']['send_local_time'] = true
default['opennms']['syslog_north']['destination']['truncate']        = false
default['opennms']['syslog_north']['uei']['node_down'] = false
default['opennms']['syslog_north']['uei']['node_up']   = false
# syslogd-configuration.xml
default['opennms']['syslogd']['port']                   = 10_514
default['opennms']['syslogd']['new_suspect']            = false
default['opennms']['syslogd']['parser']                 = 'org.opennms.netmgt.syslogd.CustomSyslogParser'
default['opennms']['syslogd']['forwarding_regexp']      = '^.*\s(19|20)\d\d([-/.])(0[1-9]|1[012])\2(0[1-9]|[12][0-9]|3[01])(\s+)(\S+)(\s)(\S.+)'
default['opennms']['syslogd']['matching_group_host']    = 6
default['opennms']['syslogd']['matching_group_message'] = 8
default['opennms']['syslogd']['discard_uei']            = 'DISCARD-MATCHING-MESSAGES'
default['opennms']['syslogd']['timezone']               = ''
default['opennms']['syslogd']['apache_httpd']           = true
default['opennms']['syslogd']['linux_kernel']           = true
default['opennms']['syslogd']['openssh']                = true
default['opennms']['syslogd']['postfix']                = true
default['opennms']['syslogd']['procmail'] = true
default['opennms']['syslogd']['sudo'] = true
# threshd-configuration.xml
default['opennms']['threshd']['threads']                      = 5
default['opennms']['threshd']['mib2']['filter']               = "IPADDR != '0.0.0.0'"
default['opennms']['threshd']['mib2']['ipv4_range']['begin']  = '1.1.1.1'
default['opennms']['threshd']['mib2']['ipv4_range']['end']    = '254.254.254.254'
default['opennms']['threshd']['mib2']['ipv6_range']['begin']  = '::1'
default['opennms']['threshd']['mib2']['ipv6_range']['end']    = 'ffff:ffff:ffff:ffff:ffff:ffff:ffff:ffff'
default['opennms']['threshd']['mib2']['snmp']['interval']     = 300_000
default['opennms']['threshd']['mib2']['snmp']['user_defined'] = false
default['opennms']['threshd']['mib2']['snmp']['status']       = 'on'
default['opennms']['threshd']['hrstorage']['filter']               = "IPADDR != '0.0.0.0' &amp; (nodeSysOID LIKE '.1.3.6.1.4.1.311.%' | nodeSysOID LIKE '.1.3.6.1.4.1.2.3.1.2.1.1.3.%')"
default['opennms']['threshd']['hrstorage']['ipv4_range']['begin']  = '1.1.1.1'
default['opennms']['threshd']['hrstorage']['ipv4_range']['end']    = '254.254.254.254'
default['opennms']['threshd']['hrstorage']['ipv6_range']['begin']  = '::1'
default['opennms']['threshd']['hrstorage']['ipv6_range']['end']    = 'ffff:ffff:ffff:ffff:ffff:ffff:ffff:ffff'
default['opennms']['threshd']['hrstorage']['snmp']['interval']     = 300_000
default['opennms']['threshd']['hrstorage']['snmp']['user_defined'] = false
default['opennms']['threshd']['hrstorage']['snmp']['status']       = 'on'
default['opennms']['threshd']['cisco']['filter']               = "IPADDR != '0.0.0.0' &amp; nodeSysOID LIKE '.1.3.6.1.4.1.9.%'"
default['opennms']['threshd']['cisco']['ipv4_range']['begin']  = '1.1.1.1'
default['opennms']['threshd']['cisco']['ipv4_range']['end']    = '254.254.254.254'
default['opennms']['threshd']['cisco']['ipv6_range']['begin']  = '::1'
default['opennms']['threshd']['cisco']['ipv6_range']['end']    = 'ffff:ffff:ffff:ffff:ffff:ffff:ffff:ffff'
default['opennms']['threshd']['cisco']['snmp']['interval']     = 300_000
default['opennms']['threshd']['cisco']['snmp']['user_defined'] = false
default['opennms']['threshd']['cisco']['snmp']['status']       = 'on'
default['opennms']['threshd']['netsnmp']['filter']               = "IPADDR != '0.0.0.0' &amp; (nodeSysOID LIKE '.1.3.6.1.4.1.2021.%' | nodeSysOID LIKE '.1.3.6.1.4.1.8072.%')"
default['opennms']['threshd']['netsnmp']['ipv4_range']['begin']  = '1.1.1.1'
default['opennms']['threshd']['netsnmp']['ipv4_range']['end']    = '254.254.254.254'
default['opennms']['threshd']['netsnmp']['ipv6_range']['begin']  = '::1'
default['opennms']['threshd']['netsnmp']['ipv6_range']['end']    = 'ffff:ffff:ffff:ffff:ffff:ffff:ffff:ffff'
default['opennms']['threshd']['netsnmp']['snmp']['interval']     = 300_000
default['opennms']['threshd']['netsnmp']['snmp']['user_defined'] = false
default['opennms']['threshd']['netsnmp']['snmp']['status']       = 'on'
default['opennms']['threshd']['netsnmp_memory_linux']['filter']               = "IPADDR != '0.0.0.0' &amp; nodeSysOID == '.1.3.6.1.4.1.8072.3.2.10'"
default['opennms']['threshd']['netsnmp_memory_linux']['ipv4_range']['begin']  = '1.1.1.1'
default['opennms']['threshd']['netsnmp_memory_linux']['ipv4_range']['end']    = '254.254.254.254'
default['opennms']['threshd']['netsnmp_memory_linux']['ipv6_range']['begin']  = '::1'
default['opennms']['threshd']['netsnmp_memory_linux']['ipv6_range']['end']    = 'ffff:ffff:ffff:ffff:ffff:ffff:ffff:ffff'
default['opennms']['threshd']['netsnmp_memory_linux']['snmp']['interval']     = 300_000
default['opennms']['threshd']['netsnmp_memory_linux']['snmp']['user_defined'] = false
default['opennms']['threshd']['netsnmp_memory_linux']['snmp']['status']       = 'on'
default['opennms']['threshd']['netsnmp_memory_nonlinux']['filter']               = "IPADDR != '0.0.0.0' &amp; (nodeSysOID LIKE '.1.3.6.1.4.1.2021.%' | nodeSysOID LIKE '.1.3.6.1.4.1.8072.%') &amp; nodeSysOID != '.1.3.6.1.4.1.8072.3.2.10'"
default['opennms']['threshd']['netsnmp_memory_nonlinux']['ipv4_range']['begin']  = '1.1.1.1'
default['opennms']['threshd']['netsnmp_memory_nonlinux']['ipv4_range']['end']    = '254.254.254.254'
default['opennms']['threshd']['netsnmp_memory_nonlinux']['ipv6_range']['begin']  = '::1'
default['opennms']['threshd']['netsnmp_memory_nonlinux']['ipv6_range']['end']    = 'ffff:ffff:ffff:ffff:ffff:ffff:ffff:ffff'
default['opennms']['threshd']['netsnmp_memory_nonlinux']['snmp']['interval']     = 300_000
default['opennms']['threshd']['netsnmp_memory_nonlinux']['snmp']['user_defined'] = false
default['opennms']['threshd']['netsnmp_memory_nonlinux']['snmp']['status']       = 'on'
# thresholds.xml
default['opennms']['thresholds']['mib2']['enabled']                           = true
default['opennms']['thresholds']['hrstorage']['enabled']                      = true
default['opennms']['thresholds']['cisco']['enabled']                          = true
default['opennms']['thresholds']['netsnmp']['enabled']                        = true
default['opennms']['thresholds']['netsnmp_memory_linux']['enabled']           = true
default['opennms']['thresholds']['netsnmp_memory_nonlinux']['enabled']        = true
default['opennms']['thresholds']['coffee']['enabled']                         = true
# translator-configuration.xml
default['opennms']['translator']['snmp_link_down']                = true
default['opennms']['translator']['snmp_link_up']                  = true
default['opennms']['translator']['hyperic']                       = true
default['opennms']['translator']['cisco_config_man']              = true
default['opennms']['translator']['juniper_cfg_change']            = true
default['opennms']['translator']['telemetry_clock_skew_detected'] = true
# trapd-configuration.xml
default['opennms']['trapd']['port']        = 162
default['opennms']['trapd']['new_suspect'] = false
# vacuumd-configuration.xml
default['opennms']['vacuumd']['period']                             = 86_400_000
default['opennms']['vacuumd']['statement']['topo_delete_nodes']     = true
default['opennms']['vacuumd']['statement']['delete_at_interfaces']  = true
default['opennms']['vacuumd']['statement']['delete_dl_interfaces']  = true
default['opennms']['vacuumd']['statement']['delete_ipr_interfaces'] = true
default['opennms']['vacuumd']['statement']['delete_vlans']          = true
default['opennms']['vacuumd']['statement']['delete_stp_interfaces'] = true
default['opennms']['vacuumd']['statement']['delete_stp_nodes']      = true
default['opennms']['vacuumd']['statement']['delete_snmp_interfaces'] = true
default['opennms']['vacuumd']['statement']['delete_nodes']          = true
default['opennms']['vacuumd']['statement']['delete_ip_interfaces']  = true
default['opennms']['vacuumd']['statement']['delete_if_services']    = true
default['opennms']['vacuumd']['statement']['delete_events']         = true
default['opennms']['vacuumd']['statement']['delete_values_json_key']               = true
default['opennms']['vacuumd']['statement']['delete_values_blob_key']               = true
default['opennms']['vacuumd']['automations']['cosmic_clear']                       = true
default['opennms']['vacuumd']['automations']['clean_up']                           = true
default['opennms']['vacuumd']['automations']['full_clean_up']                      = true
default['opennms']['vacuumd']['automations']['gc']                                 = true
default['opennms']['vacuumd']['automations']['full_gc']                            = true
default['opennms']['vacuumd']['automations']['unclear']                            = true
default['opennms']['vacuumd']['automations']['escalation']                         = true
default['opennms']['vacuumd']['automations']['purge_statistics_reports']           = true
default['opennms']['vacuumd']['automations']['clear_path_outages']                 = true
default['opennms']['vacuumd']['automations']['create_tickets']                     = true
default['opennms']['vacuumd']['automations']['create_critical_ticket']             = true
default['opennms']['vacuumd']['automations']['update_tickets']                     = true
default['opennms']['vacuumd']['automations']['close_cleared_alarm_tickets']        = true
default['opennms']['vacuumd']['automations']['clear_alarms_for_closed_tickets']    = true
default['opennms']['vacuumd']['automations']['clean_up_rp_status_changes']         = true
default['opennms']['vacuumd']['automations']['maintenance_check']                  = false
default['opennms']['vacuumd']['automations']['access_points_table']                = false
default['opennms']['vacuumd']['triggers']['select_closed_ticket_state_for_problem_alarms'] = true
default['opennms']['vacuumd']['triggers']['select_null_ticket_state_alarms']               = true
default['opennms']['vacuumd']['triggers']['select_critial_open_alarms']                    = true
default['opennms']['vacuumd']['triggers']['select_not_null_ticket_state_alarms']           = true
default['opennms']['vacuumd']['triggers']['select_cleared_alarm_with_open_ticket_state']   = true
default['opennms']['vacuumd']['triggers']['select_suspect_alarms']                         = true
default['opennms']['vacuumd']['triggers']['select_cleared_alarms']                         = true
default['opennms']['vacuumd']['triggers']['select_resolvers']                              = true
default['opennms']['vacuumd']['triggers']['select_expiration_maintenance']                 = false
default['opennms']['vacuumd']['triggers']['select_access_points_missing_from_table']       = false
default['opennms']['vacuumd']['triggers']['select_past_cleared_alarms']          = true
default['opennms']['vacuumd']['triggers']['select_all_past_cleared_alarms']      = true
default['opennms']['vacuumd']['triggers']['select_alarms_to_gc']                 = true
default['opennms']['vacuumd']['triggers']['select_alarms_to_full_gc']            = true
default['opennms']['vacuumd']['triggers']['select_path_outages_nodes']           = true
default['opennms']['vacuumd']['actions']['acknowledge_alarm']                    = true
default['opennms']['vacuumd']['actions']['update_automation_time']               = true
default['opennms']['vacuumd']['actions']['escalate_alarm']                       = true
default['opennms']['vacuumd']['actions']['reset_severity']                       = true
default['opennms']['vacuumd']['actions']['garbage_collect_7_4']                  = true
default['opennms']['vacuumd']['actions']['garbage_collect_8_1']                  = false
default['opennms']['vacuumd']['actions']['full_garbage_collect_7_4']             = true
default['opennms']['vacuumd']['actions']['full_garbage_collect_8_1']             = false
default['opennms']['vacuumd']['actions']['delete_past_cleared_alarms']           = true
default['opennms']['vacuumd']['actions']['delete_all_past_cleared_alarms']       = true
default['opennms']['vacuumd']['actions']['clear_problems']                       = true
default['opennms']['vacuumd']['actions']['clear_closed_ticket_alarms']           = true
default['opennms']['vacuumd']['actions']['delete_purgeable_statistics_reports']  = true
default['opennms']['vacuumd']['actions']['do_nothing_action']                    = true
default['opennms']['vacuumd']['actions']['clean_up_rp_status_changes']           = true
default['opennms']['vacuumd']['actions']['maintenance_expiration_warning']       = false
default['opennms']['vacuumd']['actions']['access_points_table']                  = false
default['opennms']['vacuumd']['actions']['clear_path_outages']                   = true
default['opennms']['vacuumd']['auto_events']['escalation_event']                 = true
default['opennms']['vacuumd']['action_events']['create_ticket']                  = true
default['opennms']['vacuumd']['action_events']['update_ticket']                  = true
default['opennms']['vacuumd']['action_events']['close_ticket']                   = true
default['opennms']['vacuumd']['action_events']['event_escalated']                = true
default['opennms']['vacuumd']['action_events']['maintenance_expiration_warning'] = false
# viewsdisplay.xml
default['opennms']['web_console_view']['enabled']            = true
default['opennms']['web_console_view']['network_interfaces'] = true
default['opennms']['web_console_view']['web_servers']        = true
default['opennms']['web_console_view']['email_servers']      = true
default['opennms']['web_console_view']['dns_dhcp_servers']   = true
default['opennms']['web_console_view']['db_servers']         = true
default['opennms']['web_console_view']['jmx_servers']        = true
default['opennms']['web_console_view']['other_servers']      = true
# vmware-cim-datacollection-config.xml
default['opennms']['vmware_cim']['default_esx_hostsystem']['rrd']['step']              = 300
default['opennms']['vmware_cim']['default_esx_hostsystem']['rrd']['rras']              = ['RRA:AVERAGE:0.5:1:2016', 'RRA:AVERAGE:0.5:12:1488', 'RRA:AVERAGE:0.5:288:366', 'RRA:MAX:0.5:288:366', 'RRA:MIN:0.5:288:366']
default['opennms']['vmware_cim']['default_esx_hostsystem']['sensor_unknown']           = true
default['opennms']['vmware_cim']['default_esx_hostsystem']['sensor_other']             = true
default['opennms']['vmware_cim']['default_esx_hostsystem']['sensor_temperature']       = true
default['opennms']['vmware_cim']['default_esx_hostsystem']['sensor_voltage']           = true
default['opennms']['vmware_cim']['default_esx_hostsystem']['sensor_current']           = true
default['opennms']['vmware_cim']['default_esx_hostsystem']['sensor_counter'] = true
default['opennms']['vmware_cim']['default_esx_hostsystem']['sensor_tachometer']        = true
default['opennms']['vmware_cim']['default_esx_hostsystem']['sensor_switch']            = true
default['opennms']['vmware_cim']['default_esx_hostsystem']['sensor_lock']              = true
default['opennms']['vmware_cim']['default_esx_hostsystem']['sensor_humidity']          = true
default['opennms']['vmware_cim']['default_esx_hostsystem']['sensor_smoke_detection']   = true
default['opennms']['vmware_cim']['default_esx_hostsystem']['sensor_presence']          = true
default['opennms']['vmware_cim']['default_esx_hostsystem']['sensor_airflow']           = true
default['opennms']['vmware_cim']['default_esx_hostsystem']['sensor_power_consumption'] = true
default['opennms']['vmware_cim']['default_esx_hostsystem']['sensor_power_production']  = true
default['opennms']['vmware_cim']['default_esx_hostsystem']['sensor_pressure'] = true
# vmware-datacollection-config.xml
default['opennms']['vmware']['default_hostsystem3']['enabled']       = true
default['opennms']['vmware']['default_hostsystem3']['rrd']['step']   = 300
default['opennms']['vmware']['default_hostsystem3']['rrd']['rras']   = ['RRA:AVERAGE:0.5:1:2016', 'RRA:AVERAGE:0.5:12:1488', 'RRA:AVERAGE:0.5:288:366', 'RRA:MAX:0.5:288:366', 'RRA:MIN:0.5:288:366']
default['opennms']['vmware']['default_hostsystem3']['vmware3_cpu']    = true
default['opennms']['vmware']['default_hostsystem3']['vmware3_node']   = true
default['opennms']['vmware']['default_hostsystem3']['vmware3_mgt_agt'] = true
default['opennms']['vmware']['default_hostsystem3']['vmware3_net']    = true
default['opennms']['vmware']['default_hostsystem3']['vmware3_disk']   = true
default['opennms']['vmware']['default_hostsystem3']['vmware3_sys']    = true
default['opennms']['vmware']['default_vm3']['enabled']               = true
default['opennms']['vmware']['default_vm3']['rrd']['step']           = 300
default['opennms']['vmware']['default_vm3']['rrd']['rras']           = ['RRA:AVERAGE:0.5:1:2016', 'RRA:AVERAGE:0.5:12:1488', 'RRA:AVERAGE:0.5:288:366', 'RRA:MAX:0.5:288:366', 'RRA:MIN:0.5:288:366']
default['opennms']['vmware']['default_vm3']['vmware3_cpu']            = true
default['opennms']['vmware']['default_vm3']['vmware3_node']           = true
default['opennms']['vmware']['default_vm3']['vmware3_net']            = true
default['opennms']['vmware']['default_vm3']['vmware3_disk']           = true
default['opennms']['vmware']['default_hostsystem4']['enabled']       = true
default['opennms']['vmware']['default_hostsystem4']['rrd']['step']   = 300
default['opennms']['vmware']['default_hostsystem4']['rrd']['rras']   = ['RRA:AVERAGE:0.5:1:2016', 'RRA:AVERAGE:0.5:12:1488', 'RRA:AVERAGE:0.5:288:366', 'RRA:MAX:0.5:288:366', 'RRA:MIN:0.5:288:366']
default['opennms']['vmware']['default_hostsystem4']['vmware4_cpu']    = true
default['opennms']['vmware']['default_hostsystem4']['vmware4_node']   = true
default['opennms']['vmware']['default_hostsystem4']['vmware4_mgt_agt'] = true
default['opennms']['vmware']['default_hostsystem4']['vmware4_net']    = true
default['opennms']['vmware']['default_hostsystem4']['vmware4_disk']   = true
default['opennms']['vmware']['default_hostsystem4']['vmware4_sys']    = true
default['opennms']['vmware']['default_vm4']['enabled']               = true
default['opennms']['vmware']['default_vm4']['rrd']['step']           = 300
default['opennms']['vmware']['default_vm4']['rrd']['rras']           = ['RRA:AVERAGE:0.5:1:2016', 'RRA:AVERAGE:0.5:12:1488', 'RRA:AVERAGE:0.5:288:366', 'RRA:MAX:0.5:288:366', 'RRA:MIN:0.5:288:366']
default['opennms']['vmware']['default_vm4']['vmware4_cpu']            = true
default['opennms']['vmware']['default_vm4']['vmware4_node']           = true
default['opennms']['vmware']['default_vm4']['vmware4_net']            = true
default['opennms']['vmware']['default_vm4']['vmware4_disk']           = true
default['opennms']['vmware']['default_hostsystem5']['enabled']       = true
default['opennms']['vmware']['default_hostsystem5']['rrd']['step']   = 300
default['opennms']['vmware']['default_hostsystem5']['rrd']['rras']   = ['RRA:AVERAGE:0.5:1:2016', 'RRA:AVERAGE:0.5:12:1488', 'RRA:AVERAGE:0.5:288:366', 'RRA:MAX:0.5:288:366', 'RRA:MIN:0.5:288:366']
default['opennms']['vmware']['default_hostsystem5']['vmware5_st_adptr'] = true
default['opennms']['vmware']['default_hostsystem5']['vmware5_cpu']    = true
default['opennms']['vmware']['default_hostsystem5']['vmware5_node']   = true
default['opennms']['vmware']['default_hostsystem5']['vmware5_mgt_agt'] = true
default['opennms']['vmware']['default_hostsystem5']['vmware5_net']    = true
default['opennms']['vmware']['default_hostsystem5']['vmware5_disk']   = true
default['opennms']['vmware']['default_hostsystem5']['vmware5_st_pth']  = true
default['opennms']['vmware']['default_hostsystem5']['vmware5_da_st']   = true
default['opennms']['vmware']['default_hostsystem5']['vmware5_sys'] = true
default['opennms']['vmware']['default_vm5']['enabled']               = true
default['opennms']['vmware']['default_vm5']['rrd']['step']           = 300
default['opennms']['vmware']['default_vm5']['rrd']['rras']           = ['RRA:AVERAGE:0.5:1:2016', 'RRA:AVERAGE:0.5:12:1488', 'RRA:AVERAGE:0.5:288:366', 'RRA:MAX:0.5:288:366', 'RRA:MIN:0.5:288:366']
default['opennms']['vmware']['default_vm5']['vmware5_cpu']            = true
default['opennms']['vmware']['default_vm5']['vmware5_node']           = true
default['opennms']['vmware']['default_vm5']['vmware5_net']            = true
default['opennms']['vmware']['default_vm5']['vmware5_vrt_disk'] = true
default['opennms']['vmware']['default_vm5']['vmware5_disk'] = true
default['opennms']['vmware']['default_vm5']['vmware5_da_st'] = true
# wmi-datacollection-config.xml
default['opennms']['wmi']['default']['rrd']['step']              = 300
default['opennms']['wmi']['default']['rrd']['rras']              = ['RRA:AVERAGE:0.5:1:2016', 'RRA:AVERAGE:0.5:12:1488', 'RRA:AVERAGE:0.5:288:366', 'RRA:MAX:0.5:288:366', 'RRA:MIN:0.5:288:366']
default['opennms']['wmi']['default']['os_memory']                = true
default['opennms']['wmi']['default']['os_objects']               = true
default['opennms']['wmi']['default']['os_cpu']                   = true
default['opennms']['wmi']['default']['physical_disk']            = true
default['opennms']['wmi']['default']['logical_disk']             = true
default['opennms']['wmi']['default']['tcpip_network_interface']  = true
default['opennms']['wmi']['default']['terminal_services']        = true
default['opennms']['wmi']['default']['server_sessions']          = true
default['opennms']['wmi']['default']['server_errors']            = true
default['opennms']['wmi']['default']['w3svc']                    = true
# xml-datacollection-config.xml
default['opennms']['xml']['threegpp_full_5min']['enabled']      = false
default['opennms']['xml']['threegpp_full_5min']['rrd']['step']  = 300
default['opennms']['xml']['threegpp_full_5min']['rrd']['rras']  = ['RRA:AVERAGE:0.5:1:2016', 'RRA:AVERAGE:0.5:12:1488', 'RRA:AVERAGE:0.5:288:366', 'RRA:MAX:0.5:288:366', 'RRA:MIN:0.5:288:366']
default['opennms']['xml']['threegpp_full_5min']['username']     = 'opennms'
default['opennms']['xml']['threegpp_full_5min']['password']     = 'Op3nNMS@'
default['opennms']['xml']['threegpp_full_15min']['enabled']     = false
default['opennms']['xml']['threegpp_full_15min']['rrd']['step'] = 300
default['opennms']['xml']['threegpp_full_15min']['rrd']['rras'] = ['RRA:AVERAGE:0.5:1:2016', 'RRA:AVERAGE:0.5:12:1488', 'RRA:AVERAGE:0.5:288:366', 'RRA:MAX:0.5:288:366', 'RRA:MIN:0.5:288:366']
default['opennms']['xml']['threegpp_full_15min']['username']    = 'opennms'
default['opennms']['xml']['threegpp_full_15min']['password']    = 'Op3nNMS@'
default['opennms']['xml']['threegpp_sample']['enabled']         = false
default['opennms']['xml']['threegpp_sample']['rrd']['step']     = 300
default['opennms']['xml']['threegpp_sample']['rrd']['rras']     = ['RRA:AVERAGE:0.5:1:2016', 'RRA:AVERAGE:0.5:12:1488', 'RRA:AVERAGE:0.5:288:366', 'RRA:MAX:0.5:288:366', 'RRA:MIN:0.5:288:366']
default['opennms']['xml']['threegpp_sample']['username']        = 'opennms'
default['opennms']['xml']['threegpp_sample']['password']        = 'Op3nNMS!@'
# xmpp-configuration.properties
default['opennms']['xmpp']['server']              = nil
default['opennms']['xmpp']['service_name']        = nil
default['opennms']['xmpp']['port']                = nil
default['opennms']['xmpp']['tls']                 = nil
default['opennms']['xmpp']['sasl']                = nil
default['opennms']['xmpp']['self_signed_certs']   = nil
default['opennms']['xmpp']['truststore_password'] = nil
default['opennms']['xmpp']['debug']               = nil
default['opennms']['xmpp']['user']                = nil
default['opennms']['xmpp']['pass']                = nil
# web.xml
default['opennms']['web']['cookbook'] = 'opennms'
default['opennms']['cors']['origins']     = '*'
default['opennms']['cors']['credentials'] = true

case node['platform_family']
when 'rhel'
  default['opennms']['repos']['branches'] = %w(obsolete snapshot stable oldstable)
  default['opennms']['repos']['platforms'] = %w(common)
  if node['platform_version'].to_f >= 6.0 && node['platform_version'].to_f < 7.0
    Chef::Log.debug("i am 6 because #{node['platform_version']}")
    default['opennms']['repos']['platforms'].push 'rhel6'
  end
  if node['platform_version'].to_f >= 7.0 && node['platform_version'].to_f < 8.0
    Chef::Log.debug("i am 7 because #{node['platform_version']}")
    default['opennms']['repos']['platforms'].push 'rhel7'
  end
end

default['opennms']['telemetryd']['managed'] = false
default['opennms']['telemetryd']['jti']['enabled'] = false
default['opennms']['telemetryd']['jti']['port'] = 50000
default['opennms']['telemetryd']['netflow5']['enabled'] = false
default['opennms']['telemetryd']['netflow5']['port'] = 8877
default['opennms']['telemetryd']['netflow9']['enabled'] = false
default['opennms']['telemetryd']['netflow9']['port'] = 4729
default['opennms']['telemetryd']['ipfix']['enabled'] = false
default['opennms']['telemetryd']['ipfix']['port'] = 4730
default['opennms']['telemetryd']['sflow']['enabled'] = false
default['opennms']['telemetryd']['sflow']['port'] = 6343
default['opennms']['telemetryd']['nxos']['enabled'] = false
default['opennms']['telemetryd']['nxos']['port'] = 50001
# 'protocol_name' => {
#   'description' => 'xxx',
#   'enabled' => true|false,
#   'listeners' => {
#     'listener_name' => {
#       'class_name' => 'org.opennms.blah.blah',
#       'parameters' => {
#         'key' => 'value',
#         ...
#       }
#      },
#      ...
#    },
#    ...
#    'adapters' => {
#      'adapter_name' => {
#        'class_name' => 'org.opennms.blah.blah',
#        'parameters' => {
#          'key' => 'value',
#         ...
#        }
#      },
#      ...
#    },
#    'package' => {
#      'rrd' => {
#        'step' => 300,
#        'rras' => ['strings'],
#      }
#    }
# },
# ...
default['opennms']['telemetryd']['protocols'] = {}
default['opennms']['telemetryd']['cookbook'] = 'opennms'
default['opennms']['es']['hosts'] = {}
default['opennms']['manage_repos'] = true

default['opennms']['posgresql']['pg_upgrade_timeout'] = 7200
default['opennms']['postgresql']['attempt_upgrade'] = false
default['opennms']['postgresql']['start_after_upgrade'] = false
default['opennms']['postgresql']['setup_repo'] = true

default['opennms']['bin']['cookbook'] = 'opennms'
default['opennms']['bin']['return_code'] = false

#Kafka
default['opennms']['karaf']['addl_features'] = []
default['opennms']['kafka']['producer'] = {'eventTopic' => 'events', 'alarmTopic' => 'alarms', 'alarmFeedbackTopic' => 'alarmFeedback', 'nodeTopic' => 'nodes', 'topologyVertexTopic' => 'vertices',
                                           'topologyEdgeTopic' => 'edges', 'metricTopic' => 'metrics', 'eventFilter' => '', 'alarmFilter' => '', 'forward.metrics' => false,
                                           'nodeRefreshTimeoutMs' => 300000, 'alarmSyncIntervalMs' => 300000, 'suppressIncrementalAlarms' => true, 'kafkaSendQueueCapacity' => 1000,
                                           'startAlarmSyncWithCleanState' => false}
default['opennms']['kafka']['producer_client'] = {'bootstrap.servers' => '127.0.0.1:9092'}
