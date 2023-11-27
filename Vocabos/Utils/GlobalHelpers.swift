//
//  GlobalHelpers.swift
//  Vocabos
//
//  Created by Sinan Tanrıkut on 15.09.2023.
//

import UIKit

var globalKey: String {
    UUID().uuidString
}

/// Opens a sharing sheet with given items
@discardableResult
func share(
    items: [Any],
    excludedActivityTypes: [UIActivity.ActivityType]? = nil
) -> Bool {
    guard let source = UIApplication.shared.windows.last?.rootViewController else {
        return false
    }
    let vc = UIActivityViewController(
        activityItems: items,
        applicationActivities: nil
    )
    vc.excludedActivityTypes = excludedActivityTypes
    vc.popoverPresentationController?.sourceView = source.view
    source.present(vc, animated: true)
    return true
}

func printError(_ items: Any..., separator: String = " ", terminator: String = "\n") {
    if items.count == 1, items.first is String {
        print("🍎\(items.first as! String)")
    } else {
        print("🍎\(items)")
    }
}

func printSuccess(_ items: Any..., separator: String = " ", terminator: String = "\n") {
    if items.count == 1, items.first is String {
        print("🍏\(items.first as! String)")
    } else {
        print("🍏\(items)")
    }
}

func printInfo(_ items: Any..., separator: String = " ", terminator: String = "\n") {
    if items.count == 1, items.first is String {
        print("ℹ️\(items.first as! String)")
    } else {
        print("ℹ️\(items)")
    }
}
