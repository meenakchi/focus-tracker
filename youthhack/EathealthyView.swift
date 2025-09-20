import SwiftUI

struct EathealthyView: View {
    @State private var veggiesPosition = CGSize(width: 120, height: 250)
    @State private var fruitPosition = CGSize(width: -5, height: 250)
    @State private var pizzaPosition = CGSize(width: -120, height: 250)
    @State private var fishPosition = CGSize(width: -120, height: -250)
    @State private var breadPosition = CGSize(width: 0, height: -250)
    @State private var burgerPosition = CGSize(width: 120, height: -250)
    
    @State private var veggiesOnPlate = false
    @State private var fruitOnPlate = false
    @State private var pizzaOnPlate = false
    @State private var fishOnPlate = false
    @State private var breadOnPlate = false
    @State private var burgerOnPlate = false
    
    // Plate center coordinates (relative to the view)
    private let plateCenter = CGSize(width: 0, height: 0)
    private let plateRadius: CGFloat = 150
    
    var body: some View {
        ZStack {
            Color.green.opacity(0.2).ignoresSafeArea()
            
            // Plate (static)
            Image("plate")
                .resizable()
                .frame(width: 400, height: 300)
            Text("Make a healthy meal for octoo!🍉")
                .font(.title2)
                .bold()
                .offset(y: -350)
            // Draggable food items
            DraggableFoodItem(
                imageName: "veggies",
                size: CGSize(width: 100, height: 100),
                position: $veggiesPosition,
                isOnPlate: $veggiesOnPlate,
                plateCenter: plateCenter,
                plateRadius: plateRadius
            )
            
            DraggableFoodItem(
                imageName: "fruit",
                size: CGSize(width: 70, height: 70),
                position: $fruitPosition,
                isOnPlate: $fruitOnPlate,
                plateCenter: plateCenter,
                plateRadius: plateRadius
            )
            
            DraggableFoodItem(
                imageName: "pizza",
                size: CGSize(width: 70, height: 100),
                position: $pizzaPosition,
                isOnPlate: $pizzaOnPlate,
                plateCenter: plateCenter,
                plateRadius: plateRadius
            )
            
            DraggableFoodItem(
                imageName: "fish",
                size: CGSize(width: 150, height: 70),
                position: $fishPosition,
                isOnPlate: $fishOnPlate,
                plateCenter: plateCenter,
                plateRadius: plateRadius
            )
            
            DraggableFoodItem(
                imageName: "bread",
                size: CGSize(width: 80, height: 80),
                position: $breadPosition,
                isOnPlate: $breadOnPlate,
                plateCenter: plateCenter,
                plateRadius: plateRadius
            )
            
            DraggableFoodItem(
                imageName: "hamburger",
                size: CGSize(width: 90, height: 90),
                position: $burgerPosition,
                isOnPlate: $burgerOnPlate,
                plateCenter: plateCenter,
                plateRadius: plateRadius
            )
            
            Image("octoo")
                .resizable()
                .frame(width: 150, height: 150)
                .offset(x: -120, y:400)
            
            // Healthy food message
            if veggiesOnPlate || fruitOnPlate || fishOnPlate || breadOnPlate {
                VStack {
                    Spacer()
                    Text("Great job! Keep adding healthy foods to your plate!")
                        .font(.headline)
                        .foregroundColor(.green)
                        .padding()
                        .background(Color.white.opacity(0.9))
                        .cornerRadius(10)
                        .padding(.bottom, 50)
                }
            }

            // Unhealthy food message
            if burgerOnPlate || pizzaOnPlate {
                VStack {
                    Spacer()
                    Text("Oh no octoo eating unhealthy food will make him focus less!")
                        .font(.headline)
                        .foregroundColor(.red)
                        .padding()
                        .background(Color.white.opacity(0.9))
                        .cornerRadius(10)
                        .padding(.bottom, 50)
                }
            }

            }

        }
    }
    
    struct DraggableFoodItem: View {
        let imageName: String
        let size: CGSize
        @Binding var position: CGSize
        @Binding var isOnPlate: Bool
        let plateCenter: CGSize
        let plateRadius: CGFloat
        
        @State private var dragOffset = CGSize.zero
        
        var body: some View {
            Image(imageName)
                .resizable()
                .frame(width: size.width, height: size.height)
                .offset(x: position.width + dragOffset.width, y: position.height + dragOffset.height)
                .scaleEffect(isOnPlate ? 0.8 : 1.0) // Slightly smaller when on plate
                .opacity(isOnPlate ? 0.9 : 1.0)
                .animation(.easeInOut(duration: 0.2), value: isOnPlate)
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            dragOffset = value.translation
                        }
                        .onEnded { value in
                            // Calculate final position
                            let finalPosition = CGSize(
                                width: position.width + value.translation.width,
                                height: position.height + value.translation.height
                            )
                            
                            // Check if the food item is close enough to the plate center
                            let distance = sqrt(pow(finalPosition.width - plateCenter.width, 2) +
                                                pow(finalPosition.height - plateCenter.height, 2))
                            
                            if distance <= plateRadius {
                                // Snap to plate with some randomness for natural look
                                let randomX = Double.random(in: -50...50)
                                let randomY = Double.random(in: -50...50)
                                
                                withAnimation(.spring()) {
                                    position = CGSize(width: randomX, height: randomY)
                                    isOnPlate = true
                                }
                            } else {
                                // Update position to where it was dragged
                                withAnimation(.spring()) {
                                    position = finalPosition
                                    isOnPlate = false
                                }
                            }
                            
                            // Reset drag offset
                            dragOffset = .zero
                        }
                )
        }
    }

#Preview {
    EathealthyView()
}
