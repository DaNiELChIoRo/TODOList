//
//  Notifications.swift
//  push_notifications_app
//
//  Created by Daniel.Meneses on 5/23/19.
//  Copyright © 2019 Daniel.Meneses. All rights reserved.
//

import Foundation
import UIKit
import UserNotifications

class UserNotificationService: NSObject {

    private override init () {}
    static let shared = UserNotificationService()
    //Creamos una instancia del centro de notificaciones para el registro de norificaciones
    let userNotificationCenter  = UNUserNotificationCenter.current()
    
    //MARK:- Configuration Methods
    func authorize() {
        //Creamos un arreglo con las caracteristicas que tendrán nuestras alertas
        let options: UNAuthorizationOptions = [.alert, .badge, .sound, .carPlay]
        userNotificationCenter.requestAuthorization(options: options) { (granted, error) in
            if (error != nil){
                print(error ?? "Error in the authorization process")
            }
            else{
                //verificamos sí el usuario a concedido los permisos para las notificaciones
                guard granted else {
                    print("USER DENIED ACCESS ")
                    return
                }
                //configuramos al servicio de notificaciones. Para poder configurar una respuesta ante los diferentes eventos del ciclo de vida de las notificaciones dentro de la aplicación
                self.configure()
            }
            
        }
    }
    
    func configure(){
        userNotificationCenter.delegate = self
    }
    
    func defaultNotificationRequest(id: Int64, title:String, body:String, sound: UNNotificationSound, category: NotificationCategory, trigger: UNNotificationTrigger) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = sound
        content.categoryIdentifier = category.rawValue
        
        let request = UNNotificationRequest(identifier: "userNotification." + category.rawValue + "\(id)", content: content, trigger: trigger)
        
        userNotificationCenter.add(request, withCompletionHandler: nil)
    }
    
    func removeNotification(identifier: String) {
        userNotificationCenter.removePendingNotificationRequests(withIdentifiers: ["userNotification.category.date." + identifier])
    }
}


extension UserNotificationService: UNUserNotificationCenterDelegate {
    //Administramos la respuesta cuando se haya recibido una notificación en el dispositivo de la aplicación
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print("UN did receive response")
        
        completionHandler()
    }
    
    //Administramos la respuesta cuando se presente una notificación de la aplicación
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        print("UN will present")
        
        let options: UNNotificationPresentationOptions = [.alert, .sound]
        completionHandler(options)
    }
    
}
