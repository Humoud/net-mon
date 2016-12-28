// Refactored From: https://github.com/dfrencham/swiftPCap/blob/master/classes/PacketCapture.swift
// This file is just for testing libpcap (pcap.h) will be removed soon
// 1. Updated to Swift 3
// 2. imported c
//
//  PacketCapture.swift

import Foundation
import c

class PacketAnalyser {

    // this is how we create a singleton in swift
    // Nice and consise.
    static let sharedInstance = PacketAnalyser()

    var packetCount: Int = 0;

    // This is a basic test, so lets just print the packet
    // count to the console
    func Process() {
        packetCount += 1
        print("Packet count " + packetCount.description)
    }
}


class PacketCapture {

    // doPacketCapture - attempts to capture some packets for basic analysis
    // device: the osx reference to the network
    //          device you want to capture
    func doPacketCapture(device: String, numberOfPackets: Int32) {
        var error : UnsafeMutablePointer<Int8>!

        printMessageToConsole(output: "Opening " + device)

        // create a new pcap session via pcap.h
        let pcapSession = pcap_create(device, error)

        // check for errors, then set the NIC to promiscious mode and activate
        handleError(error: error)
        handleResult(result: pcap_set_promisc(pcapSession, 1),message: "Couldn't set promisc mode")
        handleResult(result: pcap_set_rfmon(pcapSession, 1), message: "Couldn't set monitor mode")
        handleResult(result: pcap_activate(pcapSession), message: "Error activating")

        printMessageToConsole(output: "Capturing " + numberOfPackets.description + " packets (please wait, filling buffer....) ")

        // Call back to pcap_loop in pcap.h
        // This is where the magic happens. We pass a closure as the call
        // back (the packet argument)
        let callback : pcap_handler  = {
            (args: UnsafeMutablePointer<UInt8>?,
             pkthdr:UnsafePointer<pcap_pkthdr>?,
           packet: UnsafePointer<UInt8>?) -> () in
                    // lets handle the result using a call to a singleton
                    // we can keep state this way, and not have to
                    // tool around by passing pointers to UnsafePointers
                    // and dereferencing later
                    let pa = PacketAnalyser.sharedInstance
                    pa.Process()
        }
        pcap_loop(pcapSession, numberOfPackets,
             callback,
            nil)

        printMessageToConsole(output: "Capture complete")
        exit(0)
    }

    func printErrorToConsole(output: String) {
        // pretty colours
        // \u{001B}[\(attribute code ie bold, dim, normal);\(color code)m
        // Color codes
        // black   30   // blue    34
        // red     31   // magenta 35
        // green   32   // cyan    36
        // yellow  33   // white   37
        print("\u{001B}[0;31mError: " + output)
    }

    func printMessageToConsole(output: String) {
        print("\u{001B}[0;37m" + output)
    }

    func handleError(error: UnsafeMutablePointer<Int8>) {
        // print an error with a pretty colour code
        printErrorToConsole(output: error.debugDescription)
        printMessageToConsole(output: "Exiting") // reset console colour
        exit(1)
    }

    func handleResult(result: Int32, message: String) {
        if (result != 0) {
            var resultString: String

            // these error codes were taken from pcap.h
            switch result {
            case PCAP_IF_LOOPBACK:
                resultString = "don't try to sniff loopback"
            case PCAP_ERROR_BREAK:
                resultString = "loop terminated by pcap_breakloop"
            case PCAP_ERROR_NOT_ACTIVATED:
                resultString = "the capture needs to be activated"
            case PCAP_ERROR_ACTIVATED:
                resultString = "the operation can't be performed on already activated captures"
            case PCAP_ERROR_NO_SUCH_DEVICE:
                resultString = "no such device exists"
            case PCAP_ERROR_RFMON_NOTSUP:
                resultString = "this device doesn't support rfmon (monitor) mode"
            case PCAP_ERROR_NOT_RFMON:
                resultString = "operation supported only in monitor mode"
            case PCAP_ERROR_PERM_DENIED:
                resultString = "no permission to open the device (did you try sudo?)"
            case PCAP_ERROR_IFACE_NOT_UP:
                resultString = "interface isn't up"
            case PCAP_ERROR_CANTSET_TSTAMP_TYPE:
                resultString = "this device doesn't support setting the time stamp type"
            case PCAP_ERROR_PROMISC_PERM_DENIED:
                resultString = "you don't have permission to capture in promiscuous mode"
            case PCAP_ERROR_TSTAMP_PRECISION_NOTSUP:
                resultString = "the requested time stamp precision is not supported"
            case PCAP_WARNING:
                resultString = "generic warning code"
            case PCAP_WARNING_PROMISC_NOTSUP:
                resultString = "this device doesn't support promiscuous mode"
            case PCAP_WARNING_TSTAMP_TYPE_NOTSUP:
                resultString = "the requested time stamp type is not supported"
            default:
                resultString = "unknown error"
            }

            // print error condition and exit
            printErrorToConsole(output: "Result: " + resultString + " (" + String(result) + ")")
            printMessageToConsole(output: "Exiting") // reset console colour
            exit(1)
        }

    }

}
