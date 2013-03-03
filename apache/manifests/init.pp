class apache {
  package { "apache2": ensure => installed }
  service { "apache2":
    enable => true,
    ensure => running,
    require => Package["apache2"]
  }
 
  @@nagios_service { "check_apache_${::hostname}":
    ensure => present,
    use => 'generic-service',
    check_command => 'check_http',
    service_description => 'HTTP',
    host_name => $::fqdn,
    notifications_enabled => 1,
    target => "/etc/nagios3/conf.d/${::fqdn}_host.cfg",
  }
}

