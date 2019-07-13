//
//  ProfileController.swift
//  popmovies
//
//  Created by Tiago Silva on 10/04/2019.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import UIKit

// MARK:

class ProfileController: BaseViewController {
    
    // MARK: Constants
    
    let ProfileHeaderCell                   = R.nib.profileHeaderCell.name
    let ProfileHeaderCellIdentifier         = "ProfileHeaderCellIdentifier"
    
    let ProfileFavoriteCell                 = R.nib.profileFavoriteCell.name
    let ProfileFavoriteCellIdentifier       = "ProfileFavoriteCellIdentifier"
    
    let ProfileWantToSeeCell                = R.nib.profileWantToSeeCell.name
    let ProfileWantToSeeCellIdentifier      = "ProfileWantToSeeIdentifier"
    
    let ProfileWatchedCell                  = R.nib.profileWatchedCell.name
    let ProfileWatchedCellIdentifier        = "ProfileWatchedCellIdentifier"
    
    // MARK: Outlets
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var signOutButton: UIButton!
    
    // MARK: Properties
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return style
    }
    
    var style: UIStatusBarStyle = .lightContent
    var presenter: ProfilePresenterInterface?
    var user: UserLocal?
}

// MARK: Lifecycle Methods

extension ProfileController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.presenter?.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.presenter?.viewDidLoad()
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        self.presenter?.viewDidDisappear(animated)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        var offset = scrollView.contentOffset.y / 180
        let color = UIColor(white: 1.0 - offset, alpha: 1.0)
        let imageColor = UIColor(white: offset, alpha: 1.0)
        
        if offset > 1 {
            offset = 1
            
            updateStatusBarStyle(offset: offset, barStyle: .default)
        } else {
            updateStatusBarStyle(offset: offset, barStyle: .black)
        }
        
        updateButtonStyle(signOutButton, color, imageColor)
    }
    
    private func updateStatusBarStyle(offset: CGFloat, barStyle: UIBarStyle) {
        
        if (offset > 0.3) {
            self.style = .default
        } else {
            self.style = .lightContent
        }
        
        setNeedsStatusBarAppearanceUpdate()
    }
    
    private func updateButtonStyle(_ button: UIButton, _ backgroundColor: UIColor, _ imageColor: UIColor) {
        
        button.backgroundColor = backgroundColor
        button.imageView?.setImageColorBy(uiColor: imageColor)
    }
    
}

// MARK: ProfileViewInterface - Setup Methods

extension ProfileController: ProfileViewInterface {
    
    func setupUI() {
        signOutButton.layer.cornerRadius = signOutButton.bounds.width / 2
        
        setupTableView()
    }
    
    func setupTableView() {
        setupScreenTableView(tableView: tableView)
        
        tableView.contentInset = UIEdgeInsets(top: 240, left: 0, bottom: 100, right: 0)

        tableView.configureNibs(nibName: ProfileHeaderCell, identifier: ProfileHeaderCellIdentifier)
        tableView.configureNibs(nibName: ProfileFavoriteCell, identifier: ProfileFavoriteCellIdentifier)
        tableView.configureNibs(nibName: ProfileWantToSeeCell, identifier: ProfileWantToSeeCellIdentifier)
        tableView.configureNibs(nibName: ProfileWatchedCell, identifier: ProfileWatchedCellIdentifier)
        
        tableView.reloadData()
    }
    
    func setupProfileUI(with user: UserLocal) {
        self.user = user
        
        tableView.reloadData()
    }
}

// MARK: UITableViewDelegate, UITableViewDataSource

extension ProfileController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            return setupProfileHeader(tableView, cellForRowAt: indexPath)
        case 1:
            return setupProfileFavorite(tableView, cellForRowAt: indexPath)
        case 2:
            return setupProfileWantToSee(tableView, cellForRowAt: indexPath)
        case 3:
            return setupProfileWatched(tableView, cellForRowAt: indexPath)
        default:
            return UITableViewCell()
        }
    }
    
    private func setupProfileHeader(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProfileHeaderCellIdentifier) as? ProfileHeaderCell else {
            return UITableViewCell()
        }
        
        if (self.user != nil) { cell.user = self.user }
        
        return cell
    }
    
    private func setupProfileFavorite(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProfileFavoriteCellIdentifier) as? ProfileFavoriteCell else {
            return UITableViewCell()
        }
        
        return cell
    }
    
    private func setupProfileWantToSee(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProfileWantToSeeCellIdentifier) as? ProfileWantToSeeCell else {
            return UITableViewCell()
        }
        
        return cell
    }
    
    private func setupProfileWatched(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProfileWatchedCellIdentifier) as? ProfileWatchedCell else {
            return UITableViewCell()
        }
        
        return cell
    }
}

extension ProfileController {
    
    @IBAction func didSingUpClicked(_ sender: Any) {
        presenter?.didSingUpClicked()
    }
}
