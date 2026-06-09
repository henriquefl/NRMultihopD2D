# NRMultihopD2D

This module implements an application for disseminating event notifications, using multihop D2D transmissions. New messages are generated upon the reception of external events, signaled by the EventGenerator module. The application sends the message to an IP multicast address, which is then mapped to D2D multicast transmission mode within the LTE/NR protocol stack. When the application receives a message, it can relay it to the same IP multicast address in order to extend the coverage of the D2D transmission. To avoid flooding, two mechanisms can be used:

* specifying a time-to-live (TTL) for the message, which decreases every time the message is relayed by a UE;
* specifying a target broadcast radius for the message: a UE relays the message only if it is located within a configurable distance from the originator.

Moreover, if the Trickle suppression mechanism is enabled, the application avoids relaying a message when more than 'k' duplicates have already been received.

Every message originated by a node is associated with a *target area*, i.e., the set of nodes that should receive the notification. This is used for gathering statistics about the dissemination of the message.

Reference: G. Nardini, G. Stea, A. Virdis, "A fast and reliable broadcast service for LTE-Advanced exploiting multihop device-to-device transmissions", Future Internet, 2017, 9(4), 89

[https://simu5g.org/neddoc/simu5g.apps.d2dMultihop.MultihopD2D.html]

The `omnetpp.ini` for the NR D2D multihop scenario is based on the LTE version with three critical NR-specific adaptations:
 
1. __NR cell association__: UEs set `macCellId=0, masterId=0` (no LTE master) and `nrMacCellId/N, nrMasterId/N` (NR master = their gNodeB). This makes `IP2Nic::markPacket()` route all traffic through the NR stack.
 
2. __NR NIC types__: `cellularNic.typename = "NRNicUe"` / `"NRNicEnb"` instead of LTE NICs, plus `d2dInitialMode = true` to start D2D flows in direct mode.
 
3. __App module path override__: `lteMacModule = "^.cellularNic.nrMac"` and `ltePhyModule = "^.cellularNic.nrPhy"` — this redirects the MultihopD2D app to use NR submodules so it obtains NR node IDs for D2D multicast registration and routing. This is the only change needed to make the LTE application work with NR.
 
The four config variants (MultihopD2D, MultihopD2D-Trickle, MultihopD2D-rangeCheck, MultihopD2D-rangeCheckTrickle) mirror the LTE scenario, with NR-specific parameters like `nrChannelModel`, `nrPhy.d2dTxPower`, and `nrPhy.enableMulticastD2DRangeCheck` properly set.

For class diagram, please check the following file:
![Page 1](images/lte_to_nr.png)
