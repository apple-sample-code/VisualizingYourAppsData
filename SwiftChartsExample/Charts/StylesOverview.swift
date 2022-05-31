/*
See LICENSE folder for this sample’s licensing information.

Abstract:
Styles Overview definitions.
*/

import Charts
import SwiftUI

struct StylesOverviewChart: View {
    var body: some View {
        Chart(TopStyleData.last12Months, id: \.name) { element in
            BarMark(
                x: .value("Sales", element.sales),
                y: .value("Name", element.name)
            )
            .opacity(element.name == TopStyleData.last30Days.first!.name ? 1 : 0.5)
        }
        .chartXAxis(.hidden)
        .chartYAxis(.hidden)
    }
}

struct StylesOverview: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Most Sold Style")
                .foregroundStyle(.secondary)
            Text(TopStyleData.last30Days.first!.name)
                .font(.title2.bold())
            StylesOverviewChart()
                .frame(height: 100)
        }
    }
}

struct StylesOverview_Previews: PreviewProvider {
    static var previews: some View {
        StylesOverview()
            .padding()
    }
}
