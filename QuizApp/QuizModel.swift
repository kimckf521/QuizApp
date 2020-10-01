//
//  QuizModel.swift
//  QuizApp
//
//  Created by Kim on 26/8/20.
//  Copyright © 2020 Kim. All rights reserved.
//

import Foundation

protocol QuizProtocol {
    func questionsRetrieved(_ question:[Question])
}

class QuizModel {
    
    var delegate:QuizProtocol?
    
    func getQuestions() {
        
        
        // Fetch the Question
        getRemoteJsonFile() //B4 getLocalJsonFile()
        
    }
    
    func getLocalJsonFile() {
        
        // Get bundle path to json file
        let path = Bundle.main.path(forResource: "QuestionData", ofType: "json")
        
        // Double check that the path is not nil
        guard path != nil else {
            print("Could not find the json data file")
            return
        }
        
        // Create URL object from the path
        let url = URL(fileURLWithPath: path!)
        
        do {
            // Get the data from the url
            let data = try Data(contentsOf: url)
            
            // Try to decode the data into objects
            let decoder = JSONDecoder()
            let array = try decoder.decode([Question].self, from: data)
            
            // Notify the delegate of the parsed objects
            delegate?.questionsRetrieved(array)
        }
        catch {
            // Error: Could not download the data at that URL
        }
    }
    
    func getRemoteJsonFile() {
        
        // Get a URL object
        let urlString = "https://codewithchris.com/code/QuestionData.json"
        
        let url = URL(string: urlString)
        
        guard url != nil else {
            print("Could not create the URL object")
            return
        }
        
        // Get a URL Session object
        let session = URLSession.shared
        
        // Get a data task object
        let dataTask = session.dataTask(with: url!) { (data, response, error) in
            
            // Check that there was not an error
            if error == nil && data != nil {
                
                do {
                    
                    // Create a JSOn Decoder object
                    let decoder = JSONDecoder()
                    
                    // Parse the JSON
                    let array = try decoder.decode([Question].self, from: data!)
                    
                    // Use the main thread to notify the view controller for UI Work
                    DispatchQueue.main.async {
                        
                        // Notify the delegate
                        self.delegate?.questionsRetrieved(array)
                    }
                    
                    
                }
                catch {
                    print("Could not parse JSON")
                }
                
                
                
            }
            
        }
        
        // Call resume on the data task
        dataTask.resume()
    }
}
