//
//  Post.swift
//  Instagram
//
//  Created by ismail harmanda on 12.11.2023.
//

import Foundation

class Post {
    var email: String
    var comment: String
    var like: Int
    var image: String
    
    init(email: String, comment: String, like: Int, image: String) {
        self.email = email
        self.comment = comment
        self.like = like
        self.image = image
    }
}
