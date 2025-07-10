//
//  Date+Formatting.swift
//  SHUtils
//
//  Created by Catalin Lucaciu on 25.05.2025.
//

import Foundation

public extension Date {
    
    var formattedAsRelativeOrAbsolute: String {
        let now = Date()
        let interval = now.timeIntervalSince(self)
        let cutoff: TimeInterval = 60 * 60 * 24 * 28
        
        if interval > cutoff {
            return self.absoluteFormatter.string(from: self)
        } else {
            return self.relativeFormatter.localizedString(for: self, relativeTo: now)
        }
    }
    
    private var relativeFormatter: RelativeDateTimeFormatter {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        formatter.locale = Locale(identifier: "en")
        return formatter
    }
    
    private var absoluteFormatter: DateFormatter {
           let formatter = DateFormatter()
           formatter.dateStyle = .medium
           formatter.timeStyle = .none
           formatter.locale = Locale(identifier: "en")
           return formatter
       }
}
