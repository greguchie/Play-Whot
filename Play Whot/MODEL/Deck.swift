struct Deck {
//    private(set)
    var groupOfCards: [Card] = []

    init() {
        groupOfCards = [
            // Square
            Card(shape: .square, number: 1),
            Card(shape: .square, number: 2),
            Card(shape: .square, number: 3),
            Card(shape: .square, number: 5),
            Card(shape: .square, number: 7),
            Card(shape: .square, number: 10),
            Card(shape: .square, number: 11),
            Card(shape: .square, number: 13),
            Card(shape: .square, number: 14),
            
            // Triangle
            Card(shape: .triangle, number: 1),
            Card(shape: .triangle, number: 2),
            Card(shape: .triangle, number: 3),
            Card(shape: .triangle, number: 4),
            Card(shape: .triangle, number: 5),
            Card(shape: .triangle, number: 7),
            Card(shape: .triangle, number: 8),
            Card(shape: .triangle, number: 10),
            Card(shape: .triangle, number: 11),
            Card(shape: .triangle, number: 12),
            Card(shape: .triangle, number: 13),
            Card(shape: .triangle, number: 14),

            // Circle
            Card(shape: .circle, number: 1),
            Card(shape: .circle, number: 2),
            Card(shape: .circle, number: 3),
            Card(shape: .circle, number: 4),
            Card(shape: .circle, number: 5),
            Card(shape: .circle, number: 7),
            Card(shape: .circle, number: 8),
            Card(shape: .circle, number: 10),
            Card(shape: .circle, number: 11),
            Card(shape: .circle, number: 12),
            Card(shape: .circle, number: 13),
            Card(shape: .circle, number: 14),

            // Cross
            Card(shape: .cross, number: 1),
            Card(shape: .cross, number: 2),
            Card(shape: .cross, number: 3),
            Card(shape: .cross, number: 5),
            Card(shape: .cross, number: 7),
            Card(shape: .cross, number: 10),
            Card(shape: .cross, number: 11),
            Card(shape: .cross, number: 13),
            Card(shape: .cross, number: 14),

            // Star
            Card(shape: .star, number: 1),
            Card(shape: .star, number: 2),
            Card(shape: .star, number: 3),
            Card(shape: .star, number: 4),
            Card(shape: .star, number: 5),
            Card(shape: .star, number: 7),
            Card(shape: .star, number: 8),

            // Special
            Card(shape: .special, number: 20),
            Card(shape: .special, number: 20),
            Card(shape: .special, number: 20),
            Card(shape: .special, number: 20),
            Card(shape: .special, number: 20),
        ]
    }

    mutating func shuffle() {
        groupOfCards.shuffle()
    }

    mutating func dealAHand(_ count: Int) -> [Card] {
        let aHand = Array(groupOfCards.prefix(count))
        groupOfCards.removeFirst(count)
        return aHand
    }
    //note that "groupOfCards" reduces after each "dealAHand" func called, hence the mutating
}
