//
//  ViewController.swift
//  HanYuko_v2
//
//  Created by Jacob Pernell on 9/14/20.
//  Copyright © 2020 Jacob Pernell. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UITableViewController, UISearchBarDelegate {
    
    var imagesStored = [UnsplashImage]()
    let searchController = UISearchController(searchResultsController: nil)
    
    let tableCellHeight: CGFloat = 70

    // MARK: - ViewController styling and layout
    override func viewDidLoad() {
        super.viewDidLoad()
                
        // Set the title of the home screen
        title = "HanYuko Images"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        // The BEEFY title
        let largeTitleTextAttributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.font: Constants.largeTitleFont!,
            NSAttributedString.Key.foregroundColor: Constants.titleColor
        ]
        // When you scroll up
        let titleTextAttributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.font: Constants.normalTitleFont!,
            NSAttributedString.Key.foregroundColor: Constants.titleColor
        ]
        navigationController?.navigationBar.largeTitleTextAttributes = largeTitleTextAttributes
        navigationController?.navigationBar.titleTextAttributes = titleTextAttributes
        
        // Search bar setup
        searchController.searchBar.delegate = self
        // Adds search input to navigation area
        navigationItem.searchController = searchController
        
    }
    
    // MARK: - TableView functions
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imagesStored.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Cell setup
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! UnsplashImageTableViewCell
        let imageCell = imagesStored[indexPath.row]
        
        // Cell text
        let cellDescriptionText = imageCell.description ?? imageCell.altDescription ?? "(no description)"
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
    
    // MARK: - Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailViewSegue" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let destination = segue.destination as! DetailViewController
                
                let selectedImgURL = imagesStored[indexPath.row].urls.sourceImage
                let selectedImgData = try! Data(contentsOf: selectedImgURL)
                if let selectedImg = UIImage(data: selectedImgData) {
                    destination.detailImage = selectedImg
                }
                
                destination.detailText = imagesStored[indexPath.row].description ?? imagesStored[indexPath.row].altDescription ?? "(no description)"
            }
        }
    }
    
    // MARK: - Search functions and API call
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        fetchImages(query: searchBar.text ?? "")
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.placeholder = ""
    }

    func fetchImages(query: String) {
        let apiKey = Constants.apiKey
        let parameters = ["query": query, "client_id": apiKey]
        let apiURL = "https://api.unsplash.com/search/photos"
        
//        createSpinnerView() TODO: Create/hide spinner when loading
        
        AF.request(apiURL, parameters: parameters)
            .validate()
            .responseDecodable(of: ImagesResponse.self) { response in
                //debugPrint(response)
                guard let images = response.value else { return }
                self.imagesStored = images.results
//                print(self.imagesStored) // TODO: fix storing only first page
                self.tableView.reloadData()
                
        }
        
        searchController.searchBar.placeholder = query
    }
    
    // MARK: - UIIndicator spinner component
    
    func createSpinnerView() {
        let spinnerComponent = SpinnerViewController()
        
        addChild(spinnerComponent)
        spinnerComponent.view.frame = view.frame
        view.addSubview(spinnerComponent.view)
        spinnerComponent.didMove(toParent: self)
    }
}
