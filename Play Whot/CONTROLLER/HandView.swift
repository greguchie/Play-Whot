//
//  HandView.swift
//  Play Whot
//
//  Created by Kensei on 2026-02-09.
//

import UIKit

class HandView: UIView {
    private var cardImageViews: [UIImageView] = []
    private weak var selectedCard: UIImageView?
    
    
    func show(images: [UIImage]) {
        // Remove old cards
        cardImageViews.forEach { $0.removeFromSuperview() }
        cardImageViews.removeAll()
        
        let cardWidth: CGFloat = 80
        let cardHeight: CGFloat = 120
        
        
        // MARK: - determining whether to space cards or overlay
        let totalCardWidth = CGFloat(images.count) * cardWidth
        let availableWidth = bounds.width
        
        let spacing: CGFloat
        let overlap: CGFloat
        
        //space cards
        if totalCardWidth <= availableWidth {
            // Cards fit — spread them evenly
            spacing = (availableWidth - totalCardWidth) / CGFloat(images.count + 1)
            overlap = cardWidth + spacing
        }
        //overlay
        else {
            // Cards don’t fit — overlap
            spacing = 0
            overlap = (availableWidth - cardWidth) / CGFloat(images.count - 1)
        }
        
        
        
        // MARK: - structuring image programatically
        for (index, image) in images.enumerated() {
            //position of each card(x) depending on available space
            let x: CGFloat = totalCardWidth <= availableWidth
            ? spacing + CGFloat(index) * (cardWidth + spacing)
            : CGFloat(index) * overlap
            
            
            //someImageView with our calculated x positioning, y=boundary height
            let imageView = UIImageView(frame: CGRect(
                x: x,
                y: bounds.height - cardHeight,
                width: cardWidth,
                height: cardHeight
            ))
            
            
            //still iterating through images array
            imageView.image = image
            imageView.contentMode = .scaleAspectFit
            imageView.isUserInteractionEnabled = true
            
            imageView.layer.cornerRadius = 8
            imageView.layer.shadowOpacity = 0.3
            imageView.layer.shadowRadius = 6
            imageView.layer.shadowOffset = CGSize(width: 0, height: 2)
            imageView.layer.shadowColor = UIColor.black.cgColor
            
            let tap = UITapGestureRecognizer(target: self, action: #selector(cardTapped(_:)))
            imageView.addGestureRecognizer(tap)
            
            addSubview(imageView)
            cardImageViews.append(imageView)
        }
    }
    
   
    @objc private func cardTapped(_ sender: UITapGestureRecognizer) {
        guard let card = sender.view as? UIImageView else { return }

        // Deselect previous
        if let previous = selectedCard, previous != card {
            UIView.animate(withDuration: 0.15) {
                previous.transform = .identity
            }
        }

        // Select new
        selectedCard = card
        bringSubviewToFront(card)

        UIView.animate(withDuration: 0.2) {
            card.transform = CGAffineTransform(translationX: 0, y: -20)
        }
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
