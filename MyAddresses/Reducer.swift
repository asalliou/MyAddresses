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
        }
    })
    
    return builder.build()
}
