//
//  ViewController.swift
//  ist.uisi.ru
//
//  Created by Александр Фарносов on 26.09.2020.
//  Copyright © 2020 Александр Фарносов. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
// Оутлет для коллетион вьюв
    @IBOutlet weak var testCollectView: UICollectionView!
    
    // переменная для ячеек в коллектион вьюв
    let customCollectionViewCellId = "CollectionViewCustomCell"
        
    //Массив ID постов
    var arrayIdPosts: Array<Int> = []
    
    //функция отображения
    override func viewDidLoad() {
        super.viewDidLoad()

        //иницилизация CollectView
        testCollectView.dataSource = self
        testCollectView.delegate = self
        
        //Регистрация кастомной ячейки CollectionView
        let nibCell = UINib(nibName: customCollectionViewCellId, bundle: nil)
        testCollectView.register(nibCell, forCellWithReuseIdentifier: customCollectionViewCellId)
        
    }
    
    //переменная для данных парса постов
    let parsData = ModelParsePosts.shared.parsingPosts()
    
    //функция для отображения количества ячеек колектион вьюв постов
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return parsData.count
    }
    
    //функция анимации пролистывания
    override func viewDidAppear(_ animated: Bool) {
      let midIndexPath = IndexPath(row: 0, section: 0)
      testCollectView.scrollToItem(at: midIndexPath,
                                       at: .centeredHorizontally,
                                 animated: false)
    }
    
    //функция отоброжения информации в ячейках
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: customCollectionViewCellId, for: indexPath) as! CollectionViewCustomCell

        //переменная для данных парсинга
        let tempData: [String : Any] = parsData[indexPath.row] as! [String : Any]
            
        //переменные для отображения
        let titleText: String = tempData["title"] as! String
        let urlToImageString: String = tempData["urlPreview"] as! String
/*        guard urlToImageString == urlToImageString else {
            let tempImagePath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.libraryDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0]+"nonimage.png"
            print(urlToImageString)
            //urlToImageString =
        } */
        let urlImagePost: URL = URL(string: urlToImageString)!
        let idPostTemp: Int = tempData["ID"] as! Int


        //отображение в ячейке текста
        cell.titleLabel.sizeToFit()
        cell.titleLabel?.text = String(titleText)
                
        //отображение в ячейке картинки из поста
        cell.imagePost.layer.cornerRadius = 10
        cell.imagePost.layer.borderWidth = 1
        cell.imagePost.layer.borderColor = UIColor.black.cgColor
        cell.imagePost.image = UIImage(data: try! Data(contentsOf: urlImagePost))
            
        //Добавляем ID по порядку в массив
        arrayIdPosts.append(idPostTemp)
        
        return cell
    }
    
    //Функции перехода на страницу поста
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "showPostView", sender: self)
    }
    
    //Функция передачи id поста в отображение самого поста
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showPostView" {
            let indexPaths = self.testCollectView.indexPathsForSelectedItems
            let indexPath = indexPaths![0] as NSIndexPath
            let postVC = segue.destination as! postViewController
            postVC.idPostShared = arrayIdPosts[indexPath.row]
        }
    }
    
    //Функция скрытия navigation bar
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        super.viewWillAppear(animated)
    }
    
    

}


