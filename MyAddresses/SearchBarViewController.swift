//
//  SearchBarViewController.swift
//  MyAddresses
//
//  Created by Antoine SALLIOU on 25/02/2018.
//  Copyright © 2018 ViaMichelin. All rights reserved.
//

import Foundation
import UIKit
import ReSwift

class SearchBarViewController: UIViewController, StoreSubscriber, UISearchBarDelegate {
    
    @IBOutlet weak var searchBarView: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainStore.subscribe(self)
    }
    
    func newState(state: AppState) {
        if state.searchBarIsEditing {
            searchBarView.setShowsCancelButton(true, animated: true)
        } else {
            searchBarView.setShowsCancelButton(false, animated: true)
            searchBarView.resignFirstResponder()
        }
        
        searchBarView.text = state.searchBarContent
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        mainStore.dispatch(SearchDidBegin())
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        mainStore.dispatch(SearchTextDidChange(searchText: searchBar.text ?? ""))
        mainStore.dispatch(SearchDidEnd())
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        mainStore.dispatch(SearchDidEnd())
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        mainStore.dispatch(SearchTextDidChange(searchText: searchText))
    }
}
