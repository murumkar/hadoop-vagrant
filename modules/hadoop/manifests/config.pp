class config {

  require install

  $hadoop_conf_dir = "/etc/hadoop/conf"
  $hadoop_home = "/usr/lib/hadoop"
  $hadoop_logdir = "/var/log/hadoop"
  $hadoop_rundir = "/var/run/hadoop"

  file { $hadoop_conf_dir:
      ensure => directory,
  } 

  file { $hadoop_home:
      ensure => directory,
  }

  file { $hadoop_logdir:
      ensure => directory,
      mode => 777,
      owner => root,
      group => root,
  }

  file { $hadoop_rundir:
      ensure => directory,
      mode => 777,
      owner => root,
      group => root,
  }

  file { "${hadoop_conf_dir}/slaves":
      source => "puppet:///modules/hadoop/slaves",
      ensure => present,
      mode => 644,
      owner => vagrant,
      group => root,
      require => File["${hadoop_conf_dir}"]
  }

  file { "${hadoop_conf_dir}/masters":
      source => "puppet:///modules/hadoop/masters",
      mode => 644,
      owner => vagrant,
      group => root,
      require => File["${hadoop_conf_dir}"]
  }

  file { "${hadoop_conf_dir}/core-site.xml":
      source => "puppet:///modules/hadoop/core-site.xml",
      mode => 644,
      owner => vagrant,
      group => root,
      require => File["${hadoop_conf_dir}"]
  }

  file { "${hadoop_conf_dir}/mapred-site.xml":
      source => "puppet:///modules/hadoop/mapred-site.xml",
      mode => 644,
      owner => vagrant,
      group => root,
      require => File["${hadoop_conf_dir}"]
  }

  file { "${hadoop_conf_dir}/hdfs-site.xml":
      content => template("hadoop/hdfs-site.xml.erb"),
      mode => 644,
      owner => vagrant,
      group => root,
      require => File["${hadoop_conf_dir}"]
  }

  file { "${hadoop_conf_dir}/yarn-site.xml":
      source => "puppet:///modules/hadoop/yarn-site.xml",
      mode => 644,
      owner => vagrant,
      group => root,
      require => File["${hadoop_conf_dir}"]
  }

  file { "${hadoop_conf_dir}/hadoop-env.sh":
      source => "puppet:///modules/hadoop/hadoop-env.sh",
      mode => 644,
      owner => vagrant,
      group => root,
      require => File["${hadoop_conf_dir}"]
  }

  file { "${hadoop_conf_dir}/yarn-env.sh":
      content => template("hadoop/yarn-env.sh.erb"),
      mode => 644,
      owner => vagrant,
      group => root,
      require => File["${hadoop_conf_dir}"]
  }

  file { "${hadoop_conf_dir}/capacity-scheduler.xml":
      source => "puppet:///modules/hadoop/capacity-scheduler.xml",
      mode => 644,
      owner => vagrant,
      group => root,
      require => File["${hadoop_conf_dir}"]
  }

  file { "${hadoop_home}/sbin/start-all.sh":
      source => "puppet:///modules/hadoop/start-all.sh",
      mode => 755,
      owner => vagrant,
      group => root,
      require => File["${hadoop_home}"]
  }

  file { "${hadoop_home}/sbin/stop-all.sh":
      source => "puppet:///modules/hadoop/stop-all.sh",
      mode => 755,
      owner => vagrant,
      group => root,
      require => File["${hadoop_home}"]
  }

}
