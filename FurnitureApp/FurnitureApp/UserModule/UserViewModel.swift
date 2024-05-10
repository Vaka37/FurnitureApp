//
//  UserViewModel.swift
//  FurnitureApp
//
//

import Foundation

/// Модель для настроек Юзера

struct UserSettings: Identifiable, Hashable {
    let id = UUID()
    
    let title: String
    
    let icon: String
    
    let notification: Int?
}

/// Вью модель для Юзера
final class UserViewModel: ObservableObject {
    public let userSettings: [UserSettings] = [.init(title: "Sity", icon: "envelope", notification: 3),
                                               .init(title: "Notification", icon: "bell", notification: 4),
                                               .init(title: "Accounts Details", icon: "person", notification: nil),
                                               .init(title: "My purchases", icon: "basket.fill", notification: nil),
                                               .init(title: "Settings", icon: "gearshape", notification: nil)]
}
