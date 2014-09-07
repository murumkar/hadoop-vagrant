hadoop-vagrant
==============

Clone this project to create a 2 node [HDP 2.0](http://hortonworks.com/hdp/) cluster

## Deploying the cluster

First install both [Virtual Box](http://virtualbox.org) and [Vagrant](http://vagrantup.com/) for your platform.

Then simply clone this repository, change into the directory and bring the cluster up.

    $ vagrant up

This will set up 3 machines - `master`, `hadoop1` and `hadoop2`. Each of them will have two CPUs and 512 MB of RAM. If this is too much for your machine, adjust the `Vagrantfile`. It will also start the cluster for you.

The machines will be provisioned using [Puppet](http://puppetlabs.com/). All of them will have hadoop installed, ssh will be configured and local name resolution also works.

### Restarting the cluster

If you want to shut down your cluster, but want to keep it around for later use, shut down all the services and tell
vagrant to stop the machines like this:

     $ vagrant ssh master
     $ (master) sudo /usr/lib/hadoop/sbin/stop-all.sh
     $ exit or Ctrl-D
     $ vagrant halt

When you want to use your cluster again, simply do this:

     $ vagrant up
     $ vagrant ssh master
     $ (master) sudo /usr/lib/hadoop/sbin/start-all.sh
     

### Destroying the cluster

If you don't need the cluster anymore and want to get your disk-space back do this:

     $ vagrant destroy -f
     $ (vagrant root on localhost) rm -rf data/*

## Interacting with the cluster

### Web Interfaces

You can access all services of the cluster with your web-browser.

* NameNode: http://master.local:50070/dfshealth.jsp
* Resource Manager: http://master.local:8088/cluster
* Job History Server: http://master.local:19888/jobhistory

### Command line

To interact with the cluster on the command line, log into the master and use the hadoop command.

    $ vagrant ssh master
    $ (master) hadoop fs -ls /
    $ ...

### Storage locations

The namenode stores the it's data in `/srv/data/hadoop/namenode`. The datanodes  are storing all data in
`/srv/data/hadoop/datanode`. Note that a directory called 'data' in vagrant root is NFS mounted on '/srv/data'.
Space available to your cluster is the space you have available on the host machines' 'data' directory.

