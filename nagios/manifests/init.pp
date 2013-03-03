class nagios {
	package {
		'nagios3':
		  ensure => installed,
		  alias => 'nagios',
		;
	}

	service {
		'nagios3':
		  ensure => running,
		  alias	=> 'nagios',
		  hasstatus	=> true,
		  hasrestart	=> true,
		  require => Package[nagios],
	}

	file { "/etc/nagios/":
	  ensure => link,
	  target => "/etc/nagios3/",
	  mode => 644,
	  require => Package["nagios3"];
 	}

Nagios_host <<||>>
Nagios_service <<||>>
Nagios_hostextinfo <<||>>


class target {
	@@nagios_host { $fqdn:
		ensure => present,
		alias => $hostname,
		address => $ipaddress,
		use => "generic-host",
		target => "/etc/nagios3/conf.d/puppet.cfg",
	}

	@@nagios_hostextinfo { $fqdn:
		ensure => present,
		icon_image_alt => $operatingsystem,
      		icon_image => "base/$operatingsystem.png",
         	statusmap_image => "base/$operatingsystem.gd2",
                target => "/etc/nagios3/conf.d/puppet1.cfg",

      }


#      @@nagios_service { "check_users_${hostname}":
#         use => "remote-nrpe-users",
#         host_name => "$fqdn",
#      }
#
#      @@nagios_service { "check_load_${hostname}":
#         use => "remote-nrpe-load",
#         host_name => "$fqdn",
#      }
#
#      @@nagios_service { "check_zombie_procs_${hostname}":
#         use => "remote-nrpe-zombie-procs",
#         host_name => "$fqdn",
#      }
#
#      @@nagios_service { "check_total_procs_${hostname}":
#         use => "remote-nrpe-total-procs",
#         host_name => "$fqdn",
#      }
#
#      @@nagios_service { "check_swap_${hostname}":
#         use => "remote-nrpe-swap",
#         host_name => "$fqdn",
#      }
#
#      @@nagios_service { "check_all_disks_${hostname}":
#         use => "remote-nrpe-all-disks",
#        host_name => "$fqdn",
#      }
   }
}
