//
//  BusinessesViewController.swift
//  Yelp
//
//  Created by Chau Vo on 10/17/16.
//  Copyright © 2016 CoderSchool. All rights reserved.
//

import UIKit
import MBProgressHUD

class BusinessesViewController: UIViewController {

    var businesses: [Business]!
    var searchOption = SearchOption()
    let searchBar = UISearchBar()
    var isMoreDataLoading = false
    var loadingView:LoadingView?
    
    @IBOutlet weak var businessTable: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Initialize search bar in navigation bar
        searchBar.sizeToFit()
        navigationItem.titleView = searchBar
        searchBar.delegate = self
        
        // Initilize business table
        businessTable.delegate = self
        businessTable.dataSource = self
        businessTable.estimatedRowHeight = 100
        businessTable.rowHeight = UITableViewAutomaticDimension
        
        //Initilize loading view
        // Set up Infinite Scroll loading indicator
        let frame = CGRect(x: 0, y: self.businessTable.contentSize.height, width: self.businessTable.bounds.size.width, height: LoadingView.defaultHeight)
        loadingView = LoadingView(frame: frame)
        loadingView!.isHidden = true
        self.businessTable.addSubview(loadingView!)
        
        var insets = self.businessTable.contentInset
        insets.bottom += LoadingView.defaultHeight
        self.businessTable.contentInset = insets
        
        
        self.isMoreDataLoading = true
        MBProgressHUD.showAdded(to: self.view, animated: true)
        Business.search(with: "") { (businesses: [Business]?, error: Error?) in
            MBProgressHUD.hide(for: self.view, animated: true)
            self.isMoreDataLoading = false
            if let businesses = businesses {
                self.businesses = businesses
            }
            self.businessTable.reloadData()
        }
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navVC = segue.destination as! UINavigationController
        let filterVC = navVC.topViewController as! FilterViewController
        filterVC.delegate = self
    }

}

extension BusinessesViewController:UITableViewDelegate, UITableViewDataSource, FilterViewControllerDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if businesses == nil {
            return 0
        } else {
            return businesses.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BusinessCell") as! BusinessTableViewCell
        cell.business = businesses[indexPath.row]
        return cell
    }
    
    func filterViewController(filterViewController: FilterViewController, didUpdateSearchOption searchOption: SearchOption) {
        self.isMoreDataLoading = true
        self.searchOption = searchOption
        MBProgressHUD.showAdded(to: self.view, animated: true)
        Business.search(with: self.searchBar.text!, offset: 0, searchOption:searchOption) { (businesses:[Business]?, error: Error?) in
            MBProgressHUD.hide(for: self.view, animated: true)
            self.isMoreDataLoading = false
            if let businesses = businesses {
                self.businesses = businesses
            }
            
            self.businessTable.reloadData()
        }
    }
    
}

extension BusinessesViewController: UISearchBarDelegate{
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.text = ""
        self.isMoreDataLoading = true
        MBProgressHUD.showAdded(to: self.view, animated: true)
        Business.search(with: "") { (businesses: [Business]?, error: Error?) in
            MBProgressHUD.hide(for: self.view, animated: true)
            self.isMoreDataLoading = false
            if let businesses = businesses {
                self.businesses = businesses
            }
            self.businessTable.reloadData()
        }
        searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // start search here
        let searchText = searchBar.text
        MBProgressHUD.showAdded(to: self.view, animated: true)
        Business.search(with: searchText!, offset: 0, searchOption:searchOption) { (businesses: [Business]?, error: Error?) in
            MBProgressHUD.hide(for: self.view, animated: true)
            if let businesses = businesses {
                self.businesses = businesses
            }
            self.businessTable.reloadData()
        }

        
        searchBar.showsCancelButton = false
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
       
    }

}

extension BusinessesViewController: UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (!isMoreDataLoading){
            // Calculate the position of one screen length before the bottom of the results
            let scrollViewContentHeight = self.businessTable.contentSize.height
            let scrollOffsetThreshold = scrollViewContentHeight - self.businessTable.bounds.size.height
            
            // Start request more data
            if(scrollView.contentOffset.y > scrollOffsetThreshold && self.businessTable.isDragging) {
                isMoreDataLoading = true
                // Update position of loadingMoreView, and start loading indicator
                let frame = CGRect(x: 0, y: self.businessTable.contentSize.height, width: self.businessTable.bounds.size.width, height: LoadingView.defaultHeight)
                loadingView?.frame = frame
                loadingView!.startAnimating()
                
                Business.search(with: "", offset: self.businesses.count, searchOption:searchOption) { (businesses:[Business]?, error: Error?) in
                    self.isMoreDataLoading = false
                    self.loadingView!.stopAnimating()
                    if let businesses = businesses {
                        for business in businesses{
                            self.businesses.append(business)
                        }
                    }
                    self.businessTable.reloadData()
                }
                
            }
        }
    }
}


