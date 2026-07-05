//
//  ContentView.swift
//  Melomaniac
//
//  Created by Allan Auezkhan on 29.05.2026.
//

import CoreData
import SwiftUI

struct ContentView: View {
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [
        SortDescriptor(\.title),
        SortDescriptor(\.author)
    ]) var albums: FetchedResults<Album>
    
    @State private var showingAddScreen = false
    
//Добавил класс сюда

    class AlbumActionHandler: DetailViewDelegate {
        func detailView(_ detailView: DetailView, didDeleteAlbum album: Album) {
            print("🔊 Delegate initialized successfully '\(album.title ?? "")' was deleted.")
        }
    }
    
    let actionHandler = AlbumActionHandler()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(albums) { album in
                    NavigationLink {
                        //Добавил делегат сюда
                        DetailView(album: album, delegate: actionHandler)
                    } label: {
                        HStack {
                            EmojiRatingView(rating: album.rating)
                                .font(.largeTitle)
                            VStack(alignment: .leading) {
                                Text(album.title ?? "Unknown Title")
                                    .font(.headline)
                                Text(album.author ?? "Unknown Author")
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Melomaniac")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingAddScreen.toggle()
                    } label: {
                        Label("add album", systemImage: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddScreen) {
                AddAlbumView()
            }
        }
    }
    
    func DeleteBooks(at offsets: IndexSet) {
        for offset in offsets {
            let album = albums[offset]
            moc.delete(album)
        }
        try? moc.save()
    }
}

#Preview {
    ContentView()
}
