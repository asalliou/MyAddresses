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
        let initialState = AppStateBuilder(initialState: nil, buildClosure: nil).build()
        
        let appState : AppState = appReducer(action: action, state: initialState)
        
        XCTAssertEqual(expectedLat, appState.mapCenterCoordinate.latitude, accuracy: 0.0001)
        XCTAssertEqual(expectedLng, appState.mapCenterCoordinate.longitude, accuracy: 0.0001)
        XCTAssertEqual(15, appState.mapZoomLevel)
        XCTAssertTrue(appState.mapShouldUpdate)
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
        let initialState = AppStateBuilder(initialState: nil, buildClosure: nil).build()
        
        let appState : AppState = appReducer(action: action, state: initialState)
        
        XCTAssertEqual(48.856484, appState.mapCenterCoordinate.latitude, accuracy: 0.0001)
        XCTAssertEqual(2.352207, appState.mapCenterCoordinate.longitude, accuracy: 0.0001)
        XCTAssertEqual(15, appState.mapZoomLevel)
        XCTAssertFalse(appState.pinVisible)
        XCTAssertEqual(expectedMessage, appState.errorMessage)
    }
    
    func testSearchDidBegin() {
        let action = SearchDidBegin()
        let initialState = AppStateBuilder(initialState: nil, buildClosure: nil).build()
        
        let appState : AppState = appReducer(action: action, state: initialState)
        
        XCTAssertFalse(appState.pinVisible)
        XCTAssertTrue(appState.searchResultVisible)
        XCTAssertTrue(appState.searchBarIsEditing)
    }
    
    func testSearchDidEnd() {
        let action = SearchDidEnd()
        let initialState = AppStateBuilder(initialState: nil, buildClosure: nil).build()
        
        let appState : AppState = appReducer(action: action, state: initialState)
        
        XCTAssertTrue(appState.pinVisible)
        XCTAssertFalse(appState.searchResultVisible)
        XCTAssertFalse(appState.searchBarIsEditing)
    }
    
    func testSearchTextDidChange() {
        let action = SearchTextDidChange(searchText: "test")
        let initialState = AppStateBuilder(initialState: nil, buildClosure: nil).build()
        
        let appState : AppState = appReducer(action: action, state: initialState)
        XCTAssertEqual("test", appState.searchBarContent)
    }
    
    func testSearchDidFoundAddresses() {
        let addresses = [Address(description: "azerty", coordinate: CLLocationCoordinate2D(latitude: 3, longitude: 2))]
        let action = SearchDidFoundAddresses(addresses: [Address(description: "azerty", coordinate: CLLocationCoordinate2D(latitude: 3, longitude: 2))])
        let initialState = AppStateBuilder(initialState: nil, buildClosure: nil).build()
        
        let appState : AppState = appReducer(action: action, state: initialState)
        
        XCTAssertEqual(addresses, appState.searchResults)
    }
    
    func testSearchAddressDidSelect() {
        let coordinate = CLLocationCoordinate2D(latitude: 3, longitude: 2)
        let address = Address(description: "azerty", coordinate: coordinate)
        let action = SearchAddressDidSelect(address: address)
        let initialState = AppStateBuilder(initialState: nil, buildClosure: nil).build()
        
        let appState : AppState = appReducer(action: action, state: initialState)
        XCTAssertEqual(coordinate.latitude, appState.mapCenterCoordinate.latitude)
        XCTAssertTrue(appState.mapShouldUpdate)
        XCTAssertFalse(appState.searchResultVisible)
        XCTAssertTrue(appState.pinVisible)
        XCTAssertFalse(appState.searchBarIsEditing)
        XCTAssertEqual("azerty", appState.searchBarContent)
    }
    
    func testMapCenterDidUpdate() {
        let coordinate = CLLocationCoordinate2D(latitude: 3, longitude: 2)
        let action = MapDidUpdate(center: coordinate, zoomLevel: 3)
        let initialState = AppStateBuilder(initialState: nil, buildClosure: nil).build()
        let appState : AppState = appReducer(action: action, state: initialState)
        
        XCTAssertEqual(coordinate.latitude, appState.mapCenterCoordinate.latitude)
        XCTAssertEqual(coordinate.longitude, appState.mapCenterCoordinate.longitude)
        XCTAssertEqual(3, appState.mapZoomLevel)
        XCTAssertFalse(appState.mapShouldUpdate)
    }
    
    func testSearchDidReverseGeocodeAddress() {
        let coordinate = CLLocationCoordinate2D(latitude: 3, longitude: 2)
        let address = Address(description: "azerty", coordinate: coordinate)
        let action = SearchDidReverseGeocodeAddress(address: address)
        
        let initialState = AppStateBuilder(initialState: nil, buildClosure: nil).build()
        let appState : AppState = appReducer(action: action, state: initialState)
        
        XCTAssertFalse(appState.mapShouldUpdate)
        XCTAssertEqual("azerty", appState.searchBarContent)
    }
}
