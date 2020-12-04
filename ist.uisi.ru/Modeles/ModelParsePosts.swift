//
//  ModelParsePosts.swift
//  ist.uisi.ru
//
//  Created by Александр Фарносов on 26.09.2020.
//  Copyright © 2020 Александр Фарносов. All rights reserved.
//

import UIKit
import Foundation

//Структура для парса постов для отображения на странице
struct Posts: Decodable {
    var id: Int!
    var date: String!
    var link: String!
    var title: forRendered!
    var author: Int!
    var urlPreview: String!
    
    enum CodingKeys: String, CodingKey {
        case id
        case date
        case link
        case title
        case author
        case urlPreview = "jetpack_featured_media_url"
    }
}

struct forRendered: Decodable{
    var rendered: String!
}


class ModelParsePosts {
    static let shared = ModelParsePosts()
    var parsePosts: Array<Any> = []
    
    func parsingPosts() -> Array<Any> {
        
        let urlPosts = URL(string: "https://ist.uisi.ru/wp-json/wp/v2/posts?per_page=5")!
            
        URLSession.shared.dataTask(with: urlPosts) { (data, response, error) in
            guard let data = data else { return }
            guard error == nil else { return }
        
        do {
            let decoder = JSONDecoder()
            let parsing = try decoder.decode([Posts].self, from: data )
            var tempPosts: [String : Any] = [:]
            for element in parsing {
                tempPosts.removeAll()
                tempPosts["ID"] = element.id
                tempPosts["date"] = element.date
                tempPosts["link"] = element.link
                tempPosts["title"] = element.title.rendered
                tempPosts["idAuthor"] = element.author
                tempPosts["urlPreview"] = element.urlPreview
                self.parsePosts.append(tempPosts)
            }
        }
        catch {
            print(error)
            }
        }.resume()
        sleep(3)
        print(parsePosts)
        return parsePosts
    }
    

}
