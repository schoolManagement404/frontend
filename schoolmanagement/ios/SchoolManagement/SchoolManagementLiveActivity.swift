//
//  SchoolManagementLiveActivity.swift
//  SchoolManagement
//
//  Created by Shashinoor Ghimire on 26/11/2023.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct SchoolManagementAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct SchoolManagementLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: SchoolManagementAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.emoji)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension SchoolManagementAttributes {
    fileprivate static var preview: SchoolManagementAttributes {
        SchoolManagementAttributes(name: "World")
    }
}

extension SchoolManagementAttributes.ContentState {
    fileprivate static var smiley: SchoolManagementAttributes.ContentState {
        SchoolManagementAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: SchoolManagementAttributes.ContentState {
         SchoolManagementAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: SchoolManagementAttributes.preview) {
   SchoolManagementLiveActivity()
} contentStates: {
    SchoolManagementAttributes.ContentState.smiley
    SchoolManagementAttributes.ContentState.starEyes
}
