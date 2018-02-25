//
//  MainViewController.swift
//  MyAddresses
//
//  Created by Antoine SALLIOU on 21/02/2018.
//  Copyright © 2018 ViaMichelin. All rights reserved.
//

import UIKit
import Mapbox
import ReSwift

class MainViewController: UIViewController, StoreSubscriber {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainStore.subscribe(self)
    }
    
    func newState(state: AppState) {
        if state.errorMessage != nil {
            let cancelAction = UIAlertAction(
                title: "Ok",
                style: .cancel)
            let alert = UIAlertController(title: "Error", message: state.errorMessage!, preferredStyle: .alert)
            alert.addAction(cancelAction)
            
            dismissErrorIfNeeded(completion: {
                self.present(alert, animated: true, completion: nil)
            })
        } else {
            dismissErrorIfNeeded()
        }
    }
    
    func dismissErrorIfNeeded(completion: (() -> Swift.Void)? = nil) {
        
        if  (self.presentedViewController as? UIAlertController) != nil {
            self.dismiss(animated: true, completion: {
                if (completion != nil) {
                    completion!()
                }
            })
        } else if (completion != nil) {
            completion!()
        }
    }
}

