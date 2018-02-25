//
//  MapViewController.swift
//  MyAddresses
//
//  Created by Antoine SALLIOU on 25/02/2018.
//  Copyright © 2018 ViaMichelin. All rights reserved.
//

import Foundation
import Mapbox
import ReSwift

class MapViewController: UIViewController, StoreSubscriber {
    
    @IBOutlet weak var pinView: UIImageView!
    var mapView : MGLMapView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView = MGLMapView(frame: self.view.bounds)
        mapView!.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.view.insertSubview(mapView!, belowSubview: pinView)
        
        mainStore.subscribe(self)
    }
    
    func newState(state: AppState) {
        if mapView != nil {
            mapView!.centerCoordinate = state.mapCenterCoordinate
            mapView!.zoomLevel = 15
            pinView.isHidden = !state.pinVisible
        }
    }
}
