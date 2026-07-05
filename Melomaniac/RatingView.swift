//
//  RatingView.swift
//  Melomaniac
//
//  Created by Allan Auezkhan on 29.05.2026.
//

import CoreData
import SwiftUI

struct RatingView: View {
    
    @Binding var rating: Int
    
    var label = ""
    var maxRating = 5
    
    var offImage: Image?
    var onImage = Image(systemName: "star.fill")
    
    var offColor = Color.gray
    var onColor = Color.yellow
    
    var body: some View {
        HStack{
            if label.isEmpty == false{
                Text(label)
            }
            
            ForEach(1..<maxRating + 1, id: \.self) { number in
                image(for: number)
                    .foregroundColor(number > rating ? offColor: onColor)
                    .onTapGesture {
                        rating = number
                    }
                
            }
        }
    }
    func image(for number: Int) -> Image {
        if number > rating{
            return offImage ?? onImage
            
        } else {
            return onImage
        }
    }
}

#Preview {
    RatingView(rating:.constant(4))
}
