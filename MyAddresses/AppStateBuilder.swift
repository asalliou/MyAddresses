//
//  AppStateBuilder.swift
//  MyAddresses
//
//  Created by Antoine SALLIOU on 26/02/2018.
//  Copyright © 2018 ViaMichelin. All rights reserved.
//

import Foundation
import CoreLocation

class AppStateBuilder {
    var mapCenterCoordinate: CLLocationCoordinate2D
    var mapZoomLevel: Double
    var mapShouldUpdate : Bool
    var pinVisible: Bool
    var errorMessage : String?
    var searchBarIsEditing : Bool
    var searchBarContent : String
    var searchResultVisible : Bool
    var searchResults : [Address]
    
    typealias BuilderClosure = (AppStateBuilder) -> Void
    
    init(initialState: AppState?, buildClosure: BuilderClosure?) {
        if initialState == nil {
            mapCenterCoordinate = CLLocationCoordinate2D(latitude: 48.856484, longitude: 2.352207)
            mapZoomLevel = 15
            mapShouldUpdate = false
            pinVisible = false
            errorMessage = nil
            searchBarIsEditing = false
            searchBarContent = ""
            searchResultVisible = false
            searchResults = []
        } else {
            mapCenterCoordinate = initialState!.mapCenterCoordinate
            mapZoomLevel = initialState!.mapZoomLevel
            mapShouldUpdate = initialState!.mapShouldUpdate
            pinVisible = initialState!.pinVisible
            errorMessage = initialState!.errorMessage
            searchBarIsEditing = initialState!.searchBarIsEditing
            searchBarContent = initialState!.searchBarContent
            searchResultVisible = initialState!.searchResultVisible
            searchResults = initialState!.searchResults
        }
        
        if buildClosure != nil {
            buildClosure!(self)
        }
    }
    
    func build() -> AppState {
        return AppState(mapCenterCoordinate: mapCenterCoordinate,
                        mapZoomLevel: mapZoomLevel,
                        mapShouldUpdate: mapShouldUpdate,
                        pinVisible: pinVisible,
                        errorMessage: errorMessage,
                        searchBarIsEditing: searchBarIsEditing,
                        searchBarContent: searchBarContent,
                        searchResultVisible: searchResultVisible,
                        searchResults: searchResults)
    }
}
