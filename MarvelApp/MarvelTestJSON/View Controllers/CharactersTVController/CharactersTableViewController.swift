//
//  CharactersTableViewController.swift
//  MarvelTestJSON
//
//  Created by Andrii Stetsenko on 17.09.2022.
//

import UIKit

class CharactersTableViewController: UITableViewController {
    
    // MARK: - Properties
    
    var networkMarvelManager = NetworkMarvelManager()
    var marvelComicsData: MarvelComicsData?
    var results: [Result] = []
    var currentHero: Int = 0
    
    let totalHeros = 1562
    let identifier = "CharactersCell"
    let marvelCharactersDetailsIdentifier = "ShowMarvelCharactersDetailsVC"
    
    
    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadMarvelComicsData()
    }
    
    
    // MARK: - Private functions
    
    func loadMarvelComicsData() {
        networkMarvelManager.onCompletionMarvelComicsData = { [weak self] marvelComicsData in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.marvelComicsData = marvelComicsData
                self.results.append(contentsOf: marvelComicsData.data.results)
                self.tableView.reloadData()
            }
        }
        networkMarvelManager.getData(offset: 0)
    }

    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? CharactersTableViewCell {
            let resultsItem = results[indexPath.row]
            
            cell.nameLabel.text = resultsItem.name
            cell.descriptionLabel.text = resultsItem.resultDescription
            
            let path = resultsItem.thumbnail.path
            let thumbnailExtension = resultsItem.thumbnail.thumbnailExtension
            let urlString = path + "." + thumbnailExtension
            
            var str: String = ""
            
            if urlString.contains("http:") {
                str = urlString.replacingOccurrences(of: "http:", with: "https:")
            }
            
            cell.configure(url: str)
            
            return cell
        }
        return UITableViewCell()
    }

    
    // MARK: - UITableViewDelegate

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        self.currentHero = indexPath.row
        
        let resultsItem = results[indexPath.row]
        performSegue(withIdentifier: marvelCharactersDetailsIdentifier, sender: resultsItem)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 156
    }
    
    // сделаем так что после появления ячейки внизу не будет лишних видимых ячеек (сетки). Добавим два метода Футера.
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10.0
    }

    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == results.count - 1 {
            if results.count < totalHeros {
                let offset = results.count
                self.marvelComicsData?.data.offset = offset
                
                networkMarvelManager.getData(offset: offset)
            }
        }
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let marvelDetailsVC = segue.destination as? DetailsViewController {
            if segue.identifier == self.marvelCharactersDetailsIdentifier,
               let marvelComicsData = self.marvelComicsData {
                marvelDetailsVC.title = "Hiro's details"
                marvelDetailsVC.marvelComicsData = marvelComicsData
                marvelDetailsVC.currentHero = self.currentHero
                marvelDetailsVC.results = self.results
            }
        }
    }

}
