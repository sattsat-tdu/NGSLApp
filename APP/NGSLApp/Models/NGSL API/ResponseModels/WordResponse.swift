//
//  WordResponse.swift
//  NGSLApp
//  
//  Created by SATTSAT on 2025/02/09
//  
//

struct WordResponse: Decodable {
    let id: Int
    let english: String
    let japanese: String
    let pos: String
    let en_sentence: String
    let jp_sentence: String
    
    func toModel() -> Word {
        return Word(id: id, english: english, japanese: japanese, pos: pos, en_sentence: en_sentence, jp_sentence: jp_sentence)
    }
}
