//
//  Strings.swift
//  AstroDay
//
//  Created by Edwy Lugo on 02/02/25.
//

import Foundation

struct Strings {
    static let nav_title_favorites = "nav_title_favorites".localized
    static let nav_title_settings = "nav_title_settings".localized
    static let label_text_theme = "label_text_theme".localized
    static let text_no_favorite = "text_no_favorite".localized
    static let text_no_found = "text_no_found".localized
    static let text_what_a_shame = "text_what_a_shame".localized
    static let button_text_closed = "button_text_closed".localized
    static let button_more = "button_more".localized
    static let button_hide = "button_hide".localized
    static let text_toast_already_added = "text_toast_already_added".localized
    static let text_toast_successfully_added = "text_toast_successfully_added".localized
    static let text_toast_removed = "text_toast_removed".localized
    static func text_toast_not_found(text: String) -> String {
        "text_toast_not_found".localized(with: text)
    }
    static let button_text_ok = "button_text_ok".localized
    static let button_text_cancel = "button_text_cancel".localized
}
