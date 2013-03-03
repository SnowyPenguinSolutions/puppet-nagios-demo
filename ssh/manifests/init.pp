class ssh {
  package { "openssh-server": ensure => installed }
  service { "ssh":
    enable => true,
    ensure => running,
    require => Package["openssh-server"]
  }
 
  @@nagios_service { "check_ssh_${::hostname}":
    ensure => present,
    use => 'generic-service',
    check_command => 'check_ssh',
    service_description => 'SSH',
    host_name => $::fqdn,
    notifications_enabled => 1,
    target => "/etc/nagios3/conf.d/${::fqdn}_host.cfg",
  }
}

