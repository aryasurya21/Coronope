//
//  NewsViewController.swift
//  Coronope
//
//  Created by IT Division on 27/12/20.
//  Copyright © 2020 com.aryasurya. All rights reserved.
//

import UIKit

class NewsViewController: UIViewController {
    
    private let presenter: NewsPresenter
    
    init(_ presenter: NewsPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.title = "COVID-19 Related News"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.presenter.getNews()
    }
}
