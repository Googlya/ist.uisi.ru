//
//  ModelParsePost.swift
//  ist.uisi.ru
//
//  Created by Александр Фарносов on 28.09.2020.
//  Copyright © 2020 Александр Фарносов. All rights reserved.
//

import Foundation

struct Post: Decodable {
    var title: forRenderedPost!
    var content: forRenderedPost!
    var author: Int!
    var urlPreview: String!
    
    enum CodingKeys: String, CodingKey {
        case title
        case content
        case author
        case urlPreview = "jetpack_featured_media_url"
    }
}

struct forRenderedPost: Decodable {
    var rendered: String!
}

class ModelParsePost {
    static let shared = ModelParsePost()
    
    var parsePostData: Dictionary<String, Any> = [:]
    
    func parsinfPost(idPost: Int) -> Dictionary<String, Any> {
        let urlPost = URL(string: "https://ist.uisi.ru/wp-json/wp/v2/posts/\(idPost)")!
        URLSession.shared.dataTask(with: urlPost) { (data, response, error) in
            guard let data = data else { return }
            guard error == nil else { return }
        do {
            let decoder = JSONDecoder()
            let parsing = try decoder.decode(Post.self, from: data )
            self.parsePostData["title"] = parsing.title.rendered
            self.parsePostData["authorId"] = parsing.author
            self.parsePostData["urlPreview"] = parsing.urlPreview
            self.parsePostData["content"] = parsing.content.rendered
            print(self.parsePostData["content"] as Any)
            
        }
        catch {
            print(error)
            }
        }.resume()
        
        sleep(3)
        return parsePostData
    }
}
