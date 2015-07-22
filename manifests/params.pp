# Class: puppet::params
#
# This class installs and configures parameters for Puppet
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
class puppet::params {

  $puppet_server                    = 'puppet'
  $modulepath                       = '/etc/puppet/modules'
  $puppet_user                      = 'puppet'
  $puppet_group                     = 'puppet'
  $storeconfigs_dbserver            = $::fqdn
  $storeconfigs_dbport              = '8081'
  $certname                         = $::fqdn
  $confdir                          = '/etc/puppet'
  $manifest                         = '/etc/puppet/manifests/site.pp'
  $hiera_config                     = '/etc/puppet/hiera.yaml'
  $puppet_docroot                   = '/etc/puppet/rack/public/'
  $puppet_passenger_port            = '8140'
  $puppet_server_port               = '8140'
  $puppet_agent_enabled             = true
  $apache_serveradmin               = 'root'
  $parser                           = 'current'
  $puppetdb_strict_validation       = true
  $environments                     = 'config'
  $digest_algorithm                 = 'md5'
  $puppet_run_interval              = 30
  $classfile                        = '$statedir/classes.txt'
  $package_provider                 = undef # falls back to system default

  $puppet_passenger_ssl_protocol    = 'TLSv1.2',
  #$puppet_passenger_ssl_protocol   = 'ALL -SSLv2 -SSLv3',
  $puppet_passenger_ssl_cipher      = 'AES256+EECDH:AES256+EDH'
  #$puppet_passenger_ssl_cipher     = 'ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-AES256-GCM-SHA384:DHE-RSA-AES128-GCM-SHA256:DHE-DSS-AES128-GCM-SHA256:kEDH+AESGCM:ECDHE-RSA-AES128-SHA256:ECDHE-ECDSA-AES128-SHA256:ECDHE-RSA-AES128-SHA:ECDHE-ECDSA-AES128-SHA:ECDHE-RSA-AES256-SHA384:ECDHE-ECDSA-AES256-SHA384:ECDHE-RSA-AES256-SHA:ECDHE-ECDSA-AES256-SHA:DHE-RSA-AES128-SHA256:DHE-RSA-AES128-SHA:DHE-DSS-AES128-SHA256:DHE-RSA-AES256-SHA256:DHE-DSS-AES256-SHA:DHE-RSA-AES256-SHA:!aNULL:!eNULL:!EXPORT:!DES:!RC4:!3DES:!MD5:!PSK',

  # Only used when environments == directory
  $environmentpath                  = "${confdir}/environments"

  case $::osfamily {
    'RedHat': {
      $puppet_master_package        = 'puppet-server'
      $puppet_master_service        = 'puppetmaster'
      $puppet_agent_service         = 'puppet'
      $puppet_agent_package         = 'puppet'
      $puppet_defaults              = '/etc/sysconfig/puppet'
      $puppet_conf                  = '/etc/puppet/puppet.conf'
      $puppet_vardir                = '/var/lib/puppet'
      $puppet_ssldir                = '/var/lib/puppet/ssl'
      $passenger_package            = 'mod_passenger'
      $rack_package                 = 'rubygem-rack'
      $ruby_dev                     = 'ruby-devel'
    }
    'Suse': {
      $puppet_master_package        = 'puppet-server'
      $puppet_master_service        = 'puppetmasterd'
      $puppet_agent_service         = 'puppet'
      $puppet_agent_package         = 'puppet'
      $puppet_conf                  = '/etc/puppet/puppet.conf'
      $puppet_vardir                = '/var/lib/puppet'
      $puppet_ssldir                = '/var/lib/puppet/ssl'
      $passenger_package            = 'rubygem-passenger-apache2'
      $rack_package                 = 'rubygem-rack'
    }
    'Debian': {
      $puppet_master_package        = 'puppetmaster'
      $puppet_master_service        = 'puppetmaster'
      $puppet_agent_service         = 'puppet'
      $puppet_agent_package         = 'puppet'
      $puppet_defaults              = '/etc/default/puppet'
      $puppet_conf                  = '/etc/puppet/puppet.conf'
      $puppet_vardir                = '/var/lib/puppet'
      $puppet_ssldir                = '/var/lib/puppet/ssl'
      $passenger_package            = 'libapache2-mod-passenger'
      $rack_package                 = 'librack-ruby'
      $ruby_dev                     = 'ruby-dev'
    }
    'FreeBSD': {
      $puppet_agent_service         = 'puppet'
      $puppet_agent_package         = 'sysutils/puppet'
      $puppet_conf                  = '/usr/local/etc/puppet/puppet.conf'
      $puppet_vardir                = '/var/puppet'
      $puppet_ssldir                = '/var/puppet/ssl'
    }
    'Darwin': {
      $puppet_agent_service         = 'com.puppetlabs.puppet'
      $puppet_agent_package         = 'puppet'
      $puppet_conf                  = '/etc/puppet/puppet.conf'
      $puppet_vardir                = '/var/lib/puppet'
      $puppet_ssldir                = '/etc/puppet/ssl'
    }
    default: {
      err('The Puppet module does not support your os')
    }
  }
}
