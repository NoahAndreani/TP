# R4

```
R4#sh running-config
Building configuration...

Current configuration : 943 bytes
!
version 12.4
service timestamps debug datetime msec
service timestamps log datetime msec
no service password-encryption
!
hostname R4
!
boot-start-marker
boot-end-marker
!
!
no aaa new-model
no ip icmp rate-limit unreachable
!
!
ip cef
no ip domain lookup
!
!
!
!
!
!
!
!
!
!
!
!
!
!
!
!
!
!
ip tcp synwait-time 5
!
!
!
!
!
interface FastEthernet0/0
 ip address 10.6.41.2 255.255.255.252
 shutdown
 duplex half
!
interface FastEthernet1/0
 ip address 10.6.1.254 255.255.255.0
 shutdown
 duplex half
!
interface FastEthernet2/0
 ip address 10.6.2.254 255.255.255.0
 shutdown
 duplex half
!
!
ip forward-protocol nd
!
no ip http server
no ip http secure-server
!
!
no cdp log mismatch duplex
!
!
!
control-plane
!
!
!
!
!
!
gatekeeper
 shutdown
!
!
line con 0
 exec-timeout 0 0
 privilege level 15
 logging synchronous
 stopbits 1
line aux 0
 exec-timeout 0 0
 privilege level 15
 logging synchronous
 stopbits 1
line vty 0 4
 login
!
!
end
```