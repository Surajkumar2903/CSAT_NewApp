//
//  MorphingSymbolView.swift
//  CSAT_NewApp
//
//  Created by Suraj Kumar on 16/12/25.
//

import SwiftUI


////Custom symbols
struct MorphingSymbolView: View {
    var symbol: String
    var config: Config
    //// View Properties
    @State private var trigger : Bool = false
    @State private var displayingSymbol : String
    @State private var nextSymbol : String = ""
    init(symbol: String, config: Config) {
        self.symbol = symbol
        self.config = config
        _displayingSymbol = State(initialValue: symbol)
    }

    var body: some View {
        Canvas { ctx , size in
            ctx.addFilter(.alphaThreshold(min: 0.4, color: config.foregroundColor))
            
            if let renderedImage = ctx.resolveSymbol(id: 0){
                ctx.draw(renderedImage, at: CGPoint(x: size.width / 2, y: size.height / 2))
            }
        } symbols: {
            ImageView()
                .tag(0)
        }
        .frame(width: config.frame.width, height: config.frame.height)
        .onChange(of: symbol) { oldValue , newValue in
            trigger.toggle()
            nextSymbol = newValue
        }
//        .task {
//            guard displayingSymbol == "" else { return }
//            displayingSymbol = symbol
//        }
    }
    
    @ViewBuilder
    func ImageView() -> some View {
        KeyframeAnimator(initialValue: CGFloat.zero, trigger: trigger) { radius in
            Image(systemName: displayingSymbol)
                .font(config.font)
                .blur(radius: radius)
                .frame(width: config.frame.width,height: config.frame.height)
                .onChange(of: radius) { oldValue , newvalue in
                    if newvalue.rounded() == config.radius{
                        //Animating Symbol Change
                        withAnimation(config.symbolAnimation){
                            displayingSymbol = nextSymbol
                        }
                    }
                }
        } keyframes: { _ in
            CubicKeyframe(config.radius, duration: config.keyframeDuration)
            CubicKeyframe(0, duration: config.keyframeDuration)
        }

            
    }
    
    
    struct Config{
        var font : Font
        var frame : CGSize
        var radius : CGFloat
        var foregroundColor : Color
        var keyframeDuration : CGFloat = 0.4
        var symbolAnimation : Animation = .smooth(duration: 0.5, extraBounce: 0)
    }
}


