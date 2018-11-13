//
//  APILib.swift
//  Sail
//
//  https://gist.github.com/ivanbruel/e72d938f49db64d2f5df09fb9420c1e2
//

import Foundation

extension String {
    
    func snakeCased() -> String? {
        let pattern = "([a-z0-9])([A-Z])"
        
        let regex = try? NSRegularExpression(pattern: pattern, options: [])
        let range = NSRange(location: 0, length: self.count)
        return regex?.stringByReplacingMatches(in: self, options: [], range: range, withTemplate: "$1_$2").lowercased()
    }
}
