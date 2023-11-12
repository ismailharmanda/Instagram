//
//  FeedViewController.swift
//  Instagram
//
//  Created by ismail harmanda on 8.11.2023.
//

import UIKit

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FeedCell
        cell.userEmailLabel.text = "user@email.com"
        cell.likeLabel.text = "99"
        cell.userCommentLabel.text = "Comment"
        cell.userImageView.image = UIImage(systemName: "plus.viewfinder")
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        420
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
    }
    

    @IBOutlet weak var tableView: UITableView!
    
}
