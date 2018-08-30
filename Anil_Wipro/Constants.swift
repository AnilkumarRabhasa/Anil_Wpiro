//
//  Constants.swift
//  Anil_Wipro
//
//  Created by iFocus on 28/08/18.
//  Copyright © 2018 Anil_iOS_developer. All rights reserved.
//

import Foundation

struct Constants {
    static let urlString = "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"
}
struct Contact {
    let name:String?
    let jobTitle:String?
}
class ContactAPI {
    static func getContacts() -> [Contact]{
        let contacts = [
            Contact(name: "Kelly Goodwin", jobTitle: "Designer"),
            Contact(name: "Mohammad Hussain", jobTitle: "SEO"),
            Contact(name: "John Young", jobTitle: "Software"),
            Contact(name: "Tamilarasi Mohan", jobTitle: "Architect"),
            Contact(name: "Kim Yu", jobTitle: "Economist"),
            Contact(name: "Derek Fowler", jobTitle: "Web Strategist"),
            Contact(name: "Shreya Nithin", jobTitle: "Product Designer"),
            Contact(name: "Emily Adams", jobTitle: "Editor"),
            Contact(name: "Aabidah Amal", jobTitle: "Creative Director"),
            ]
        return contacts
    }
}
