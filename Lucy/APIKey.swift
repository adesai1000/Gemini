//
//  APIKey.swift
//  Lucy
//
//  Created by Ayush Desai on 7/16/24.
//

import Foundation

enum APIKey{
    static var `default`: String{
        guard let filePath = Bundle.main.path(forResource: "GenerativeAI-Info", ofType: "plist")
        else{
            fatalError("Couldn't Find the File GenerativeAI-Info")
        }
        let plist = NSDictionary(contentsOfFile: filePath)
        guard let value = plist?.object(forKey:"API_KEY") as? String else{
            fatalError("Couldn't find key 'API_KEY' in GenerativeAi-Info")
        }
        if value.starts(with: "_"){
            fatalError("Follow the instructions at https://ai.google.dev/gemini-api/docs/api-key to get an API Key")
        }
        return value
    }
}
