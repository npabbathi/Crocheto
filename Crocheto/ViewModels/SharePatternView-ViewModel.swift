//
//  SharePatternView-ViewModel.swift
//  Crocheto
//
//  Created by Nidhi Pabbathi on 11/16/23.
//

import Foundation

extension SharePatternView {
    @MainActor class ViewModel: ObservableObject {
        /// function to get the final text version of a pattern to share to others in SharePatternView
        /// - Parameters:
        ///   - rows: array of rows consisting the pattern
        ///   - patternName: name of the pattern
        /// - Returns: string version of the pattern to share in text format
        func getSharePattern(rows : [Row], patternName : String) -> String {
            var finalPattern = "🧶 " + patternName + "\n\n";
            
            for row in rows {
                finalPattern += row.getPattern() + "\n"
            }
            
            return finalPattern;
        }
    }
}
