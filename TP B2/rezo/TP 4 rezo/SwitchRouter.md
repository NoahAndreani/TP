```bash
Switch 1

 interface Ethernet0/0
 switchport trunk allowed vlan 10,20,30
 switchport trunk encapsulation dot1q
 switchport mode trunk
!
interface Ethernet0/0.10
 encapsulation dot1Q 10
!
interface Ethernet0/1
 switchport access vlan 10
 switchport mode access
!
interface Ethernet0/2
 switchport access vlan 10
 switchport mode access
!
interface Ethernet0/3
!
interface Ethernet1/0
 switchport access vlan 20
 switchport mode access
!
interface Ethernet1/1
 switchport access vlan 30
 switchport mode access

Switch 2

interface Ethernet0/0
 switchport trunk allowed vlan 10,20,30
 switchport trunk encapsulation dot1q
 switchport mode trunk
!
interface Ethernet0/1
 switchport trunk allowed vlan 10,20,30
 switchport trunk encapsulation dot1q
 switchport mode trunk
!
interface Ethernet0/2
 switchport trunk allowed vlan 10,20,30
 switchport trunk encapsulation dot1q
 switchport mode trunk

 Switch 3

 interface Ethernet0/0
 switchport trunk allowed vlan 10
 switchport trunk encapsulation dot1q
 switchport mode trunk
!
interface Ethernet0/1
!
interface Ethernet0/2
!
interface Ethernet0/3
!
interface Ethernet1/0
 switchport access vlan 10
 switchport mode access
!
interface Ethernet1/1
 switchport access vlan 10
 switchport mode access
!
interface Ethernet1/2
 switchport access vlan 10
 switchport mode access
!
interface Ethernet1/3
 switchport access vlan 10
 switchport mode access
!

R1
interface FastEthernet0/0
 no ip address
 ip nat inside
 ip virtual-reassembly
 duplex half
!
interface FastEthernet0/0.10
 encapsulation dot1Q 10
 ip address 10.1.10.254 255.255.255.0
!
interface FastEthernet0/0.20
 encapsulation dot1Q 20
 ip address 10.1.20.254 255.255.255.0
!
interface FastEthernet0/0.30
 encapsulation dot1Q 30
 ip address 10.1.30.254 255.255.255.0
!
interface FastEthernet1/0
 ip address dhcp
 ip nat outside
 ip virtual-reassembly
 duplex half
!
interface FastEthernet2/0
 no ip address
 shutdown
 duplex half
!

```