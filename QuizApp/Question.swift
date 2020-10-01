//
//  Question.swift
//  QuizApp
//
//  Created by Kim on 26/8/20.
//  Copyright © 2020 Kim. All rights reserved.
//

import Foundation

struct Question: Codable {
    
    var question:String?
    var answers:[String]?
    var correctAnswerIndex:Int?
    var feedback:String?
    
    
    
}
