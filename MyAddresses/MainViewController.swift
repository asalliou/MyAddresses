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
    
    @IBOutlet weak var searchResultContainerView: UIView!
    @IBOutlet weak var searchResultBottomLayoutConstraint: NSLayoutConstraint!
    
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
        
        self.searchResultContainerView.isUserInteractionEnabled = state.searchResultVisible
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShowNotification(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHideNotification(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    @objc func keyboardWillShowNotification(notification: NSNotification) {
        updateBottomLayoutConstraintWithNotification(notification: notification)
    }
    
    @objc func keyboardWillHideNotification(notification: NSNotification) {
        updateBottomLayoutConstraintWithNotification(notification: notification)
    }
    
    // MARK: - Private
    func updateBottomLayoutConstraintWithNotification(notification: NSNotification) {
        let userInfo = notification.userInfo!
        
        let animationDuration = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
        let keyboardEndFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let convertedKeyboardEndFrame = view.convert(keyboardEndFrame, from: view.window)
        let rawAnimationCurve = (notification.userInfo![UIKeyboardAnimationCurveUserInfoKey] as! NSNumber).uint32Value << 16
        let animationCurve = UIViewAnimationOptions.init(rawValue: UInt(rawAnimationCurve))
        
        
        searchResultBottomLayoutConstraint.constant = view.bounds.maxY - (convertedKeyboardEndFrame.minY - 8)
        
        UIView.animate(withDuration: animationDuration, delay: 0.0, options: [.beginFromCurrentState, animationCurve], animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
}

