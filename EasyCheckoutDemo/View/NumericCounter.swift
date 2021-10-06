//
// Created on 2020/11/18, by Yin Tan
// 
//

import SwiftUI

struct NumericCounter: View {
    @Binding private var count: Int
    private let range: Range<Int>

    init(count: Binding<Int>, range: Range<Int> = 0..<Int.max) {
        _count = count
        self.range = range
    }

    var body: some View {
        HStack {
            if count <= range.lowerBound {
                EmptyView()
            } else {
                Button(action: {
                    withAnimation {
                        count = max(range.lowerBound, count - 1)
                    }
                }) {
                    Image(systemName: "minus.circle")
                        .foregroundColor(.blue)
                }
            }

            if count <= range.lowerBound {
                EmptyView()
            } else {
                Text(String(count))
            }

            if count >= range.upperBound {
                EmptyView()
            } else {
                Button(action: {
                    withAnimation {
                        count = min(range.upperBound, count + 1)
                    }
                }) {
                    Image(systemName: "plus.circle.fill")
                        .foregroundColor(.blue)
                }
            }
        }
    }
}

struct NumericCounterPreivew: PreviewProvider {
    @State static private var count: Int = 1
    static var previews: some View {
        NumericCounter(count: $count)
            .previewLayout(.fixed(width: 100, height: 40))
    }
}
