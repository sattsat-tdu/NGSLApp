//
//  WordsRequest.swift
//  NGSLApp
//  
//  Created by SATTSAT on 2025/02/09
//  
//

struct WordsRequest: Encodable {
    let pos: String?
    let count: Int
    let start: Int

    // デフォルト値を設定する
    init(pos: String? = nil, count: Int = 20, start: Int = 0) {
        self.pos = pos
        self.count = count
        self.start = start
    }
}
