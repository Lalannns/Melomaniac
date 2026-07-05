//
//  DetailView.swift
//  Melomaniac
//
//  Created by Allan Auezkhan on 29.05.2026.
//
import CoreData
import SwiftUI

protocol DetailViewDelegate: AnyObject {
    func detailView(_ detailView: DetailView, didDeleteAlbum album: Album)
}

struct DetailView: View {
    let album: Album

    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    @State private var showingDeleteAlert = false
    weak var delegate: DetailViewDelegate?
    
    
    var body: some View {
        ScrollView {
            ZStack(alignment: .bottomTrailing) {
                
                if let genreName = album.genre, !genreName.isEmpty {
                    Image(genreName)
                        .resizable()
                        .scaledToFit()
                } else {
                    Image(systemName: "music.note.list")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 200)
                        .foregroundColor(.secondary)
                        .padding()
                }
                
                Text(album.genre?.uppercased() ?? "POP")
                    .font(.caption)
                    .fontWeight(.black)
                    .padding(8)
                    .foregroundColor(.white)
                    .background(.black.opacity(0.75))
                    .offset(x: -5, y: -5)
            }
            
            VStack(alignment: .leading, spacing: 10) {
                Text(album.author ?? "Unknown Author")
                    .font(.title)
                    .foregroundColor(.secondary)
                
                Divider()
                
                Text(album.review ?? "No review provided.")
                    .padding(.vertical)
                
                HStack {
                    Spacer()
                    
                    RatingView(rating: .constant(Int(album.rating)))
                        .font(.largeTitle)
                    Spacer()
                }
            }
            .padding()
        }
        .navigationTitle(album.title ?? "Unknown Album")
        .navigationBarTitleDisplayMode(.inline)
        .alert("Delete Album", isPresented: $showingDeleteAlert) {
            Button("Delete", role: .destructive, action: deleteAlbum)
            Button("Cancel", role: .cancel) { }
        } message: {
            Text("Are you sure you want to delete this album permanently?")
        }
        .toolbar {
            Button {
                showingDeleteAlert = true
            } label: {
                Label("Delete this album", systemImage: "trash")
            }
        }
    }
    
    func deleteAlbum() {
            delegate?.detailView(self, didDeleteAlbum: album)
            
            moc.delete(album)
            try? moc.save()
            dismiss()
        }
}

// MARK: - Canvas Preview Setup
#Preview {
    
    let container = NSPersistentContainer(name: "Melomaniac")
    container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
    container.loadPersistentStores { _, _ in }
    
    let exampleAlbum = Album(context: container.viewContext)
    exampleAlbum.id = UUID()
    exampleAlbum.title = "Graduation"
    exampleAlbum.author = "Kanye West"
    exampleAlbum.genre = "Hip-hop"
    exampleAlbum.rating = 5
    exampleAlbum.review = "An absolute classic with amazing production values and timeless tracks."
    
    return NavigationStack {
        DetailView(album: exampleAlbum)
            .environment(\.managedObjectContext, container.viewContext)
    }
}
