class hadoop {
   include install
   include config
   # Format the namenode and start daemons only from master host 
   #if ($hostname =~ /master/) {
      #include daemons
   #}
}
