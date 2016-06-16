//
//  ViewController.swift
//  ChangeColorBeacons
//
//  Created by Jorge Casariego on 15/6/16.
//  Copyright © 2016 Jorge Casariego. All rights reserved.
//
//  This project is a tutorial did it from this url: https://willd.me/posts/getting-started-with-ibeacon-a-swift-tutorial
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()
    let region = CLBeaconRegion(proximityUUID: NSUUID(UUIDString: "B9407F30-F5F8-466E-AFF9-25556B57FE6D")!,
                                identifier: "Estimotes")
    
    // En este caso identificamos el beacon con el minor value
    let colors = [
        33963: UIColor(red: 0.78, green: 0.91, blue: 0.95, alpha: 1),
        34365: UIColor(red: 0.80, green: 0.95, blue: 0.78, alpha: 1),
        53794: UIColor(red: 0.50, green: 0.40, blue: 0.64, alpha: 1)
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        
        if(CLLocationManager.authorizationStatus() != CLAuthorizationStatus.AuthorizedWhenInUse){
                locationManager.requestWhenInUseAuthorization()
        }
        
        locationManager.startRangingBeaconsInRegion(region)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func locationManager(manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], inRegion region: CLBeaconRegion) {
        let knownBeacons = beacons.filter{ $0.proximity != CLProximity.Unknown }
        if (knownBeacons.count > 0) {
            let closestBeacon = knownBeacons[0] as CLBeacon
            print("El beacon mas cercano es: \(closestBeacon.minor.integerValue)")
                
            self.view.backgroundColor = self.colors[closestBeacon.minor.integerValue]
        }
    }

}

