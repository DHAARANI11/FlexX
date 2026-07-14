//
//  FileStorage.swift
//  BankingSystem
//
//  Created by Dhaarani M on 30/06/26.
//

import Foundation

struct FileStorage {

    static func fileURL(named filename: String) -> URL {
        let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return directory.appendingPathComponent(filename)
    }

    static func readLines(from url: URL) -> [String] {
        guard let content = try? String(contentsOf: url, encoding: .utf8) else {
            return []
        }
        return content
            .components(separatedBy: .newlines)
            .filter { !$0.isEmpty }
    }

    static func write(_ lines: [String], to url: URL) {
        let content = lines.joined(separator: "\n")
        do {
            try content.write(to: url, atomically: true, encoding: .utf8)
        } catch {
            print("Error writing to \(url.lastPathComponent): \(error)")
        }
    }
}
