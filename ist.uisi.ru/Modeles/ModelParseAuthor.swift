//
//  ModelParseAuthor.swift
//  ist.uisi.ru
//
//  Created by Александр Фарносов on 29.09.2020.
//  Copyright © 2020 Александр Фарносов. All rights reserved.
//

import Foundation

struct AuthorName: Decodable {
    var name: String!
}

class modelParseAuthor {
    static let shared = modelParseAuthor()
    
    var authorName: String?
    
    func parseAuthor(idAuthor: Int) -> String {
        let urlAuthor = URL(string: "https://ist.uisi.ru/wp-json/wp/v2/users/\(idAuthor)")!
        URLSession.shared.dataTask(with: urlAuthor) { (data, response, error) in
            guard let data = data  else { return }
            guard error == nil else { return }
            do {
                let decoder = JSONDecoder()
                let parsing = try decoder.decode(AuthorName.self, from: data)
                self.authorName = parsing.name as String
            }
            catch {
                print(error)
            }
        } .resume()
        sleep(3)
        return authorName!
    }
}
