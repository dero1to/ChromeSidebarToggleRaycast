#!/usr/bin/swift

// Required parameters:
// @raycast.schemaVersion 1
// @raycast.title Chrome Mouse Offset
// @raycast.mode compact

// Optional parameters:
// @raycast.icon 🎯
// @raycast.packageName Chrome Utils

import CoreGraphics
import Foundation

guard let currentEvent = CGEvent(source: nil) else {
    print("Cannot read mouse position")
    exit(1)
}
let mousePos = currentEvent.location

guard let windowList = CGWindowListCopyWindowInfo(
    [.optionOnScreenOnly, .excludeDesktopElements],
    kCGNullWindowID
) as? [[String: Any]] else {
    print("Cannot retrieve window list")
    exit(1)
}

guard let chromeWindow = windowList.first(where: {
    ($0[kCGWindowOwnerName as String] as? String) == "Google Chrome"
        && ($0[kCGWindowLayer as String] as? Int) == 0
}) else {
    print("No visible Chrome window found")
    exit(1)
}

guard let boundsDict = chromeWindow[kCGWindowBounds as String] as? CFDictionary,
      let rect = CGRect(dictionaryRepresentation: boundsDict) else {
    print("Cannot read Chrome window bounds")
    exit(1)
}

let offsetX = Int(mousePos.x - rect.origin.x)
let offsetY = Int(mousePos.y - rect.origin.y)

print("Offset: x=\(offsetX), y=\(offsetY)")
