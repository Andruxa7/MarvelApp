//
//  DetailsViewController.swift
//  MarvelTestJSON
//
//  Created by Andrii Stetsenko on 23.09.2022.
//

import UIKit

class DetailsViewController: UIViewController {

    // MARK: - IBOutlets
    
    @IBOutlet weak var pictureImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    
    // MARK: - Properties
    
    var networkMarvelManager = NetworkMarvelManager()
    var marvelComicsData: MarvelComicsData?
    var currentHero: Int = 0
    var results: [Result] = []
    
    
    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()

            nameLabel.text = results[currentHero].name
            descriptionLabel.text = results[currentHero].resultDescription
            
            let resultsItem = results[currentHero]
            
            let path = resultsItem.thumbnail.path
            let thumbnailExtension = resultsItem.thumbnail.thumbnailExtension
            
            let urlString = path + "." + thumbnailExtension
            var str: String = ""
            
            if urlString.contains("http:") {
                str = urlString.replacingOccurrences(of: "http:", with: "https:")
            }
            
            pictureImage.loadImageFrom(urlString: str)
    }

}
