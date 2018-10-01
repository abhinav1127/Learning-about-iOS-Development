//
//  HackerNewsTableViewController.swift
//  HackerNews
//
//  Created by Abhinav Tirath on 3/6/18.
//  Copyright © 2018 LearningSwift. All rights reserved.
//

import UIKit
import SafariServices

class HackerNewsTableViewController: UITableViewController {

    var articles: [Article] = []

    @IBAction func showCommentsTapped(_ sender: UIButton) {
        let articleId = articles[sender.tag].id
        let url = URL(string: "https://news.ycombinator.com/item?id=\(articleId)")
        let webVC = SFSafariViewController(url: url!)
        self.present(webVC, animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchTopArticles()
        
    }
    
    func fetchTopArticles() {
        let topArticleURL = URL(string: "https://hacker-news.firebaseio.com/v0/topstories.json?print=pretty")
        URLSession.shared.dataTask(with: topArticleURL!) { (data, response, error) in
            guard let data = data,
                let text = String(data: data, encoding: .utf8) else {
                    return
            }
            let trimmedText = text.replacingOccurrences(of: " ", with: "").replacingOccurrences(of: "]", with: "").replacingOccurrences(of: "\n", with: "")
            let articleEntries = trimmedText.components(separatedBy: ",")
            for articleEntry in articleEntries {
                self.fetchArticle(articleEntry)
            }
        }.resume()
    }

    func fetchArticle(_ entryId: String) {
        let articleURL = URL(string: "https://hacker-news.firebaseio.com/v0/item/\(entryId).json?print=pretty")
        URLSession.shared.dataTask(with: articleURL!) { (data, response, error) in
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .secondsSince1970
            guard let data = data, let article = try? decoder.decode(Article.self, from: data) else {
                return
            }
            self.articles.append(article)
            DispatchQueue.main.async {
                self.tableView?.reloadData()
            }
        }.resume()
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 108
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HackerNewsTableViewCell", for: indexPath)
        let article = articles[indexPath.row]
        if let articleCell = cell as? HackerNewsTableViewCell {
            articleCell.articleLabel.text = article.title
            articleCell.articleVote.text = "😛\n\(article.score)"
            articleCell.articleCommentButton.setTitle(":)\(article.kids.count)", for: .normal)
            articleCell.articleCommentButton.tag = indexPath.row
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            let formattedDateString = dateFormatter.string(from: article.time)
            articleCell.articleTime.text = formattedDateString
        }

        // Configure the cell...

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let url = articles[indexPath.row].url
        let webVC = SFSafariViewController(url: url)
        self.present(webVC, animated: true, completion: nil)
    }
    

}
