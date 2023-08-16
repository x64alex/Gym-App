import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    
    typealias Entry = ViewSizeEntry

    func placeholder(in context: Context) -> Entry {
        // This data will be masked
        return ViewSizeEntry(date: Date(), providerInfo: "placeholder")
    }

    func getSnapshot(in context: Context, completion: @escaping (Entry) -> ()) {
        let entry = ViewSizeEntry(date: Date(), providerInfo: "snapshot")
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        let entry = ViewSizeEntry(date: Date(), providerInfo: "timeline")
        let timeline = Timeline(entries: [entry], policy: .never)
        completion(timeline)
    }
}

struct ViewSizeEntry: TimelineEntry {
    let date: Date
    let providerInfo: String
}

struct ViewSizeWidgetView : View {
   
    let entry: ViewSizeEntry

    var body: some View {
        GeometryReader { geometry in
            VStack {
                
                // Show view size
                Text("\(Int(geometry.size.width)) x \(Int(geometry.size.height))")
                    .font(.system(.title2, weight: .bold))
                
                // Show provider info
                Text(entry.providerInfo)
                    .font(.footnote)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.green)
        }
    }
}
