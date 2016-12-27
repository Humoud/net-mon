# Network Monitor
![Travis Build Failing](https://raw.github.com/dwyl/learn-travis/master/images/06-travis-build-failing.png "Travis Build Failing")

a swift sniffer that uses pcap.h libpcap

the objc folder is just to import the libpcap (pcap.h) and expose it to swift.

### FIXMEs
1. compile time error: _net-mon/Sources/swift-exec/PackerCapture.swift:53:13: error: cannot convert value of type '(UnsafeMutablePointer<u_char>, UnsafePointer<pcap_pkthdr>, UnsafePointer<u_char>) -> Void' to expected argument type 'pcap_handler!'_
