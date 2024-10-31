# R5

```
R5#sh running-config

router ospf 1
 router-id 5.5.5.5
 log-adjacency-changes
 network 10.6.52.0 0.0.0.3 area 1
 default-information originate always
!

R5#sh ip route

Gateway of last resort is not set

     10.0.0.0/8 is variably subnetted, 9 subnets, 2 masks
O IA    10.6.13.0/30 [110/3] via 10.6.52.2, 00:25:11, FastEthernet0/0
C       10.1.1.0/24 is directly connected, FastEthernet1/0
O IA    10.6.1.0/24 [110/4] via 10.6.52.2, 00:25:11, FastEthernet0/0
O IA    10.6.2.0/24 [110/4] via 10.6.52.2, 00:25:11, FastEthernet0/0
O IA    10.6.3.0/24 [110/3] via 10.6.52.2, 00:25:11, FastEthernet0/0
O IA    10.6.21.0/30 [110/2] via 10.6.52.2, 00:25:11, FastEthernet0/0
O IA    10.6.23.0/30 [110/2] via 10.6.52.2, 00:25:11, FastEthernet0/0
O IA    10.6.41.0/30 [110/3] via 10.6.52.2, 00:25:11, FastEthernet0/0
C       10.6.52.0/30 is directly connected, FastEthernet0/0

R5#sh ip ospf neighbor

Neighbor ID     Pri   State           Dead Time   Address         Interface
2.2.2.2           1   FULL/DR         00:00:31    10.6.52.2       FastEthernet0/0
```