//
//  MovieListContract.swift
//  popmovies
//
//  Created by Tiago Silva on 24/06/19.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import UIKit
import RxSwift

protocol MovieListViewInterface: BaseViewInterface {
    var presenter: MovieListPresenterInterface? { get set }
    
    func showMovies(with movies: [Movie])
    func stopInfiniteScroll()
}

protocol MovieListPresenterInterface: BasePresenterInterface {
    
    var view: MovieListViewInterface? { get set }
    var interactor: MovieListInteractorInputInterface? { get set }
    var wireframe: MovieListWireframeInterface? { get set }
    
    func fetchMovies()
    func didSelectMovie(_ movie: Movie)
    func didSearchClicked()
}

protocol MovieListInteractorInputInterface: BaseInteractorInterface {
    var output: MovieListInteractorOutputInterface? { get set }
    
    func fetchMovies(from url: String,with parameters: [String : String ])
}

protocol MovieListInteractorOutputInterface {
    
    func moviesDidFetch(_ movies: [Movie], totalPages: Int)
    func moviesDidError(_ error: DefaultError)
}

protocol MovieListWireframeInterface: BaseWireframeInterface {
    
    func presentDetails(for movie: Movie)
    func presentSearch()
    
    static func buildModule(url: String, parameters: [String : String], title: String) -> UIViewController
    static func buildModule(with movies: [Movie], title: String) -> UIViewController
    static func buildModuleFromUINavigation(with movies: [Movie], title: String) -> UIViewController
    static func buildModuleFromUINavigation(url: String, parameters: [String : String], title: String) -> UIViewController 
    static func buildModule() -> UIViewController
}
