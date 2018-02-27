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

struct AppState: StateType, Equatable {
    let mapCenterCoordinate: CLLocationCoordinate2D
    let mapZoomLevel: Double
    let mapShouldUpdate : Bool
    let pinVisible: Bool
    let errorMessage : String?
    let searchBarIsEditing : Bool
    let searchBarContent : String
    let searchResultVisible : Bool
    let searchResults : [Address]
    
    static func ==(lhs: AppState, rhs: AppState) -> Bool {
        return Double(lhs.mapCenterCoordinate.latitude).isEqual(to: rhs.mapCenterCoordinate.latitude) &&
            Double(lhs.mapCenterCoordinate.longitude).isEqual(to: rhs.mapCenterCoordinate.longitude) &&
            lhs.mapZoomLevel.isEqual(to: rhs.mapZoomLevel) &&
            lhs.mapShouldUpdate == rhs.mapShouldUpdate &&
            lhs.pinVisible == rhs.pinVisible &&
            lhs.errorMessage == rhs.errorMessage &&
            lhs.searchBarIsEditing == rhs.searchBarIsEditing &&
            lhs.searchBarContent == rhs.searchBarContent &&
            lhs.searchResultVisible == rhs.searchResultVisible &&
            lhs.searchResults == rhs.searchResults
    }
}
