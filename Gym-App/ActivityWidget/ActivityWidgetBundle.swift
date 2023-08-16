import WidgetKit
import SwiftUI

@main
struct ActivityWidgetBundle: Widget {
    let kind: String = "ViewSizeWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            ViewSizeWidgetView(entry: entry)
        }
        .configurationDisplayName("View Size Widget")
        .description("This is a demo widget.")
        .supportedFamilies([
            .systemSmall,
            .systemMedium,
            .systemLarge,
        ])
    }
}
