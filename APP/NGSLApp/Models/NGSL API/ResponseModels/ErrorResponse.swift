//
//  ErrorResponse.swift
//  NGSLApp
//  
//  Created by SATTSAT on 2025/02/09
//  
//

struct ErrorResponse: Decodable {
    let detail: [ErrorDetailResponse]
}

struct ErrorDetailResponse: Decodable {
    let loc: [String]
    let msg: String
    let type: String
}
