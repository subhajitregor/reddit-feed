import UIKit


//Extend collections with a function that returns an array of strings sorted by their lengths,
//longest first.

// ["a", "abc", "ab"] -> ["abc", "ab", "a"]

let arr = ["a", "abc", "ab", "abcd", "af", "aghjkl"]

func sortByLength(arr: [String]) -> [String] {
    return arr.sorted { $0.count > $1.count }
}

extension Collection where Element == String {
    func sortByLength() -> [String] {
        self.sorted { $0.count > $1.count }
    }
}

print(arr.sortByLength())
