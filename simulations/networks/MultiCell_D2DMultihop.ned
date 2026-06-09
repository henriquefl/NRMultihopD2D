//
//                  Simu5G
//
// Authors: Giovanni Nardini, Giovanni Stea, Antonio Virdis (University of Pisa)
//
// This file is part of a software released under the license included in file
// "license.pdf". Please read LICENSE and README files before using it.
// The above files and the present reference are part of the software itself,
// and cannot be removed from it.
//
package simu5g.simulations.NR.networks;

import inet.networklayer.configurator.ipv4.Ipv4NetworkConfigurator;
import inet.networklayer.ipv4.RoutingTableRecorder;
import inet.node.ethernet.Eth10G;
import inet.node.inet.Router;
import inet.node.inet.StandardHost;
import simu5g.apps.d2dMultihop.eventGenerator.EventGenerator;
import simu5g.apps.d2dMultihop.statistics.MultihopD2DStatistics;
import simu5g.common.binder.Binder;
import simu5g.common.carrierAggregation.CarrierAggregation;
import simu5g.nodes.NR.NRUe;
import simu5g.nodes.NR.gNodeB;
import simu5g.nodes.Upf;
import simu5g.world.radio.LteChannelControl;


// MultiCell_D2DMultihop
//
// This network represents a 5G NR multi-cell deployment with D2D multihop support.
// UEs are deployed along a straight line and served by five gNodeBs.
// Each UE runs a MultihopD2D application instance, which broadcasts event
// notifications via D2D multicast transmissions and relays received messages
// to extend D2D coverage across multiple cells.
//
network MultiCell_D2DMultihop
{
    parameters:
        int numUe1 = default(1);
//        int numUe2 = default(1);
//        int numUe3 = default(1);
//        int numUe4 = default(1);
//        int numUe5 = default(1);
        @display("i=block/network2;bgb=2000,500;");
    submodules:
        channelControl: LteChannelControl {
            @display("p=90,24;is=s");
        }
        routingRecorder: RoutingTableRecorder {
            @display("p=90,70;is=s");
        }
        configurator: Ipv4NetworkConfigurator {
            @display("p=90,121");
        }
        binder: Binder {
            @display("p=90,171;is=s");
        }
        carrierAggregation: CarrierAggregation {
            @display("p=50,258;is=s");
        }
        server: StandardHost {
            @display("p=500,50;is=n;i=device/server");
        }
        router: Router {
            @display("p=750,50;i=device/smallrouter");
        }
        upf: Upf {
            @display("p=1000,50");
        }
        iUpf: Upf {
            @display("p=1000,150");
        }
        router1: Router {
            @display("p=200,250;i=device/smallrouter");
        }
//        router2: Router {
//            @display("p=600,250;i=device/smallrouter");
//        }
//        router3: Router {
//            @display("p=1000,250;i=device/smallrouter");
//        }
//        router4: Router {
//            @display("p=1400,250;i=device/smallrouter");
//        }
//        router5: Router {
//            @display("p=1800,250;i=device/smallrouter");
//        }
        gnb1: gNodeB {
            @display("p=200,400;is=vl");
        }
//        gnb2: gNodeB {
//            @display("p=600,400;is=vl");
//        }
//        gnb3: gNodeB {
//            @display("p=1000,400;is=vl");
//        }
//        gnb4: gNodeB {
//            @display("p=1400,400;is=vl");
//        }
//        gnb5: gNodeB {
//            @display("p=1800,400;is=vl");
//        }
        ue1[numUe1]: NRUe {
            @display("p=300,450;is=s");
        }
//        ue2[numUe2]: NRUe {
//            @display("p=700,450;is=s");
//        }
//        ue3[numUe3]: NRUe {
//            @display("p=1100,450;is=s");
//        }
//        ue4[numUe4]: NRUe {
//            @display("p=1500,450;is=s");
//        }
//        ue5[numUe5]: NRUe {
//            @display("p=1900,450;is=s");
//        }
        eventGenerator: EventGenerator {
            @display("p=90,222;is=s");
        }
        d2dMultihopStatistics: MultihopD2DStatistics {
            @display("p=90,272;is=s");
        }
    connections:
        server.pppg++ <--> Eth10G <--> router.pppg++;
        router.pppg++ <--> Eth10G <--> upf.filterGate;
        upf.pppg++ <--> Eth10G <--> iUpf.pppg++;

        iUpf.pppg++ <--> Eth10G <--> router1.pppg++;
//        iUpf.pppg++ <--> Eth10G <--> router2.pppg++;
//        iUpf.pppg++ <--> Eth10G <--> router3.pppg++;
//        iUpf.pppg++ <--> Eth10G <--> router4.pppg++;
//        iUpf.pppg++ <--> Eth10G <--> router5.pppg++;

        router1.pppg++ <--> Eth10G <--> gnb1.ppp;
//        router2.pppg++ <--> Eth10G <--> gnb2.ppp;
//        router3.pppg++ <--> Eth10G <--> gnb3.ppp;
//        router4.pppg++ <--> Eth10G <--> gnb4.ppp;
//        router5.pppg++ <--> Eth10G <--> gnb5.ppp;
}
