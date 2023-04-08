//
//  ContentView.swift
//  ActivityViewSwiftUI
//
//  Created by sss on 08.04.2023.
//

import SwiftUI

class ActivityViewCustomActivity: UIActivity {
    
    //MARK: - Properties
    var customActivityType: UIActivity.ActivityType
    var activityName: String
    var activityImageName: String
    var customActionWhenTapped: () -> Void
    
    //MARK: - Init
    init(title: String, imageName: String, performAction: @escaping () -> Void) {
        self.customActivityType = UIActivity.ActivityType("Action \(title)")
        self.activityName = title
        self.activityImageName = imageName
        self.customActionWhenTapped = performAction
        super.init()
    }
    
    //MARK: - Ovrerrides
    override var activityType: UIActivity.ActivityType? {
        return customActivityType
    }
    override var activityTitle: String?{
        return activityName
    }
    override class var activityCategory: UIActivity.Category {
        return .share
    }
    
    override var activityImage: UIImage? {
        return UIImage(named: activityImageName)
    }
    
    override func canPerform(withActivityItems activityItems: [Any]) -> Bool {
        return true
    }
    override func prepare(withActivityItems activityItems: [Any]) {
        //
    }
    override func perform() {
        customActionWhenTapped()
    }
}



struct ContentView: View {
    
    @State private var isSharedPresented = false
    let customActivity = ActivityViewCustomActivity(title: "IB", imageName: "image1") {
        print("Do")
    }
    
    var body: some View {
        VStack {
            Button {
                isSharedPresented = true
            } label: {
                Text("Press")
            }.sheet(isPresented: $isSharedPresented) {
                ActivityView(activityItems: ["message test"], aplicationActivities: [customActivity])
            }

        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
