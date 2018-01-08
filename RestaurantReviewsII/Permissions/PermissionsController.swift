//
//  Permissions.swift
//  RestaurantReviewsII
//
//  Created by Jeff Ripke on 12/21/17.
//  Copyright © 2017 Jeff Ripke. All rights reserved.
//

import UIKit
import OAuth2
import CoreLocation

class PermissionsController: UIViewController, LocationPermissionsDelegate {
    
    let oauth = OAuth2ClientCredentials(settings: [
        "client_id": "33k7tJE1767ON7Ta0E_p6Q",
        "client_secret": "2Kf4pGaWXDc4sPz52xPaWole3c1mDTfyID5iqEBGfmLxth6YOQN5637SVIKo4laq",
        "authorize_uri": "https://api.yelp.com/oauth2/token",
        "secret_in_body": true,
        "keychain": false
        ])
    
    lazy var locationManager: LocationManager = {
        return LocationManager(permissionsDelegate: self)
    }()
    
    var isAuthorizedForLocation: Bool
    var isAuthenticatedWithToken: Bool
    
    lazy var locationPermissionButton: UIButton = {
        let title = self.isAuthorizedForLocation ? "Location Permissions Granted" : "Request Location Permissions"
        let button = UIButton(type: .system)
        let controlState = self.isAuthorizedForLocation ? UIControlState.disabled : UIControlState.normal
        button.isEnabled = !self.isAuthorizedForLocation
        button.setTitle(title, for: controlState)
        button.addTarget(self, action: #selector(PermissionsController.requestLocationPermissions), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(red: 62/255.0, green: 71/255.0, blue: 79/255.0, alpha: 1.0)
        button.setTitleColor(UIColor(red: 178/255.0, green: 187/255.0, blue: 185/255.0, alpha: 1.0), for: .disabled)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        return button
    }()
    
    lazy var oauthTokenButton: UIButton = {
        let title = self.isAuthenticatedWithToken ? "OAuth Token Granted" : "Request OAuth token"
        let button = UIButton(type: .system)
        let controlState = self.isAuthorizedForLocation ? UIControlState.disabled : UIControlState.normal
        button.isEnabled = !self.isAuthenticatedWithToken
        button.setTitle(title, for: controlState)
        button.addTarget(self, action: #selector(PermissionsController.requestOAuthToken), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(red: 62/255.0, green: 71/255.0, blue: 79/255.0, alpha: 1.0)
        button.setTitleColor(UIColor(red: 178/255.0, green: 187/255.0, blue: 185/255.0, alpha: 1.0), for: .disabled)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        return button
    }()
    
    lazy var dismissButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Dismiss", for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(PermissionsController.dismissPermissions), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init coder not implemented")
    }
    
    init(isAuthorizedForLocation authorized: Bool, isAuthenticateWithToken authenticated: Bool) {
        self.isAuthorizedForLocation = authorized
        self.isAuthenticatedWithToken = authenticated
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 95/255.0, green: 207/255.0, blue: 128/255.0, alpha: 1.0)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        let stackView = UIStackView(arrangedSubviews: [locationPermissionButton, oauthTokenButton])
        stackView.alignment = .center
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 16.0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        view.addSubview(dismissButton)
        NSLayoutConstraint.activate([
            locationPermissionButton.heightAnchor.constraint(equalToConstant: 64.0),
            locationPermissionButton.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            locationPermissionButton.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            oauthTokenButton.heightAnchor.constraint(equalToConstant: 64.0),
            oauthTokenButton.leadingAnchor.constraint(equalTo: stackView.trailingAnchor),
            oauthTokenButton.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32.0),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32.0),
            dismissButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16),
            dismissButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    @objc func requestLocationPermissions() {
        do {
            try locationManager.requestLocationAuthorization()
        } catch LocationError.disallowedByUser {
            // show alert to users
        } catch LocationError.unableToFindLocation {
            
        } catch LocationError.unkownError {
            
        } catch let error {
            print("Location Authorization Error: \(error.localizedDescription)")
        }
    }
    
    @objc func requestOAuthToken() {
        oauth.authorize { authParams, error in
            if let params = authParams {
                guard let token = params["access_token"] as? String, let expiration = params["expires_in"] as? TimeInterval else { return }
                let account = YelpAccount(accessToken: token, expiration: expiration, grantDate: Date())
                do {
                    try? account.save()
                    self.oauthTokenButton.setTitle("OAuth Token Granted", for: .disabled)
                    self.oauthTokenButton.isEnabled = false
                }
            } else {
                print("Authorization was cancelled or went wrong: \(error!)")
            }
        }
    }
    
    @objc func dismissPermissions() {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: Location Permissions Delegate
    func authorizationSucceeded() {
        locationPermissionButton.setTitle("Location Permissions Granted", for: .disabled)
        locationPermissionButton.isEnabled = false
    }
    
    func authorizationFailedWithStatus(_ status: CLAuthorizationStatus) {
        //
    }
}
