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
    let searchResultVisible : Bool
}

class AppStateBuilder {
    var mapCenterCoordinate: CLLocationCoordinate2D
    var mapZoomLevel: Double
    var pinVisible: Bool
    var errorMessage : String?
    var searchResultVisible : Bool
    
    typealias BuilderClosure = (AppStateBuilder) -> Void
    
    init(initialState: AppState?, buildClosure: BuilderClosure?) {
        if initialState == nil {
            mapCenterCoordinate = CLLocationCoordinate2D(latitude: 48.856484, longitude: 2.352207)
            mapZoomLevel = 15
            pinVisible = false
            errorMessage = nil
            searchResultVisible = false
        } else {
            mapCenterCoordinate = initialState!.mapCenterCoordinate
            mapZoomLevel = initialState!.mapZoomLevel
            pinVisible = initialState!.pinVisible
            errorMessage = initialState!.errorMessage
            searchResultVisible = initialState!.searchResultVisible
        }
        
        if buildClosure != nil {
            buildClosure!(self)
        }
    }
    
    func build() -> AppState {
        return AppState(mapCenterCoordinate: mapCenterCoordinate,
                        mapZoomLevel: mapZoomLevel,
                        pinVisible: pinVisible,
                        errorMessage: errorMessage,
                        searchResultVisible: searchResultVisible)
    }
}
