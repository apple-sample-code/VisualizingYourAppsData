/*
See LICENSE folder for this sample’s licensing information.

Abstract:
Sales Details definitions.
*/

import Charts
import SwiftUI

struct DailySalesChart: View {
    let showAverageLine: Bool

    var body: some View {
        Chart {
            ForEach(SalesData.last30Days, id: \.day) {
                BarMark(
                    x: .value("Day", $0.day, unit: .day),
                    y: .value("Sales", $0.sales)
                )
            }
            .foregroundStyle(showAverageLine ? .gray.opacity(0.3) : .blue)

            if showAverageLine {
                RuleMark(
                    y: .value("Average", SalesData.last30DaysAverage)
                )
                .lineStyle(StrokeStyle(lineWidth: 3))
                .annotation(position: .top, alignment: .leading) {
                    Text("Average: \(SalesData.last30DaysAverage, format: .number)")
                        .font(.body.bold())
                        .foregroundStyle(.blue)
                }
            }
        }
    }
}

struct MonthlySalesChart: View {
    var body: some View {
        Chart(SalesData.last12Months, id: \.month) {
            BarMark(
                x: .value("Month", $0.month, unit: .month),
                y: .value("Sales", $0.sales)
            )
        }
        .chartXAxis {
            AxisMarks(values: .stride(by: .month)) { _ in
                AxisGridLine()
                AxisTick()
                AxisValueLabel(format: .dateTime.month(.narrow), centered: true)
            }
        }
    }
}

struct SalesDetails: View {
    @State private var timeRange: TimeRange = .last30Days
    @State private var showAverageLine: Bool = false

    var body: some View {
        List {
            VStack(alignment: .leading) {
                TimeRangePicker(value: $timeRange)
                    .padding(.bottom)

                Text("Total Sales")
                    .font(.callout)
                    .foregroundStyle(.secondary)

                switch timeRange {
                case .last30Days:
                    Text("\(SalesData.last30DaysTotal, format: .number) Pancakes")
                        .font(.title2.bold())
                        .foregroundColor(.primary)

                    DailySalesChart(showAverageLine: showAverageLine)
                        .frame(height: 240)
                case .last12Months:
                    Text("\(SalesData.last12MonthsTotal, format: .number) Pancakes")
                        .font(.title2.bold())
                        .foregroundColor(.primary)

                    MonthlySalesChart()
                        .frame(height: 240)
                }
            }
            .listRowSeparator(.hidden)

            Section("Options") {
                if timeRange == .last30Days {
                    Toggle("Show Daily Average", isOn: $showAverageLine)
                }
                TransactionsLink()
            }
        }
        .listStyle(.plain)
        .navigationBarTitle("Total Sales", displayMode: .inline)
        .navigationDestination(for: [Transaction].self) { transactions in
            TransactionsView(transactions: transactions)
        }
    }
}

struct SalesDetails_Previews: PreviewProvider {
    static var previews: some View {
        SalesDetails()
    }
}
