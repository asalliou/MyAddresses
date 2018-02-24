//
//  ViewController.swift
//  MyAddresses
//
//  Created by Antoine SALLIOU on 21/02/2018.
//  Copyright © 2018 ViaMichelin. All rights reserved.
//

import UIKit
import Mapbox
import ReSwift

class ViewController: UIViewController, StoreSubscriber {
    
    var mapView : MGLMapView?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView = MGLMapView(frame: self.view.bounds)
        mapView!.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.view.addSubview(mapView!)
        
        mainStore.subscribe(self)
    }
    
    func newState(state: AppState) {
        if mapView != nil {
            mapView!.centerCoordinate = state.mapCenterCoordinate
            mapView!.zoomLevel = 15
        }
        return
    }
}

