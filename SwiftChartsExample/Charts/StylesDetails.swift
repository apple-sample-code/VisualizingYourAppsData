/*
See LICENSE folder for this sample’s licensing information.

Abstract:
Styles Details definitions.
*/

import Charts
import SwiftUI

struct StylesDetailsChart: View {
    let data: [(name: String, sales: Int)]

    var body: some View {
        Chart(data, id: \.name) { element in
            BarMark(
                x: .value("Sales", element.sales),
                y: .value("Name", element.name)
            )
        }
    }
}

struct StylesDetails: View {
    @State private var timeRange: TimeRange = .last30Days

    var data: [(name: String, sales: Int)] {
        switch timeRange {
        case .last30Days:
            return TopStyleData.last30Days
        case .last12Months:
            return TopStyleData.last12Months
        }
    }

    var body: some View {
        List {
            VStack(alignment: .leading) {
                TimeRangePicker(value: $timeRange)
                    .padding(.bottom)

                Text("Most Sold Style")
                    .font(.callout)
                    .foregroundStyle(.secondary)

                Text(data.first?.name ?? "Unknown")
                    .font(.title2.bold())
                    .foregroundColor(.primary)

                StylesDetailsChart(data: data)
                    .frame(height: 300)
            }
            .listRowSeparator(.hidden)

            Section("Options") {
                TransactionsLink()
            }
        }
        .listStyle(.plain)
        .navigationBarTitle("Style", displayMode: .inline)
        .navigationDestination(for: [Transaction].self) { transactions in
            TransactionsView(transactions: transactions)
        }
    }
}

struct StylesDetails_Previews: PreviewProvider {
    static var previews: some View {
        StylesDetails()
    }
}
