//
//  GeocoderMiddleware.swift
//  MyAddresses
//
//  Created by Antoine SALLIOU on 26/02/2018.
//  Copyright © 2018 ViaMichelin. All rights reserved.
//

import Foundation
import ReSwift
import MapboxGeocoder

class GeocoderMiddleware {
    
    let geocoder = Geocoder.shared
    var pendingTask : URLSessionDataTask?
    
    func build() -> Middleware<Any> {
        return { dispatch, getState in
            return { next in
                return { action in
                    
                    if let action = action as? SearchTextDidChange {
                        self.geocode(query: action.searchText)
                    } else if let action = action as? MapDidUpdate {
                        self.reverseGeocode(coordinate: action.center)
                    } else if let action = action as? UserLocationDidUpdate {
                        self.reverseGeocode(coordinate: action.location.coordinate)
                    }
                    return next(action)
                }
            }
        }
    }
    
    func geocode(query: String) {
        let options = ForwardGeocodeOptions(query: query)
        
        options.allowedISOCountryCodes = ["FR"]
        options.focalLocation = CLLocation(latitude: 48.856484, longitude: 2.352207)
        options.allowedScopes = [.address, .pointOfInterest]
        
        self.pendingTask?.cancel()
        self.pendingTask = self.geocoder.geocode(options) { (placemarks : [MapboxGeocoder.GeocodedPlacemark]?, attribution, error) in
            self.pendingTask = nil
            
            guard placemarks != nil else {
                return
            }
            var searchResults : [Address] = []
            for placemark in placemarks! {
                if placemark.qualifiedName != nil && placemark.location != nil {
                    let address = Address(description: placemark.qualifiedName!, coordinate: placemark.location!.coordinate)
                    searchResults.append(address)
                }
            }
            
            mainStore.dispatch(SearchDidFoundAddresses(addresses: searchResults))
        }
    }
    
    func reverseGeocode(coordinate: CLLocationCoordinate2D) {
        let options = ReverseGeocodeOptions(coordinate: coordinate)
        
        self.pendingTask?.cancel()
        self.pendingTask = self.geocoder.geocode(options) { (placemarks, attribution, error) in
            self.pendingTask = nil
            
            guard let placemark = placemarks?.first else {
                return
            }
            
            if placemark.qualifiedName != nil && placemark.location != nil {
                mainStore.dispatch(SearchDidReverseGeocodeAddress(address: Address(description: placemark.qualifiedName!, coordinate: placemark.location!.coordinate)))
            }
        }
    }
}
