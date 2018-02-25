//
//  Reducer.swift
//  MyAddresses
//
//  Created by Antoine SALLIOU on 24/02/2018.
//  Copyright © 2018 ViaMichelin. All rights reserved.
//

import Foundation
import ReSwift

func appReducer(action: Action, state: AppState?) -> AppState {
    let builder = AppStateBuilder(initialState: state, buildClosure: { builder in
    
        if let action = action as? UserLocationDidUpdate {
            builder.mapCenterCoordinate = action.location.coordinate
            builder.pinVisible = true
            builder.errorMessage = nil
        } else if let action = action as? UserLocationDidFail {
            builder.errorMessage = action.message
        } else if let action = action as? UserLocationUnauthorized {
            builder.errorMessage = action.message
        } else if action is SearchDidBegin {
            builder.pinVisible = false
            builder.searchResultVisible = true
        } else if action is SearchDidEnd {
            builder.pinVisible = true
            builder.searchResultVisible = false
        }
    })
    
    return builder.build()
}
