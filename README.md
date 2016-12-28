# Network Monitor
![Travis Build Failing](https://raw.github.com/dwyl/learn-travis/master/images/06-travis-build-failing.png "Travis Build Failing")

a swift sniffer that uses pcap.h libpcap

the c folder is just to import the libpcap (pcap.h) and expose it to swift.

### FIXMEs
1. compile time error: 

  ```
  Linking ./.build/debug/swift-exec
  Undefined symbols for architecture x86_64:
  "_pcap_activate", referenced from:
      __TFC10swift_exec13PacketCapture15doPacketCapturefT6deviceSS15numberOfPacketsVs5Int32_T_ in PackerCapture.swift.o
  "_pcap_create", referenced from:
      __TFC10swift_exec13PacketCapture15doPacketCapturefT6deviceSS15numberOfPacketsVs5Int32_T_ in PackerCapture.swift.o
  "_pcap_loop", referenced from:
      __TFC10swift_exec13PacketCapture15doPacketCapturefT6deviceSS15numberOfPacketsVs5Int32_T_ in PackerCapture.swift.o
  "_pcap_set_promisc", referenced from:
      __TFC10swift_exec13PacketCapture15doPacketCapturefT6deviceSS15numberOfPacketsVs5Int32_T_ in PackerCapture.swift.o
  "_pcap_set_rfmon", referenced from:
      __TFC10swift_exec13PacketCapture15doPacketCapturefT6deviceSS15numberOfPacketsVs5Int32_T_ in PackerCapture.swift.o
  ld: symbol(s) not found for architecture x86_64
  <unknown>:0: error: link command failed with exit code 1 (use -v to see invocation)
  <unknown>:0: error: build had 1 command failures
  ```
