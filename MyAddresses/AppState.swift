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
}

class AppStateBuilder {
    var mapCenterCoordinate: CLLocationCoordinate2D
    var mapZoomLevel: Double
    
    typealias BuilderClosure = (AppStateBuilder) -> Void
    
    init(initialState: AppState?, buildClosure: BuilderClosure?) {
        if initialState == nil {
            self.mapCenterCoordinate = CLLocationCoordinate2D(latitude: 48.856484, longitude: 2.352207)
            self.mapZoomLevel = 15
        } else {
            self.mapCenterCoordinate = initialState!.mapCenterCoordinate
            self.mapZoomLevel = initialState!.mapZoomLevel
        }
        
        if buildClosure != nil {
            buildClosure!(self)
        }
    }
    
    func build() -> AppState {
        return AppState(mapCenterCoordinate: self.mapCenterCoordinate, mapZoomLevel: self.mapZoomLevel)
    }
}
