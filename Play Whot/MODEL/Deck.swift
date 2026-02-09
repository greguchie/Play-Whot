struct Deck {
//    private(set)
    var groupOfCards: [Card] = []

    init() {
        groupOfCards = [
            // Square
            Card(shape: .square, number: 1),
            Card(shape: .square, number: 2),
            Card(shape: .square, number: 6),
            Card(shape: .square, number: 10),
            Card(shape: .square, number: 11),

            // Circle
            Card(shape: .circle, number: 1),
            Card(shape: .circle, number: 2),
            Card(shape: .circle, number: 6),
            Card(shape: .circle, number: 10),
            Card(shape: .circle, number: 11),

            // Cross
            Card(shape: .cross, number: 1),
            Card(shape: .cross, number: 2),
            Card(shape: .cross, number: 6),
            Card(shape: .cross, number: 10),
            Card(shape: .cross, number: 11),

            // Star
            Card(shape: .star, number: 1),
            Card(shape: .star, number: 2),
            Card(shape: .star, number: 6),
            Card(shape: .star, number: 10),
            Card(shape: .star, number: 14),

            // Special
            Card(shape: .special, number: 14),
            Card(shape: .special, number: 14),
            Card(shape: .special, number: 14),
            Card(shape: .special, number: 14)
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
