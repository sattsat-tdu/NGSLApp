//
//  Word.swift
//  NGSLApp
//  
//  Created by SATTSAT on 2025/02/09
//  
//

enum Pos: String {
    case noun = "名詞"
    case verb = "動詞"
    case adjective = "形容詞"
    case adverb = "副詞"
    case pronoun = "代名詞"
    case preposition = "前置詞"
    case conjunction = "接続詞"
    case interjection = "間投詞"
    case determiner = "限定詞"
    case article = "冠詞"
    case numeral = "数詞"
    case numeral2 = "数字"
    case auxiliaryVerb = "助動詞"
    case participle = "分詞"
    case infinitive = "不定詞"
    case gerund = "動名詞"
    case unknown = "不明" // ✅ 変換失敗時のフォールバック用
}

struct Word: Identifiable {
    let id: Int
    let english: String
    let japanese: String
    let pos: Pos
    let en_sentence: String
    let jp_sentence: String
    
    static func mock() -> Word {
        return Word(
            id: 1,
            english: "Hello",
            japanese: "こんにちは",
            pos: .noun,
            en_sentence: "Hello World",
            jp_sentence: "こんにちは世界"
        )
    }
}
