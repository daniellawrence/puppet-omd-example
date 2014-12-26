node /omd/ {
  include omd::server
}

node default {
 class { 'omd::client':
  check_mk_version => '1.2.4p5-2',
 } 
}
