//
//  Actions.swift
//  MyAddresses
//
//  Created by Antoine SALLIOU on 24/02/2018.
//  Copyright © 2018 ViaMichelin. All rights reserved.
//

import Foundation
import ReSwift
import CoreLocation

struct UserLocationDidUpdate: Action {
    let location : CLLocation
}

struct UserLocationDidFail: Action {
    let message : String
}

struct UserLocationUnauthorized: Action {
    let message : String
}

struct SearchDidBegin: Action {}

struct SearchDidEnd: Action {}

struct SearchTextDidChange : Action {
    let searchText : String
}

struct SearchDidFoundAddresses : Action {
    let addresses : [Address]
}
