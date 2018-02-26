//
//  SearchResultViewController.swift
//  MyAddresses
//
//  Created by Antoine SALLIOU on 25/02/2018.
//  Copyright © 2018 ViaMichelin. All rights reserved.
//

import Foundation
import UIKit
import ReSwift

class SearchResultViewController: UIViewController, StoreSubscriber {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainStore.subscribe(self)
    }
    
    func newState(state: AppState) {
        self.view.isHidden = !state.searchResultVisible
        self.view.isUserInteractionEnabled = state.searchResultVisible
    }
}
