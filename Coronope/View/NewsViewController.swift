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
        service.parseNews()
    }
}

extension NewsViewController : CoronopeNewsServiceDelegate {
    func didGetData(articleList: [CoronopeNewsModel]) {
        self.articleList = articleList
        self.tableView.reloadData()
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
        let cell = tableView.dequeueReusableCell(withIdentifier: CoronopeConstants.TableConstants.cellIdentifer,for: indexPath)
        cell.textLabel?.text = articleList[indexPath.row].title
        return cell
    }
}

extension NewsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}

