#EOI Docker Install Guide

##修改宿主机的参数
在ElasticSearch中需要修改该参数，可以在其宿主机上修改
    
    sysctl -w vm.max_map_count=262144