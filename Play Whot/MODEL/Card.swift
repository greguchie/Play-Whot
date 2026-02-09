

enum Shape: CaseIterable {
    case square
    case circle
    case cross
    case star
    case special
}

struct Card: Equatable {
    var shape: Shape
    var number: Int
}
