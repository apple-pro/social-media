//
//  PostDashboard.swift
//  SocialMedia
//
//  Created by StartupBuilder.INFO on 10/13/20.
//

import SwiftUI

struct Timeline: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \PendingPost.createdAt, ascending: false)],
        animation: .default)
    private var pendingPosts: FetchedResults<PendingPost>
    
    var body: some View {
        
        NavigationView {
            ScrollView {
                
                WhatsOnYourMind(messageComposedHandler: { message in
                    addItem(message: message)
                })
                
                
                LazyVStack {
                    
                    ForEach(pendingPosts) { pendingPost in
                        NavigationLink(destination: Text(pendingPost.text!)) {
                            PendingPostInTimeline(pendingPost: pendingPost)
                        }
                    }
                    .onDelete(perform: deleteItems)
                }.padding()
                
            }
            .navigationTitle("Timeline")
            .navigationBarItems(trailing:
                                    HStack {
                                        Button(action: {}, label: {
                                            Image(systemName: "magnifyingglass.circle.fill")
                                        })
                                        
                                        Button(action: {}, label: {
                                            Image(systemName: "message.circle.fill")
                                        })
                                    }
            )
        }
    }
    
    private func addItem(message: String) {
        withAnimation {
            let newItem = PendingPost(context: viewContext)
            newItem.createdAt = Date()
            newItem.id = UUID.init()
            newItem.text = message
            newItem.commentCount = Int16.random(in: 1..<100)
            
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { pendingPosts[$0] }.forEach(viewContext.delete)
            
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

struct WhatsOnYourMind: View {
    
    @State var message = ""
    let messageComposedHandler: (String) -> Void
    
    var body: some View {
        
        VStack {
            HStack {
                Text("LB")
                    .font(.title)
                    .foregroundColor(Color.white)
                    .padding()
                    .background(Color.accentColor)
                    .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                
                
                TextField("Whats on your mind?", text: $message, onCommit: {
                    messageComposedHandler(message)
                    message = ""
                })
            }
            .padding()
            
            Divider()
            
            HStack {
                
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    Image(systemName: "video.fill")
                    Text("Live")
                })
                .frame(maxWidth: .infinity)
                .accentColor(Color("videoRed"))
                
                Divider()
                
                Button(action: {}, label: {
                    Image(systemName: "photo.fill")
                    Text("Photo")
                })
                .frame(maxWidth: .infinity)
                .accentColor(Color("photoGreen"))
                
                Divider()
                
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    Image(systemName: "face.smiling")
                    Text("Activity")
                })
                .frame(maxWidth: .infinity)
                .accentColor(Color("activityYellow"))
                
            }
            .padding()
        }
        
    }
}

struct PendingPostInTimeline: View {
    
    let pendingPost: PendingPost
    
    var body: some View {
        HStack(alignment: .top) {
            
            Text("LB")
                .font(.title)
                .foregroundColor(Color.white)
                .padding()
                .background(Color.accentColor)
                .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                .frame(width: 70, height: 70, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            
            VStack {
                Text(pendingPost.text!)
                    .font(.headline).fontWeight(.heavy)
                    .frame(maxWidth: .infinity)
                
                
                Text("Created On: \(pendingPost.createdAt!, formatter: itemFormatter)")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            
        }
        .padding()
        .overlay(Capsule(style: .continuous).stroke(Color.accentColor, style: StrokeStyle(lineWidth: 5, dash: [10])))
    }
}


//TODO: remove once useless
private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct PostDashboard_Previews: PreviewProvider {
    static var previews: some View {
        Timeline()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
