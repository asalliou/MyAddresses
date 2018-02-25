//
//  UserLocationMiddleware.swift
//  MyAddresses
//
//  Created by Antoine SALLIOU on 25/02/2018.
//  Copyright © 2018 ViaMichelin. All rights reserved.
//

import Foundation
import ReSwift
import CoreLocation

class UserLocationMiddleware : NSObject, CLLocationManagerDelegate {
    
    let coreLocationManager : CLLocationManager = CLLocationManager()
    
    override init() {
        super.init()
        
        coreLocationManager.delegate = self
        coreLocationManager.distanceFilter = 10
        coreLocationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
    }
    
    deinit {
        coreLocationManager.stopUpdatingLocation()
    }
    
    func build() -> Middleware<Any> {
        return { dispatch, getState in
            return { next in
                return { action in
                    
                    if action is ReSwiftInit {
                        switch CLLocationManager.authorizationStatus() {
                        case .notDetermined:
                            self.coreLocationManager.requestWhenInUseAuthorization()
                        case .authorizedWhenInUse:
                            self.coreLocationManager.requestLocation()
                        default:
                            break;
                        }
                    }
                    
                    return next(action)
                }
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print ("locationManager:didFailWithError:")
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if (status == .authorizedWhenInUse) {
            self.coreLocationManager.requestLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if (locations.count > 0) {
            mainStore.dispatch(UserLocationDidUpdate(location: locations.first!))
        }
    }
}
