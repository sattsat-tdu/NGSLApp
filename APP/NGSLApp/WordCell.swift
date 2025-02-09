//
//  WordCell.swift
//  NGSLApp
//  
//  Created by SATTSAT on 2025/02/09
//  
//

import SwiftUI

struct WordCell: View {
    
    let word: Word
    
    var body: some View {
        VStack {
            VStack() {
                Text(word.english)
                    .font(.headline)
                
                Text(word.japanese)
            }
            .frame(maxWidth: .infinity)
            
            Divider()
            
            VStack {
                Text(word.en_sentence)
                
                Text(word.jp_sentence)
            }
            .frame(maxWidth: .infinity, alignment: .center)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(.gray.opacity(0.1))
        .clipShape(.rect(cornerRadius: 8))
        .overlay(alignment: .topLeading) {
            Text(word.pos.rawValue)
                .padding(8)
                .fontWeight(.semibold)
                .background(.yellow)
                .clipShape(Capsule())
                .padding(12)
        }
    }
}

#Preview {
    WordCell(word: Word.mock())
}
