


class Player {
    // a player will always have a hand, array of cards struct
    var name: String
    var hand: [Card]

    init(name: String, hand: [Card]) {
        self.name = name
        self.hand = hand
    }

    // winner is whose hand is empty during gameplay
    var hasWon: Bool {
        return hand.isEmpty
    }
}
