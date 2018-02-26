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
                        let options = ForwardGeocodeOptions(query: action.searchText)
                        
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
                                searchResults.append(Address(description: placemark.qualifiedName ?? ""))
                            }
                            
                            mainStore.dispatch(SearchDidFoundAddresses(addresses: searchResults))
                        }
                    }
                    
                    return next(action)
                }
            }
        }
    }
}
