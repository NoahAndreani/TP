


```
R3#sh running-config

router ospf 1
 router-id 3.3.3.3
 log-adjacency-changes
 network 10.6.13.0 0.0.0.3 area 0
 network 10.6.23.0 0.0.0.3 area 0

R3#sh ip route

Gateway of last resort is 10.6.23.2 to network 0.0.0.0

     10.0.0.0/8 is variably subnetted, 8 subnets, 2 masks
C       10.6.13.0/30 is directly connected, FastEthernet0/0
O IA    10.6.1.0/24 [110/3] via 10.6.13.1, 00:24:04, FastEthernet0/0
O IA    10.6.2.0/24 [110/3] via 10.6.13.1, 00:24:04, FastEthernet0/0
O IA    10.6.3.0/24 [110/2] via 10.6.13.1, 00:26:39, FastEthernet0/0
O       10.6.21.0/30 [110/2] via 10.6.23.2, 00:26:39, FastEthernet1/0
                     [110/2] via 10.6.13.1, 00:26:39, FastEthernet0/0
C       10.6.23.0/30 is directly connected, FastEthernet1/0
O IA    10.6.41.0/30 [110/2] via 10.6.13.1, 00:24:14, FastEthernet0/0
O IA    10.6.52.0/30 [110/2] via 10.6.23.2, 00:26:39, FastEthernet1/0
O*E2 0.0.0.0/0 [110/1] via 10.6.23.2, 00:21:23, FastEthernet1/0

R3#sh ip ospf neighbor

Neighbor ID     Pri   State           Dead Time   Address         Interface
2.2.2.2           1   FULL/DR         00:00:34    10.6.23.2       FastEthernet1/0
1.1.1.1           1   FULL/BDR        00:00:37    10.6.13.1       FastEthernet0/0
```