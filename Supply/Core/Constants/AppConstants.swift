import Foundation
import SwiftUI

enum AppConstants {
    // MARK: - UI Constants
    enum UI {
        static let standardPadding: CGFloat = 16
        static let smallPadding: CGFloat = 8
        static let cornerRadius: CGFloat = 10
        static let buttonHeight: CGFloat = 44
    }
    
    // MARK: - Navigation Titles
    enum NavigationTitles {
        static let home = "Supply"
        static let items = "Items"
        static let settings = "Settings"
    }
    
    // MARK: - Colors
    enum Colors {
        static let primary = Color.blue
        static let secondary = Color.gray
        static let background = Color(UIColor.systemBackground)
        static let text = Color(UIColor.label)
    }
    
    // MARK: - Animation
    enum Animation {
        static let standard = SwiftUI.Animation.easeInOut(duration: 0.3)
        static let quick = SwiftUI.Animation.easeInOut(duration: 0.2)
    }
} 