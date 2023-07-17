//
//  NetworkMarvelManager.swift
//  MarvelTestJSON
//
//  Created by Andrii Stetsenko on 07.09.2022.
//

import Foundation
import CryptoKit

struct NetworkMarvelManager {
    
    var onCompletionMarvelComicsData: ((MarvelComicsData) -> Void)?
    
    func getData(offset: Int) {
        let privateKey = "51f04c0ce4ac9d6cbc440412e9eb5b6e65bb35d5"
        let apiKey = "fae8a81a235d3c877c0c7231fe5fe9cf"
        let timeStamp: Int = Int(Date().timeIntervalSince1970)
        
        //md5(ts+privateKey+publicKey)
        guard let hash = MD5("\(timeStamp)\(privateKey)\(apiKey)") else { return }
        
        let urlString = "https://gateway.marvel.com/v1/public/characters?ts=\(timeStamp)&apikey=\(apiKey)&hash=\(hash)&offset=\(offset)"
        guard let url = URL(string: urlString) else { return }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, response, error in
            if let data = data {
                if let currentData = self.parseMarvelJSON(withData: data) {
                    self.onCompletionMarvelComicsData?(currentData)
                }
            }
        }
        task.resume()
    }
    
    func parseMarvelJSON(withData data: Data) -> MarvelComicsData? {
        let decoder = JSONDecoder()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        
        do {
            let decodedMarvelData = try decoder.decode(MarvelComicsData.self, from: data)
            return decodedMarvelData
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        return nil
    }
    
    func MD5(_ string: String) -> String? {
        return Insecure.MD5.hash(data: string.data(using: .utf8)!).map { String(format: "%02hhx", $0) }.joined()
    }
}
