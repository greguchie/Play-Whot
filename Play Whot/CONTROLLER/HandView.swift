//
//  HandView.swift
//  Play Whot
//
//  Created by Kensei on 2026-02-09.
//

import UIKit

class HandView: UIView {
    
    //var handHidden: Bool = true
    
    // MARK: - UI Containers
    private let scrollView = UIScrollView()
    private let contentView = UIView()

    // MARK: - Card Storage
    private var cardImageViews: [UIImageView] = []
    private(set) var selectedCard: UIImageView?

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    private func setup() {
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.alwaysBounceHorizontal = true
        scrollView.clipsToBounds = false

        contentView.clipsToBounds = false

        addSubview(scrollView)
        scrollView.addSubview(contentView)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        scrollView.frame = bounds
    }
    
    
    func show(cards: [Card]) {

        // Remove old cards
        cardImageViews.forEach { $0.removeFromSuperview() }
        cardImageViews.removeAll()
        selectedCard = nil

        let cardWidth: CGFloat = 80
        let cardHeight: CGFloat = 120
        let overlap: CGFloat = 60   // Controls how much cards overlap

        let totalWidth = CGFloat(cards.count - 1) * overlap + cardWidth

        for (index, card) in cards.enumerated() {

            let x = CGFloat(index) * overlap

            let imageView = UIImageView(frame: CGRect(
                x: x,
                y: bounds.height - cardHeight,
                width: cardWidth,
                height: cardHeight
            ))

            imageView.image = UIImage(named: "\(card.shape)\(card.number)")
            imageView.contentMode = .scaleAspectFit
            imageView.isUserInteractionEnabled = true

            imageView.layer.cornerRadius = 8
            imageView.layer.shadowOpacity = 0.3
            imageView.layer.shadowRadius = 6
            imageView.layer.shadowOffset = CGSize(width: 0, height: 2)
            imageView.layer.shadowColor = UIColor.black.cgColor

            let tap = UITapGestureRecognizer(target: self, action: #selector(cardTapped(_:)))
            imageView.addGestureRecognizer(tap)

            contentView.addSubview(imageView)
            cardImageViews.append(imageView)
        }

        contentView.frame = CGRect(
            x: 0,
            y: 0,
            width: max(totalWidth, bounds.width),
            height: bounds.height
        )

        scrollView.contentSize = contentView.frame.size
    }

    // MARK: - Selection

    @objc private func cardTapped(_ sender: UITapGestureRecognizer) {
        guard let cardView = sender.view as? UIImageView else { return }

        // Deselect previous
        if let previous = selectedCard, previous != cardView {
            UIView.animate(withDuration: 0.15) {
                previous.transform = .identity
            }
        }

        // Toggle selection
        if selectedCard == cardView {
            UIView.animate(withDuration: 0.15) {
                cardView.transform = .identity
            }
            selectedCard = nil
            return
        }

        selectedCard = cardView
        contentView.bringSubviewToFront(cardView)

        UIView.animate(withDuration: 0.2) {
            cardView.transform = CGAffineTransform(translationX: 0, y: -20)
        }

        // Optional: auto-scroll selected card into view
        scrollView.scrollRectToVisible(
            cardView.frame.insetBy(dx: -50, dy: 0),
            animated: true
        )
    }
    
    func getSelectedCard(from cards: [Card]) -> Card? {
        guard let selected = selectedCard,
              let index = cardImageViews.firstIndex(of: selected),
              index < cards.count else {
            return nil
        }

        return cards[index]
    }
}

extension UIColor {
    convenience init?(hex: String) {
        let r, g, b, a: CGFloat
        
        var hexColor = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        if hexColor.hasPrefix("#") {
            hexColor = String(hexColor.dropFirst())
        }
        
        let scanner = Scanner(string: hexColor)
        var hexNumber: UInt64 = 0
        
        guard scanner.scanHexInt64(&hexNumber) else { return nil }
        
        switch hexColor.count {
        case 6: // RGB (24-bit)
            r = CGFloat((hexNumber & 0xff0000) >> 16) / 255
            g = CGFloat((hexNumber & 0x00ff00) >> 8) / 255
            b = CGFloat(hexNumber & 0x0000ff) / 255
            a = 1.0
        case 8: // ARGB or RGBA (32-bit)
            r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
            g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
            b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
            a = CGFloat(hexNumber & 0x000000ff) / 255
        default:
            return nil
        }
        
        self.init(red: r, green: g, blue: b, alpha: a)
    }
}
