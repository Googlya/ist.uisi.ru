//
//  postViewController.swift
//  ist.uisi.ru
//
//  Created by Александр Фарносов on 29.09.2020.
//  Copyright © 2020 Александр Фарносов. All rights reserved.
//

import UIKit
import WebKit

class postViewController: UIViewController  {

    
    @IBOutlet weak var postImage: UIImageView!
    
    @IBOutlet weak var postTitleLabel: UILabel!
    
    @IBOutlet weak var postAuthorLabel: UILabel!
    
    @IBOutlet weak var postTextView: UITextView!
    
    var idPostShared: Int?

    
    //Добавить отображение контента из модели поста
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if idPostShared != nil {
            let parsePostData = ModelParsePost.shared.parsinfPost(idPost: idPostShared!)
            postTitleLabel.text = (parsePostData["title"] as! String)
            
            let urlImage:URL = URL(string: parsePostData["urlPreview"] as! String)!
            postImage.image = UIImage(data: try! Data(contentsOf: urlImage))
            
            let authorID = (parsePostData["authorId"] as! Int)
            let parsePostAuthor = modelParseAuthor.shared.parseAuthor(idAuthor: authorID)
            postAuthorLabel.text = String(parsePostAuthor)
            
            let contentText: String = parsePostData["content"] as! String
            
            postTextView.text = contentText
            
        }
        
    }
    
    //Функция показа navigation bar
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        super.viewWillAppear(animated)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


