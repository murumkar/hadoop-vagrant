class install {

  file { ["/srv/data", "/srv/data/hadoop",  "/srv/data/hadoop/namenode", "/srv/data/hadoop/datanode"]:
    ensure => "directory",
    mode => 777,
  }

  yumrepo { "HDP-2.1.5.0":
    name => "HDP-2.1.5.0",
    descr => "Hortonworks Data Platform Version - HDP-2.1.5.0",
    baseurl => "http://public-repo-1.hortonworks.com/HDP/centos6/2.x/updates/2.1.5.0",
    gpgcheck => 0,
    gpgkey => "http://public-repo-1.hortonworks.com/HDP/centos6/2.x/updates/2.1.5.0/RPM-GPG-KEY/RPM-GPG-KEY-Jenkins",
    enabled => 1,
    priority => 1,
  }

  yumrepo { "HDP-UTILS-1.1.0.19":
    name => "HDP-UTILS-1.1.0.19",
    descr => "Hortonworks Data Platform Utils Version - HDP-UTILS-1.1.0.19",
    baseurl => "http://public-repo-1.hortonworks.com/HDP-UTILS-1.1.0.19/repos/centos6",
    gpgcheck => 1,
    gpgkey => "http://public-repo-1.hortonworks.com/HDP/centos6/2.x/updates/2.1.5.0/RPM-GPG-KEY/RPM-GPG-KEY-Jenkins",
    enabled => 1,
    priority => 1,
  }

  exec { "download JDK": 
    command => 'wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/7u67-b01/jdk-7u67-linux-x64.rpm -O /tmp/jdk-7u67-linux-x64.rpm',
    creates => "/tmp/jdk-7u67-linux-x64.rpm",
    path => "/usr/bin",
  }

  exec { "JDK":
    command => "rpm -ivh /tmp/jdk-7u67-linux-x64.rpm",
    logoutput => true,
    path => "/bin",
    unless => "rpm -qa |grep jdk-1.7.0_67",
    require => File["/tmp/jdk-7u67-linux-x64.rpm"],
  }
    
  exec { "set java":
    command => "update-alternatives --install /usr/bin/java java /usr/java/jdk1.7.0_67/bin/java 200000",
    logoutput => true,
    path => "/usr/sbin",
  }

  exec { "set javaws":
    command => "update-alternatives --install /usr/bin/javaws javaws /usr/java/jdk1.7.0_67/bin/javaws 200000",
    logoutput => true,
    path => "/usr/sbin",
  } 

  exec { "set jps":
    command => "update-alternatives --install /usr/bin/jps jps /usr/java/jdk1.7.0_67/bin/jps 200000",
    logoutput => true,
    path => "/usr/sbin",
  }

  # Hadoop Packages, this is a subset of what's available in the HDP repo
  $hadoop_core = [ "hadoop-client","hadoop-hdfs","hadoop-libhdfs","hadoop-mapreduce-historyserver","hadoop-mapreduce","hadoop","hadoop-yarn-nodemanager","hadoop-yarn-proxyserver","hadoop-yarn-resourcemanager","hadoop-yarn","hive-hcatalog","hive-jdbc","hive","libconfuse","oozie-client","oozie","sqoop","tez","zookeeper" ]

  #$hadoop_core = [ "bigtop-jsvc","bigtop-tomcat","extjs","falcon","ganglia-devel","ganglia-gmetad","ganglia-gmond-modules-python","ganglia-gmond","ganglia-web","hadoop-client","hadoop-hdfs","hadoop-libhdfs","hadoop-mapreduce-historyserver","hadoop-mapreduce","hadoop","hadoop-yarn-nodemanager","hadoop-yarn-proxyserver","hadoop-yarn-resourcemanager","hadoop-yarn","hive-hcatalog","hive-jdbc","hive","libconfuse","libganglia","oozie-client","oozie","perl-rrdtool","python-rrdtool","rrdtool","sqoop","tez","zookeeper" ]

  package { $hadoop_core:
    ensure => present,
    provider => yum,
    require => Yumrepo["HDP-UTILS-1.1.0.19", "HDP-2.1.5.0"],
  }

  group { "hadoop":
      ensure     => "present",
  }

  user { "hdfs":
      ensure     => "present",
      managehome => "true",
      groups => "hadoop"
  }

  user { "yarn":
      ensure  => "present",
      managehome => "true",
      groups => "hadoop"
  }

  user { "mapred":
      ensure  => "present",
      managehome => "true",
      groups => "hadoop"
  }
}
