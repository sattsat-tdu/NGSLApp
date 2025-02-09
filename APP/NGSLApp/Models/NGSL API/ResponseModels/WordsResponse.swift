//
//  WordsResponse.swift
//  NGSLApp
//  
//  Created by SATTSAT on 2025/02/09
//  
//

struct WordsResponse: Decodable {
    let results_available: Int
    let results_start: Int
    let words: [WordResponse]
    
    func toWordModels() -> [Word] {
        return words.map { $0.toModel() }
    }
}
