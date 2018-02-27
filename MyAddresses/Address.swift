//
//  Address.swift
//  MyAddresses
//
//  Created by Antoine SALLIOU on 26/02/2018.
//  Copyright © 2018 ViaMichelin. All rights reserved.
//

import Foundation
import CoreLocation

struct Address : Equatable {
    let description : String
    let coordinate : CLLocationCoordinate2D
    
    static func ==(lhs: Address, rhs: Address) -> Bool {
        return lhs.description == rhs.description &&
        Double(lhs.coordinate.latitude).isEqual(to: rhs.coordinate.latitude) &&
        Double(lhs.coordinate.longitude).isEqual(to: rhs.coordinate.longitude)
    }
}
