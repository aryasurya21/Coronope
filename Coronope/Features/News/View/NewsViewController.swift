//
//  NewsViewController.swift
//  Coronope
//
//  Created by IT Division on 27/12/20.
//  Copyright © 2020 com.aryasurya. All rights reserved.
//

import UIKit
import Combine

class NewsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private let presenter: NewsPresenter
    private var cancellableBag = Set<AnyCancellable>()
    private var newsData: [NewsModel] = []
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        activityIndicator.color = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        activityIndicator.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        activityIndicator.layer.cornerRadius = 6
        return activityIndicator
    }()
    
    private lazy var errorView: UIView = {
        let view = UIStackView()
        let label = UILabel()
        
        view.axis = .vertical
        label.text = "Something went wrong. Please try again. :("
        view.addArrangedSubview(label)
        let btn = UIButton()
        btn.addTarget(self, action: #selector(self.reload), for: .touchUpInside)
        btn.backgroundColor = .red
        btn.setTitle("TRY AGAIN", for: .normal)
        btn.layer.cornerRadius = 10
        view.addArrangedSubview(btn)
        return view
    }()
    
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
        self.presenter.getNews()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableView()
        self.setupActivityIndicator()
        self.setupErrorView()
        self.bindUI()
    }
    
    private func setupActivityIndicator(){
        self.view.addSubview(self.activityIndicator)
        self.activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.activityIndicator.heightAnchor.constraint(equalToConstant: 50),
            self.activityIndicator.widthAnchor.constraint(equalToConstant: 50),
            self.activityIndicator.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            self.activityIndicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
        ])
    }
    
    private func setupErrorView(){
        self.view.addSubview(self.errorView)
        self.errorView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.errorView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.errorView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
        ])
        self.errorView.isHidden = true
    }
    
    private func setupTableView(){
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 250
        self.tableView.register(NewsTableViewCell.nib, forCellReuseIdentifier: NewsTableViewCell.identifier)
    }
    
    private func bindUI(){
        self.presenter.$news.sink { (news) in
            self.errorView.isHidden = true
            self.tableView.isHidden = false
            guard let news = news else { return }
            self.newsData = news
            self.tableView.reloadData()
        }.store(in: &self.cancellableBag)
        
        self.presenter.$isLoading.sink { (isLoading) in
            self.errorView.isHidden = true
            if isLoading {
                self.activityIndicator.isHidden = false
                self.activityIndicator.startAnimating()
            } else {
                self.activityIndicator.isHidden = true
                self.activityIndicator.stopAnimating()
            }
        }.store(in: &self.cancellableBag)
        
        self.presenter.$error.sink { (error) in
            guard let _ = error else { return }
            DispatchQueue.main.async {
                self.errorView.isHidden = false
                self.tableView.isHidden = true
                self.activityIndicator.isHidden = true
            }
        }.store(in: &self.cancellableBag)
    }
}

extension NewsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.newsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.identifier) as? NewsTableViewCell {
            cell.setData(newsData[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    @objc func reload(){
        self.presenter.getNews()
    }
}

extension NewsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.transform = CGAffineTransform(translationX: 0, y: cell.frame.height)
        cell.alpha = 0
        cell.selectionStyle = .none
        UIView.animate(
            withDuration: 1.2,
            delay: 0.02,
            usingSpringWithDamping: 0.6,
            initialSpringVelocity: 0.1,
            options: [.curveEaseInOut],
            animations: {
                cell.alpha = 1
                cell.transform = CGAffineTransform(translationX: 0, y: 0)
        })
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = self.newsData[indexPath.row]
        if let url = URL(string: data.url), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}
