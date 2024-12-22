# R4

```
R4#sh running-config

router ospf 1
 router-id 4.4.4.4
 log-adjacency-changes
 network 10.6.1.0 0.0.0.255 area 3
 network 10.6.2.0 0.0.0.255 area 3
 network 10.6.41.0 0.0.0.3 area 3
!


R4#sh ip route

Gateway of last resort is 10.6.41.1 to network 0.0.0.0

     10.0.0.0/8 is variably subnetted, 8 subnets, 2 masks
O IA    10.6.13.0/30 [110/2] via 10.6.41.1, 00:26:32, FastEthernet0/0
C       10.6.1.0/24 is directly connected, FastEthernet1/0
C       10.6.2.0/24 is directly connected, FastEthernet2/0
O IA    10.6.3.0/24 [110/2] via 10.6.41.1, 00:26:32, FastEthernet0/0
O IA    10.6.21.0/30 [110/2] via 10.6.41.1, 00:26:32, FastEthernet0/0
O IA    10.6.23.0/30 [110/3] via 10.6.41.1, 00:26:32, FastEthernet0/0
C       10.6.41.0/30 is directly connected, FastEthernet0/0
O IA    10.6.52.0/30 [110/3] via 10.6.41.1, 00:26:32, FastEthernet0/0
O*E2 0.0.0.0/0 [110/1] via 10.6.41.1, 00:23:47, FastEthernet0/0

R4#sh ip ospf neighbor

Neighbor ID     Pri   State           Dead Time   Address         Interface
1.1.1.1           1   FULL/BDR        00:00:31    10.6.41.1       FastEthernet0/0

```