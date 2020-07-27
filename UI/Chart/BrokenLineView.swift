//
// Created by Sergey Chelak
//

import SwiftUI

struct BrokenLineView: View {

    var data: [Double]
    var color: Color
    var globalMax: Double?
    var globalMin: Double?


    var body: some View {
        GeometryReader { reader in
            Path { path in
                guard self.data.count > 1,
                      let min = self.globalMin ?? self.data.min(),
                      let max = self.globalMax ?? self.data.max() else {
                    return
                }
                let rate = Double(reader.size.height) / (max - min)
                let values = self.data.map {
                    ($0 - min) * rate
                }

                let xStep = Double(reader.size.width) / Double(self.data.count)
                path.move(to: CGPoint(x: 0, y: values[0]))
                for i in 0..<values.count {
                    path.addLine(to: CGPoint(x: Double(i + 1) * xStep, y: values[i]))
                }
            }
                    .stroke(self.color, style: StrokeStyle(lineWidth: 3, lineJoin: .round))
                    .rotationEffect(.degrees(180), anchor: .center)
                    .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
        }
    }

}

struct BrokenLine_Previews: PreviewProvider {
    static var previews: some View {
        let data: [Double] = [0.0, 20, 10, 40, 30, 60, -10]
        return BrokenLineView(data: data, color: Color.green)
    }
}
