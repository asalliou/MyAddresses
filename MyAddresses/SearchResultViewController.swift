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

class SearchResultViewController: UIViewController, StoreSubscriber, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var suggestedAddresses : [Address] = []
    let cellIdentifier = "addressCell"
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return suggestedAddresses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        
        if (cell == nil) {
            cell = UITableViewCell(style: .default, reuseIdentifier: cellIdentifier)
        }
        
        cell!.textLabel?.text = suggestedAddresses[indexPath.row].description
        return cell!
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainStore.subscribe(self)
    }
    
    func newState(state: AppState) {
        self.view.isHidden = !state.searchResultVisible
        self.view.isUserInteractionEnabled = state.searchResultVisible
        
        self.suggestedAddresses = state.searchResults
        self.tableView.reloadData()
    }
}
