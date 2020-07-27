//
// Created by Sergey Chelak
//

import Foundation
import SwiftUI

class PerformanceViewModel: QuoteViewModel {

    private(set) var performances = [QuotePerformance]()
    private(set) var max: Double?
    private(set) var min: Double?

    override var data: [QuoteSymbol] {
        didSet {
            updateModel()
        }
    }

    private func updateModel() {
        self.performances = self.data.map {
            QuotePerformance(id: $0.symbol, performance: $0.performance, color: Color.random())
        }
        let mins = self.performances.compactMap {
            $0.performance.min()
        }
        let maxs = self.performances.compactMap {
            $0.performance.max()
        }
        self.min = mins.min()
        self.max = maxs.max()
    }

}

struct QuotePerformance: Identifiable {
    var id: String
    var performance: [Double]
    var color: Color
}


fileprivate extension Color {

    static func random() -> Color {
        Color(red: Double(arc4random_uniform(255)) / 255.0,
                green: Double(arc4random_uniform(255)) / 255.0,
                blue: Double(arc4random_uniform(255)) / 255.0)
    }

}
