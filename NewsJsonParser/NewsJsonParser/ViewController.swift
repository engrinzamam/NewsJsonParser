//
//  ViewController.swift
//  NewsJsonParser
//
//  Created by engrInzamamulhaq on 25/06/2020.
//  Copyright © 2020 engrInzamamulhaq. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableViewNews: UITableView!
    
    var news: [News] = []
    
    private let activityIndicatorView = UIActivityIndicatorView(style: .large)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicatorView.center = tableViewNews.center
        tableViewNews.addSubview(activityIndicatorView)
        newsAPICall()
        tableViewNews.delegate = self
        tableViewNews.dataSource = self
    }

    func newsAPICall() {
        self.activityIndicatorView.startAnimating()
        NetworkManager.getNews { newsData in
            guard newsData != nil else {
                print("Nil Found as Output")
                self.activityIndicatorView.stopAnimating()
                return
            }
            if let newsData = newsData {
                let decoder = JSONDecoder()
                do {
                    if let json = try? JSONSerialization.jsonObject(with: newsData, options: .mutableContainers) as? [String: Any] {
                        print("json is")
                        print(json)
                    }
                    let newsResponse = try decoder.decode(NewsResponse.self, from: newsData)
                    if let newsArray = newsResponse.rows {
                        self.news = newsArray
                        print(newsArray.count)
                        DispatchQueue.main.async {
                            self.activityIndicatorView.stopAnimating()
                            self.title = newsResponse.title
                            self.tableViewNews.reloadData()
                        }
                    }
                } catch (let errror) {
                    print("Merror is:------------ \(errror.localizedDescription)")
                }
            }
        }
    }
    
    @IBAction func refreshButtonTaped(_ sender: Any) {
        print("Tapped")
        newsAPICall()
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as? NewsCell {
            cell.new = self.news[indexPath.row]
            return cell
        }
        return UITableViewCell()
    }
}
