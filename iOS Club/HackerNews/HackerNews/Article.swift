//
//  Article.swift
//  HackerNews
//
//  Created by Abhinav Tirath on 3/6/18.
//  Copyright © 2018 LearningSwift. All rights reserved.
//

import Foundation

struct Article: Codable {
    var id: Int
    var title: String
    var url: URL
    var score: Int
    var kids: [Int]
    var time: Date
}
