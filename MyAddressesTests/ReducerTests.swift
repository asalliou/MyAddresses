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
                                    pinVisible: false,
                                    errorMessage : nil,
                                    searchBarIsEditing: false,
                                    searchBarContent: "",
                                    searchResultVisible: false,
                                    searchResults : [])
        
        let appState : AppState = appReducer(action: action, state: initialState)
        
        XCTAssertEqual(expectedLat, appState.mapCenterCoordinate.latitude, accuracy: 0.0001)
        XCTAssertEqual(expectedLng, appState.mapCenterCoordinate.longitude, accuracy: 0.0001)
        XCTAssertEqual(2, appState.mapZoomLevel)
        XCTAssertTrue(appState.pinVisible)
        XCTAssertNil(appState.errorMessage)
    }
    
    func testUserLocationDidFail() {
        let expectedMessage = "abc"
        let action = UserLocationDidFail(message: expectedMessage)
        
        verifyLocationError(action: action, expectedMessage: expectedMessage)
    }
    
    func testUserLocationUnauthorized() {
        let expectedMessage = "abc"
        let action = UserLocationUnauthorized(message: expectedMessage)
        
        verifyLocationError(action: action, expectedMessage: expectedMessage)
    }
    
    func verifyLocationError(action : Action, expectedMessage : String) {
        let initialState = AppState(mapCenterCoordinate: CLLocationCoordinate2D(latitude: 1, longitude: 2),
                                    mapZoomLevel: 2,
                                    pinVisible: false,
                                    errorMessage : nil,
                                    searchBarIsEditing: false,
                                    searchBarContent: "",
                                    searchResultVisible: false,
                                    searchResults : [])
        
        let appState : AppState = appReducer(action: action, state: initialState)
        
        XCTAssertEqual(1, appState.mapCenterCoordinate.latitude, accuracy: 0.0001)
        XCTAssertEqual(2, appState.mapCenterCoordinate.longitude, accuracy: 0.0001)
        XCTAssertEqual(2, appState.mapZoomLevel)
        XCTAssertFalse(appState.pinVisible)
        XCTAssertEqual(expectedMessage, appState.errorMessage)
    }
    
    func testSearchDidBegin() {
        let action = SearchDidBegin()
        let initialState = AppState(mapCenterCoordinate: CLLocationCoordinate2D(latitude: 1, longitude: 2),
                                    mapZoomLevel: 2,
                                    pinVisible: false,
                                    errorMessage : nil,
                                    searchBarIsEditing: false,
                                    searchBarContent: "",
                                    searchResultVisible: false,
                                    searchResults : [])
        
        let appState : AppState = appReducer(action: action, state: initialState)
        
        XCTAssertFalse(appState.pinVisible)
        XCTAssertTrue(appState.searchResultVisible)
        XCTAssertTrue(appState.searchBarIsEditing)
    }
    
    func testSearchDidEnd() {
        let action = SearchDidEnd()
        let initialState = AppState(mapCenterCoordinate: CLLocationCoordinate2D(latitude: 1, longitude: 2),
                                    mapZoomLevel: 2,
                                    pinVisible: false,
                                    errorMessage : nil,
                                    searchBarIsEditing: false,
                                    searchBarContent: "",
                                    searchResultVisible: false,
                                    searchResults : [])
        
        let appState : AppState = appReducer(action: action, state: initialState)
        
        XCTAssertTrue(appState.pinVisible)
        XCTAssertFalse(appState.searchResultVisible)
        XCTAssertFalse(appState.searchBarIsEditing)
    }
    
    func testSearchTextDidChange() {
        let action = SearchTextDidChange(searchText: "test")
        let initialState = AppState(mapCenterCoordinate: CLLocationCoordinate2D(latitude: 1, longitude: 2),
                                    mapZoomLevel: 2,
                                    pinVisible: false,
                                    errorMessage : nil,
                                    searchBarIsEditing: false,
                                    searchBarContent: "",
                                    searchResultVisible: false,
                                    searchResults : [])
        
        let appState : AppState = appReducer(action: action, state: initialState)
        XCTAssertEqual("test", appState.searchBarContent)
    }
    
    func testSearchDidFoundAddresses() {
        let addresses = [Address(description: "azerty", coordinate: CLLocationCoordinate2D(latitude: 3, longitude: 2))]
        let action = SearchDidFoundAddresses(addresses: [Address(description: "azerty", coordinate: CLLocationCoordinate2D(latitude: 3, longitude: 2))])
        let initialState = AppState(mapCenterCoordinate: CLLocationCoordinate2D(latitude: 1, longitude: 2),
                                    mapZoomLevel: 2,
                                    pinVisible: false,
                                    errorMessage : nil,
                                    searchBarIsEditing: false,
                                    searchBarContent: "",
                                    searchResultVisible: false,
                                    searchResults : [])
        
        let appState : AppState = appReducer(action: action, state: initialState)
        
        XCTAssertEqual(addresses, appState.searchResults)
    }
    
    func testSearchAddressDidSelect() {
        let coordinate = CLLocationCoordinate2D(latitude: 3, longitude: 2)
        let address = Address(description: "azerty", coordinate: coordinate)
        let action = SearchAddressDidSelect(address: address)
        let initialState = AppState(mapCenterCoordinate: CLLocationCoordinate2D(latitude: 1, longitude: 2),
                                    mapZoomLevel: 2,
                                    pinVisible: false,
                                    errorMessage : nil,
                                    searchBarIsEditing: false,
                                    searchBarContent: "",
                                    searchResultVisible: false,
                                    searchResults : [])
        
        let appState : AppState = appReducer(action: action, state: initialState)
        XCTAssertEqual(coordinate.latitude, appState.mapCenterCoordinate.latitude)
        XCTAssertFalse(appState.searchResultVisible)
        XCTAssertTrue(appState.pinVisible)
        XCTAssertFalse(appState.searchBarIsEditing)
        XCTAssertEqual("azerty", appState.searchBarContent)
    }
}
