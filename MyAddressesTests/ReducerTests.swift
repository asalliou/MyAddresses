//
//  ReducerTests.swift
//  MyAddressesTests
//
//  Created by Antoine SALLIOU on 25/02/2018.
//  Copyright © 2018 ViaMichelin. All rights reserved.
//

import XCTest
import CoreLocation
import ReSwift

@testable import MyAddresses

class AnyAction : Action {}

class ReducerTests: XCTestCase {
    
    func testDefaultMapCenter() {
        
        let appState : AppState = appReducer(action:AnyAction(), state: nil)
        
        XCTAssertEqual(48.856484, appState.mapCenterCoordinate.latitude, accuracy: 0.0001)
        XCTAssertEqual(2.352207, appState.mapCenterCoordinate.longitude, accuracy: 0.0001)
        XCTAssertEqual(15, appState.mapZoomLevel)
        
    }
    
    func testUserLocationDidUpdate() {
        let expectedLat : Double = 1
        let expectedLng : Double = 2
        
        let action = UserLocationDidUpdate(location: CLLocation(latitude: expectedLat, longitude: expectedLng))
        let initialState = AppState(mapCenterCoordinate: CLLocationCoordinate2D(latitude: 3, longitude: 4),
                                    mapZoomLevel: 2,
                                    pinVisible: false)
        
        let appState : AppState = appReducer(action: action, state: initialState)
        
        XCTAssertEqual(expectedLat, appState.mapCenterCoordinate.latitude, accuracy: 0.0001)
        XCTAssertEqual(expectedLng, appState.mapCenterCoordinate.longitude, accuracy: 0.0001)
        XCTAssertEqual(2, appState.mapZoomLevel)
        XCTAssertTrue(appState.pinVisible)
    }
}
