//
//  ViewController.swift
//  HanYuko_v2
//
//  Created by Jacob Pernell on 9/14/20.
//  Copyright © 2020 Jacob Pernell. All rights reserved.
//

// TODO: Make utility folder with Constants struct that contains all strings
// TODO: Look up marks and todos

// TODO: FUTURE: v2 of this - all programmatic UI, use SwiftyJSON

import UIKit
import Alamofire

class ViewController: UITableViewController, UISearchBarDelegate {
    
    var imagesStored = [UnsplashImage]()
    let searchController = UISearchController(searchResultsController: nil)
    let tableCellHeight: CGFloat = 70
    
    // Font styling attributes
    let largeTitleFont = UIFont(name: "Rubik-Bold", size: 34) ?? UIFont(name: "Arial", size: 34)
    let normalTitleFont = UIFont(name: "Rubik-Bold", size: 17) ?? UIFont(name: "Arial", size: 17)
    let regularFont = UIFont(name: "Rubik-Regular", size: 17) ?? UIFont(name: "Arial", size: 17)
    let titleColor = UIColor(red: 0.10, green: 0.42, blue: 0.78, alpha: 1.00)

    override func viewDidLoad() {
        super.viewDidLoad()
                
        // Set the title of the home screen
        title = "HanYuko Images"
        
        // Enable large header title for the home screen and set its properties
        navigationController?.navigationBar.prefersLargeTitles = true
        
        // The BEEFY title
        let largeTitleTextAttributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.font: largeTitleFont!,
            NSAttributedString.Key.foregroundColor: titleColor
        ]
        // When you scroll up
        let titleTextAttributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.font: normalTitleFont!,
            NSAttributedString.Key.foregroundColor: titleColor
        ]
        navigationController?.navigationBar.largeTitleTextAttributes = largeTitleTextAttributes
        navigationController?.navigationBar.titleTextAttributes = titleTextAttributes
        
        // Search bar setup
        searchController.searchBar.delegate = self
        // Adds search input to navigation area
        navigationItem.searchController = searchController
        
    }
    
    // MARK: TableView functions
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imagesStored.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Cell setup
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! UnsplashImageTableViewCell
        let imageCell = imagesStored[indexPath.row]
        
        // Cell text
        let cellDescriptionText = imageCell.description ?? imageCell.altDescription
        cell.cellLabel?.text = cellDescriptionText
        
        // Cell picture
        let pictureURL = imageCell.urls.sourceImage
        let pictureData = try! Data(contentsOf: pictureURL)
        let picture = UIImage(data: pictureData)
        cell.cellImage.image = picture
        cell.cellImage.layer.cornerRadius = 10
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableCellHeight
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "DetailViewSegue", sender: self)
    }
    
    // MARK: Search functions and API call
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        fetchImages(query: searchBar.text ?? "")
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.placeholder = ""
    }

    func fetchImages(query: String) {
        let apiKey = "4se24g0iDGD4ZlKTHoh1LVanuCy1CegUCH0_zZlV030"
        let parameters = ["query": query, "client_id": apiKey]
        let apiURL = "https://api.unsplash.com/search/photos"
        
//        createSpinnerView() TODO: Create/hide spinner when loading
        
        AF.request(apiURL, parameters: parameters)
            .validate()
            .responseDecodable(of: ImagesResponse.self) { response in
                //debugPrint(response)
                guard let images = response.value else { return }
                self.imagesStored = images.results
                self.tableView.reloadData()
                
        }
        
        searchController.searchBar.placeholder = query
    }
    
    // MARK: UIIndicator spinner component
    
    func createSpinnerView() {
        let spinnerComponent = SpinnerViewController()
        
        addChild(spinnerComponent)
        spinnerComponent.view.frame = view.frame
        view.addSubview(spinnerComponent.view)
        spinnerComponent.didMove(toParent: self)
    }
}
