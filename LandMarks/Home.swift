//
//  Home.swift
//  LandMarks
//
//  Created by Hanlin Chen on 8/31/20.
//  Copyright © 2020 Hanlin Chen. All rights reserved.
//

import SwiftUI

struct CategoryHome: View {
    var categories:[String:[Landmark]]{
        Dictionary(
            grouping: landmarkData, by: {
                $0.category.rawValue
        })
    }
    var featured:[Landmark]{
        landmarkData.filter{$0.isFeatured}
    }
    @State var showUserProfile:Bool = false
    var profileButton: some View {
        Button(action: { self.showUserProfile.toggle() }) {
            Image(systemName: "person.crop.circle")
                .imageScale(.large)
                .accessibility(label: Text("User Profile"))
                .padding()
        }
    }
    var body: some View {
        NavigationView{
            List{
                FeaturedLandmarks(landmarks: featured).scaledToFill().frame(height:200).clipped().listRowInsets(EdgeInsets())
                ForEach(categories.keys.sorted(), id:\.self){ key in
                    CategoryRow(categoryName: key, items: self.categories[key]!)
                }.listRowInsets(EdgeInsets())
                NavigationLink(destination: LandmarkList()) {
                    Text("See All")
                }
            }.navigationBarTitle(Text("Featured"))
            .navigationBarItems(trailing: profileButton)
            .sheet(isPresented: $showUserProfile){
                Text("User Profile")
            }
        }
    }
}



struct FeaturedLandmarks: View{
    var landmarks: [Landmark]
    var body: some View {
        landmarks[0].image.resizable()
    }
}

struct CategoryHome_Previews: PreviewProvider {
    static var previews: some View {
        CategoryHome()
    }
}