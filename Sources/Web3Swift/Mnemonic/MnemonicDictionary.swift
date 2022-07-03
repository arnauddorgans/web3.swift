// 
// 

import Foundation

protocol MnemonicDictionary {
  var words: [String] { get }
  
  func word(atIndex index: Int) -> String?
  
  func contains(word: String) -> Bool
}

extension MnemonicDictionary {
  func word(atIndex index: Int) -> String? {
    guard words.indices.contains(index) else { return nil }
    return words[index]
  }
  
  func contains(word: String) -> Bool {
    words
      .filter { $0.decomposedStringWithCompatibilityMapping.starts(with: word.decomposedStringWithCompatibilityMapping) }
      .count == 1
  }
}
