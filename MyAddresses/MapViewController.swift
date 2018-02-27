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

class MapViewController: UIViewController, StoreSubscriber, MGLMapViewDelegate {
    
    @IBOutlet weak var pinView: UIImageView!
    var mapView : MGLMapView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView = MGLMapView(frame: self.view.bounds)
        mapView?.delegate = self
        mapView!.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.view.insertSubview(mapView!, belowSubview: pinView)
        
        mainStore.subscribe(self) { subcription in
            subcription.skipRepeats()
        }
    }
    
    func newState(state: AppState) {
        if mapView != nil && state.mapShouldUpdate {
            mapView!.setCenter(state.mapCenterCoordinate, zoomLevel: state.mapZoomLevel, animated: true)
        }
        
        pinView.isHidden = !state.pinVisible
    }
    
    func mapView(_ mapView: MGLMapView, regionDidChangeWith reason: MGLCameraChangeReason, animated: Bool) {
        if reason == .none {
            print ("MGLCameraChangeReasonNone")
        } else if reason == .programmatic {
            print ("programmatic")
        } else {
            print ("user change")
            mainStore.dispatch(MapDidUpdate(center: mapView.centerCoordinate, zoomLevel: mapView.zoomLevel))
        }
    }
}
