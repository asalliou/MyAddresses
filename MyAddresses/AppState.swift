//
//  AppState.swift
//  MyAddresses
//
//  Created by Antoine SALLIOU on 24/02/2018.
//  Copyright © 2018 ViaMichelin. All rights reserved.
//

import Foundation
import ReSwift
import CoreLocation

struct AppState: StateType {
    let mapCenterCoordinate: CLLocationCoordinate2D
    let mapZoomLevel: Double
    let pinVisible: Bool
    let errorMessage : String?
    let searchBarIsEditing : Bool
    let searchBarContent : String
    let searchResultVisible : Bool
    let searchResults : [Address]
}
