//
//  SchoolManagement.swift
//  SchoolManagement
//
//  Created by Shashinoor Ghimire on 26/11/2023.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {

// Placeholder is used as a placeholder when the widget is first displayed
    func placeholder(in context: Context) -> AssignmentEntry {
//      Add some placeholder title and description, and get the current date
      AssignmentEntry(date: Date(), titles: ["Title 1", "Title 2"])
    }

// Snapshot entry represents the current time and state
    func getSnapshot(in context: Context, completion: @escaping (AssignmentEntry) -> ()) {
      let entry: AssignmentEntry
      if context.isPreview{
        entry = placeholder(in: context)
      }
      else{
        //      Get the data from the user defaults to display
        let userDefaults = UserDefaults(suiteName: "group.com.example.schoolmanagement")
        //i have a list of titles separated by %% and i want to store it in a list
        let list_titles_string = userDefaults?.string(forKey: "assignments") ?? "No Titles"
        let titles = list_titles_string.components(separatedBy: "/?")
        let title = userDefaults?.string(forKey: "headline_title") ?? "No Title"
        entry = AssignmentEntry(date: Date(), titles: titles)
      }
        completion(entry)
    }

//    getTimeline is called for the current and optionally future times to update the widget
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
//      This just uses the snapshot function you defined earlier
      getSnapshot(in: context) { (entry) in
// atEnd policy tells widgetKit to request a new entry after the date has passed
        let timeline = Timeline(entries: [entry], policy: .atEnd)
                  completion(timeline)
              }
    }
}


struct AssignmentEntry:TimelineEntry {
    let date: Date
    let titles: [String]
}

struct SchoolManagementEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        VStack {
            Text("Assignments")
                .font(.headline)
                .foregroundColor(.black)
            Divider()
            ForEach(entry.titles, id: \.self) { title in
                Text(title)
                .font(.headline)
                .foregroundColor(.black)
                Divider()
            }
        }
    }
}


// @main
struct SchoolManagement: Widget {
    let kind: String = "SchoolManagement"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            SchoolManagementEntryView(entry: entry)
        }
        .configurationDisplayName("SchoolManagement")
        .description("This is an example widget.")
    }
}

struct SchoolManagement_Previews: PreviewProvider {
    static var previews: some View {
        SchoolManagementEntryView(entry: AssignmentEntry(date: Date(), titles: ["Title 1", "Title 2"]))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}