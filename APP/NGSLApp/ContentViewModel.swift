//
//  ContentViewModel.swift
//  NGSLApp
//  
//  Created by SATTSAT on 2025/02/09
//  
//

import Foundation

@MainActor
final class ContentViewModel: ObservableObject {
    @Published var words: [Word] = []
    @Published var results_available: Int = 0
    @Published var isLoading: Bool = false
    
    private var results_start: Int = 0
    private let apiClient = NGSLAPIClient()
    
    func refreshWords() {
        self.words = []  // 🔸 リストをクリア
        self.results_start = 0  // 🔸 ページングをリセット
        loadMoreWords()  // 🔹 最初のページを取得
    }
    
    /// 🔹 次のページのデータを取得する
    func loadMoreWords() {
        guard !isLoading, results_start == 0 || results_start < results_available else {
            return
        }

        let request = WordsRequest(count: 20, start: results_start)
        
        Task {
            self.isLoading = true
            let result = await apiClient.fetchWords(request: request)
            switch result {
            case .success(let wordsResponse):
                self.words.append(contentsOf: wordsResponse.toWordModels())  // 🔹 既存のリストに追加
                self.results_available = wordsResponse.results_available
                self.results_start = wordsResponse.results_start + wordsResponse.words.count  // 🔹 取得位置を更新
            case .failure(let error):
                print("[ERROR] \(error)")
            }
            self.isLoading = false
        }
    }
}
