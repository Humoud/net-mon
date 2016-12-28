import Foundation
import c

print("pcap test")

let packetCap = PacketCapture()
let interface = "en0"
let numberOfPackets = Int32(10)
packetCap.doPacketCapture(device: interface, numberOfPackets: numberOfPackets)
