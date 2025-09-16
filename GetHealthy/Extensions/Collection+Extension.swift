//
//  Collection+Extension.swift
//  GetHealthy
//
//  Created by Archana Kumari on 16/09/25.
//

import Foundation

extension Collection {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
