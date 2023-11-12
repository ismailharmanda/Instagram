//
//  FeedViewController.swift
//  Instagram
//
//  Created by ismail harmanda on 8.11.2023.
//

import UIKit
import FirebaseFirestore
class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var posts = [Post]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FeedCell
        cell.userEmailLabel.text = posts[indexPath.row].email
        cell.likeLabel.text = String(posts[indexPath.row].like)
        cell.userCommentLabel.text = posts[indexPath.row].comment
        cell.userImageView.image = UIImage(named: posts[indexPath.row].image)
        if let url = URL(string: posts[indexPath.row].image) {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    DispatchQueue.main.async {
                        cell.userImageView.image = UIImage(data: data)
                    }
                }
            }.resume()}
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        420
    }
    
    func getDataFromFirestore(){
        
        let firestoreDatabase = Firestore.firestore()
        
        firestoreDatabase.collection("Posts").addSnapshotListener { snapshot, error in
            if error != nil {
                print(error)
            } else {
                if snapshot?.isEmpty != true{
                    for document in snapshot!.documents{
                        let documentId = document.documentID
                        let documentData = document.data()
                        let post = Post(email: document["postedBy"] as! String, comment: document["postComment"] as! String, like: document["likes"] as! Int, image: document["imageUrl"] as! String)
                        self.posts.append(post)
                        
                        
            
                    }
                    self.tableView.reloadData()
                }
               
            }        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        getDataFromFirestore()
    }
    

    @IBOutlet weak var tableView: UITableView!
    
}
