
class Player {
    // a player will always have a hand, array of cards struct
    var hand: [Card]

    init(hand: [Card]) {
        self.hand = hand
    }

    //winner is whose hand is empty during gameplay
    var hasWon: Bool {
        return hand.isEmpty
    }
}
