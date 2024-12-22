# R1
```
R1#sh running-config

router ospf 1
 router-id 1.1.1.1
 log-adjacency-changes
 network 10.6.3.0 0.0.0.255 area 2
 network 10.6.13.0 0.0.0.3 area 0
 network 10.6.21.0 0.0.0.3 area 0
 network 10.6.41.0 0.0.0.3 area 3

 R1#sh ip route
Gateway of last resort is 10.6.21.2 to network 0.0.0.0

     10.0.0.0/8 is variably subnetted, 8 subnets, 2 masks
C       10.6.13.0/30 is directly connected, FastEthernet1/0
O       10.6.1.0/24 [110/2] via 10.6.41.2, 00:17:09, FastEthernet1/1
O       10.6.2.0/24 [110/2] via 10.6.41.2, 00:17:09, FastEthernet1/1
C       10.6.3.0/24 is directly connected, FastEthernet2/0
C       10.6.21.0/30 is directly connected, FastEthernet0/0
O       10.6.23.0/30 [110/2] via 10.6.21.2, 00:19:43, FastEthernet0/0
                     [110/2] via 10.6.13.2, 00:19:43, FastEthernet1/0
C       10.6.41.0/30 is directly connected, FastEthernet1/1
O IA    10.6.52.0/30 [110/2] via 10.6.21.2, 00:17:09, FastEthernet0/0
O*E2 0.0.0.0/0 [110/1] via 10.6.21.2, 00:14:27, FastEthernet0/0

R1#sh ip ospf neighbor

Neighbor ID     Pri   State           Dead Time   Address         Interface
2.2.2.2           1   FULL/DR         00:00:37    10.6.21.2       FastEthernet0/0
3.3.3.3           1   FULL/DR         00:00:34    10.6.13.2       FastEthernet1/0
4.4.4.4           1   FULL/DR         00:00:35    10.6.41.2       FastEthernet1/1

```