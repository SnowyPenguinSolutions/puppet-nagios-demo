class mysql {
  package { "mysql-server": ensure => installed }
  service { "mysql":
    enable => false,
    require => Package["mysql-server"]
  }
  @@nagios_service { "check_mysql_${::hostname}":
    ensure => present,
    use => 'generic-service',
    check_command => 'check_mysql',
    service_description => 'MySQL',
    host_name => $::fqdn,
    notifications_enabled => 1,
    target => "/etc/nagios3/conf.d/${::fqdn}_host.cfg",
  }

}

