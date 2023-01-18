//
//  ContentView.swift
//  InYourHeart
//
//  Created by 刘铭 on 2023/1/18.
//

import SwiftUI

struct ContentView: View {
    
    private let dragArea: CGFloat = 65.0
    
    @State var showAlert = false
    @State var showGuide = false
    @State var showInfo = false
    @State private var lastCardIndex = 1
    @GestureState private var dragState = DragState.inactive
    
    @State var cardViews: [CardView] = {
        var views = [CardView]()
        
        for index in 0 ..< 2{
            views.append(CardView(photo: inYourHeartData[index]))
        }
        return views
    }()
    
    enum DragState{
        case inactive
        case pressing
        case dragging(translation: CGSize)
        
        var translation: CGSize{
            switch self{
            case .inactive,.pressing:
                return .zero
            case .dragging(let translation):
                return translation
            }
        }
        
        var isDragging: Bool{
            switch self{
            case .inactive, .pressing:
                return false
            case .dragging:
                return true
            }
        }
        
        var isPressing: Bool{
            switch self{
            case .pressing, .dragging:
                return true
            case .inactive:
                return false
            }
        }
    }
    
    var body: some View {
        
        VStack{
            HeaderView(showGuidView: $showGuide,showInfoView: $showInfo)
                .opacity(dragState.isDragging ? 0.0: 1.0)
                .animation(.default)
            Spacer()
            ZStack{
                ForEach(cardViews){
                    cardView in cardView
                        .zIndex(self.isTopCard(cardView: cardView) ? 1: 0)
                        .overlay(
                            ZStack{
                            Image(systemName: "x.circle")
                                .modifier(SymbolModifier())
                                .opacity(dragState.translation.width < -dragArea && isTopCard(cardView: cardView) ? 1.0: 0)
                            Image(systemName: "heart.circle")
                                    .modifier(SymbolModifier())
                                    .opacity(dragState.translation.width > dragArea && isTopCard(cardView: cardView) ? 1.0: 0)
                            }
                            )
                        .offset(x: isTopCard(cardView: cardView) ?  self.dragState.translation.width : 0,y: isTopCard(cardView: cardView) ? self.dragState.translation .height : 0)
                        .scaleEffect(isTopCard(cardView: cardView) && self.dragState.isDragging ? 0.85: 1.0)
                        .rotationEffect(Angle(degrees: isTopCard(cardView: cardView) ?  Double(self.dragState.translation.width / 12): 0))
                        .animation(.interpolatingSpring(stiffness: 120, damping: 10))
                        .gesture(
                            LongPressGesture(minimumDuration: 0.01)
                                .sequenced(before: DragGesture())
                                .updating(self.$dragState, body: {
                                    (value,state,translation) in switch value{
                                    case .first(true):
                                        state = .pressing
                                    case .second(true, let drag):
                                        state = .dragging(translation: drag?.translation ?? .zero)
                                    default:
                                        break
                                    }
                                })
                                .onEnded({
                                    (value) in guard case .second(true,let drag?) = value else {return}
                                    
                                    if drag.translation.width < -dragArea || drag.translation.width > dragArea{
                                        moveCards()
                                    }
                                })
                        )
                }
            }
            .padding(.horizontal)
            Spacer()
            FooterView(showHeartAlert: $showAlert)
                .opacity(dragState.isDragging ? 0.0: 1.0)
                .animation(.default)
        }
        .alert(isPresented: $showAlert, content: {
            Alert(title: Text("成功"),message: Text("希望你和你的小伙伴可以在这里度过一段令人难忘的美好时光。"),dismissButton: .default(Text("Have a Good Time")))
        })
        
    }
    
    private func isTopCard(cardView: CardView) -> Bool{
        guard let index = cardViews.firstIndex(where: {$0.id == cardView.id})else{
            return false
        }
        return index == 0
    }
    
    private func moveCards(){
        cardViews.removeFirst()
        
        self.lastCardIndex += 1
        
        let inYourHeart = inYourHeartData[lastCardIndex % inYourHeartData.count]
        let newCardView = CardView(photo: inYourHeart)
        cardViews.append(newCardView)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
