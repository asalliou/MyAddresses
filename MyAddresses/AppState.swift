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
}

class AppStateBuilder {
    var mapCenterCoordinate: CLLocationCoordinate2D
    var mapZoomLevel: Double
    var pinVisible: Bool
    
    typealias BuilderClosure = (AppStateBuilder) -> Void
    
    init(initialState: AppState?, buildClosure: BuilderClosure?) {
        if initialState == nil {
            mapCenterCoordinate = CLLocationCoordinate2D(latitude: 48.856484, longitude: 2.352207)
            mapZoomLevel = 15
            pinVisible = false
        } else {
            mapCenterCoordinate = initialState!.mapCenterCoordinate
            mapZoomLevel = initialState!.mapZoomLevel
            pinVisible = initialState!.pinVisible
        }
        
        if buildClosure != nil {
            buildClosure!(self)
        }
    }
    
    func build() -> AppState {
        return AppState(mapCenterCoordinate: mapCenterCoordinate,
                        mapZoomLevel: mapZoomLevel,
                        pinVisible: pinVisible)
    }
}
