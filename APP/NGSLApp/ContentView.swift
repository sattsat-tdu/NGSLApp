//
//  ContentView.swift
//  NGSLApp
//  
//  Created by SATTSAT on 2025/02/07
//  
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var viewModel = ContentViewModel()
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Text("NGSL単語一覧")
                        .font(.largeTitle.bold())
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                
                ScrollView() {
                    LazyVStack {
                        ForEach(viewModel.words) { word in
                            WordCell(word: word)
                        }
                        
                        Button("追加読み込み") {
                            viewModel.loadMoreWords()
                        }
                    }
                    .padding()
                }
            }
            
            if viewModel.isLoading {
                Color.gray.opacity(0.2)
                    .ignoresSafeArea()
                    .overlay {
                        ProgressView()
                    }
            }
        }
        .onAppear {
            viewModel.refreshWords()
        }
        .refreshable {
            viewModel.refreshWords()
        }
    }
}

#Preview {
    ContentView()
}
