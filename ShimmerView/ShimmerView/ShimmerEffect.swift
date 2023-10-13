//
//  ShimmerEffect.swift
//  ShimmerView
//
//  Created by Admin on 13/10/23.
//

import SwiftUI

extension View {
    @ViewBuilder
    func shimmer(_ config: ShimmerConfig) -> some View {
        modifier(ShimmerEffectHelper(config: config))
    }
}

fileprivate struct ShimmerEffectHelper: ViewModifier {
    
    var config: ShimmerConfig
    
    @State private var moveTo: CGFloat = -0.7
    func body(content: Content) -> some View {
        content
            .hidden()
            .overlay {
                Rectangle()
                    .fill(config.tint)
                    .mask {
                        content
                    }
                    .overlay {
                        GeometryReader {
                            let size = $0.size
                            let extraOffset = size .height / 2.5
                            Rectangle()
                                .fill(config.hightlight)
                                .mask {
                                    Rectangle()
                                        .fill(
                                            .linearGradient(colors:  [.white.opacity(0), config.hightlight.opacity(config.hightlightOpacity), .white.opacity(0)], startPoint: .top, endPoint: .bottom)
                                        )
                                        .blur(radius: config.blur)
                                        .rotationEffect(.degrees(-70))
                                        .offset(x: moveTo > 0 ? extraOffset : -extraOffset)
                                        .offset(x: size.width * moveTo)
                                }
                        }
                        .mask {
                            content
                        }
                    }
            }
            .onAppear {
                DispatchQueue.main.async {
                    moveTo = 0.7
                }
            }
            .animation(Animation.linear(duration: config.speed) .repeatForever(autoreverses: false), value: moveTo)
            
    }
}

struct ShimmerConfig {
    var tint: Color
    var hightlight: Color
    var blur: CGFloat = 0
    var hightlightOpacity: CGFloat = 1
    var speed: CGFloat = 2
}
