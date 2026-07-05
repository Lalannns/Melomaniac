//
//  AddAlbumView.swift
//  Melomaniac
//
//  Created by Allan Auezkhan on 29.05.2026.
//

import CoreData
import SwiftUI

struct AddAlbumView: View {
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    
    @State private var title = ""
    @State private var author = ""
    @State private var genre = "Pop"
    @State private var rating = 3
    @State private var review = ""
    
    let genres = ["Pop","Rock","Hip-hop","R&B","Jazz","Classical"]
    
    
    var body: some View {
        Form{
            Section{
                TextField("Name of Album", text: $title)
                TextField("Name of Author", text: $author)
                
                Picker("Pick genre", selection: $genre) {
                    ForEach(genres, id: \.self){
                        Text($0)
                    }
                    
                }
            }
            Section {
                TextEditor(text: $review)
                RatingView(rating: $rating)
            } header:{
                Text("Write a review")
            }
            Section{
                Button("Save"){
                    let addAlbum = Album(context: moc)
                    addAlbum.id = UUID()
                    addAlbum.author = author
                    addAlbum.title = title
                    addAlbum.genre = genre
                    addAlbum.rating = Int16(rating)
                    addAlbum.review = review
                    
                    
                    try? moc.save()
                    dismiss()
                }
            }
            .navigationTitle("Add Album")
        }
    }
}

#Preview {
    ContentView()
}
