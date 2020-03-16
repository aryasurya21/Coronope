//
//  SecondViewController.swift
//  Coronope
//
//  Created by IT Division on 15/03/20.
//  Copyright © 2020 com.aryasurya. All rights reserved.
//

import UIKit

class NewsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var service = CoronopeNewsService()
    var articleList : [CoronopeNewsModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        service.delegate = self
        tableView.register(UINib(nibName: CoronopeConstants.TableConstants.nibName, bundle: nil), forCellReuseIdentifier: CoronopeConstants.TableConstants.cellIdentifer)
        service.parseNews()
    }
}

extension NewsViewController : CoronopeNewsServiceDelegate {
    func didGetData(articleList: [CoronopeNewsModel]) {
        self.articleList = articleList
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}

extension NewsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articleList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CoronopeConstants.TableConstants.cellIdentifer,for: indexPath) as! NewsTableViewCell
        cell.newsTitle.text = articleList[indexPath.row].title
        cell.newsDescription.text = articleList[indexPath.row].description
        let urlPath = URL(string: articleList[indexPath.row].imgUrl ?? CoronopeConstants.defaultImagePath)!
        cell.newsImage.downloadImage(from: urlPath)
        return cell
    }
}

extension NewsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let url = URL(string:articleList[indexPath.row].newsUrl ?? CoronopeConstants.defaultUrlPath){
            UIApplication.shared.open(url)
        }
    }
}
