struct Deck {
    //    private(set)
    var market: [Card] = []
    
    init() {
        market = [
            // Square
            Card(shape: .square, number: 1, effect: .skip),
            Card(shape: .square, number: 2, effect: .skip),
            Card(shape: .square, number: 3, effect: .none),
            Card(shape: .square, number: 5, effect: .none),
            Card(shape: .square, number: 7, effect: .none),
            Card(shape: .square, number: 10, effect: .none),
            Card(shape: .square, number: 11, effect: .none),
            Card(shape: .square, number: 13, effect: .none),
            Card(shape: .square, number: 14, effect: .skip),
            
            // Triangle
            Card(shape: .triangle, number: 1, effect: .skip),
            Card(shape: .triangle, number: 2, effect: .skip),
            Card(shape: .triangle, number: 3, effect: .none),
            Card(shape: .triangle, number: 4, effect: .none),
            Card(shape: .triangle, number: 5, effect: .none),
            Card(shape: .triangle, number: 7, effect: .none),
            Card(shape: .triangle, number: 8, effect: .none),
            Card(shape: .triangle, number: 10, effect: .none),
            Card(shape: .triangle, number: 11, effect: .none),
            Card(shape: .triangle, number: 12, effect: .none),
            Card(shape: .triangle, number: 13, effect: .none),
            Card(shape: .triangle, number: 14, effect: .skip),
            
            // Circle
            Card(shape: .circle, number: 1, effect: .skip),
            Card(shape: .circle, number: 2, effect: .skip),
            Card(shape: .circle, number: 3, effect: .none),
            Card(shape: .circle, number: 4, effect: .none),
            Card(shape: .circle, number: 5, effect: .none),
            Card(shape: .circle, number: 7, effect: .none),
            Card(shape: .circle, number: 8, effect: .none),
            Card(shape: .circle, number: 10, effect: .none),
            Card(shape: .circle, number: 11, effect: .none),
            Card(shape: .circle, number: 12, effect: .none),
            Card(shape: .circle, number: 13, effect: .none),
            Card(shape: .circle, number: 14, effect: .skip),
            
            // Cross
            Card(shape: .cross, number: 1, effect: .skip),
            Card(shape: .cross, number: 2, effect: .skip),
            Card(shape: .cross, number: 3, effect: .none),
            Card(shape: .cross, number: 5, effect: .none),
            Card(shape: .cross, number: 7, effect: .none),
            Card(shape: .cross, number: 10, effect: .none),
            Card(shape: .cross, number: 11, effect: .none),
            Card(shape: .cross, number: 13, effect: .none),
            Card(shape: .cross, number: 14, effect: .skip),
            
            // Star
            Card(shape: .star, number: 1, effect: .skip),
            Card(shape: .star, number: 2, effect: .skip),
            Card(shape: .star, number: 3, effect: .none),
            Card(shape: .star, number: 4, effect: .none),
            Card(shape: .star, number: 5, effect: .none),
            Card(shape: .star, number: 7, effect: .none),
            Card(shape: .star, number: 8, effect: .none),
            
            // Special
            Card(shape: .special, number: 20, effect: .whot),
            Card(shape: .special, number: 20, effect: .whot),
            Card(shape: .special, number: 20, effect: .whot),
            Card(shape: .special, number: 20, effect: .whot),
            Card(shape: .special, number: 20, effect: .whot),
        ]
    }
    
    mutating func shuffle() {
        market.shuffle()
    }
    
    mutating func dealAHand(_ count: Int) -> [Card] {
        let aHand = Array(market.prefix(count))
        market.removeFirst(count)
        return aHand
    }
    
    mutating func drawACard() -> Card? {
        return market.popLast()
    }
    //note that "groupOfCards" reduces after each "dealAHand", "drawACard" func called, hence the mutating
    
}
