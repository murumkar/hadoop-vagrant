class daemons inherits config {
 
  require config

  exec { "Format Namenode":
     command => 'echo "Y" | hdfs namenode -format -force',
     path => [ "/usr/bin", "/bin" ],
     user => "hdfs",
  }

  exec { "start daemons":
     command => "start-all.sh",
     path => [ "${hadoop_home}/sbin", "/bin" ],
     user => "root",
  }

}
