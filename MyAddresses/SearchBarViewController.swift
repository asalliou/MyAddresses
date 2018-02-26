//
//  SearchBarViewController.swift
//  MyAddresses
//
//  Created by Antoine SALLIOU on 25/02/2018.
//  Copyright © 2018 ViaMichelin. All rights reserved.
//

import Foundation
import UIKit

class SearchBarViewController: UIViewController, UISearchBarDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
        
        mainStore.dispatch(SearchDidBegin())
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
        mainStore.dispatch(SearchDidEnd())
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        mainStore.dispatch(SearchTextDidChange(searchText: searchText))
    }
}
