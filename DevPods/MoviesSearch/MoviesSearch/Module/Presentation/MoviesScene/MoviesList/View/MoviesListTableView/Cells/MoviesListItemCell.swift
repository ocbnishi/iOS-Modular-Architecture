//
//  MoviesListItemCell.swift
//  App
//
//  Created by Oleh Kudinov on 01.10.18.
//

import UIKit

final class MoviesListItemCell: UITableViewCell {
    
    static let reuseIdentifier = String(describing: MoviesListItemCell.self)
    static let height = CGFloat(130)
    
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var dateLabel: UILabel!
    @IBOutlet private var overviewLabel: UILabel!
    @IBOutlet private var posterImageView: UIImageView!
    
    private var viewModel: MoviesListItemViewModel! { didSet { unbind(from: oldValue) } }
    
    func fill(with viewModel: MoviesListItemViewModel) {
        self.viewModel = viewModel
        titleLabel.text = viewModel.title
        dateLabel.text = viewModel.releaseDate
        overviewLabel.text = viewModel.overview
        viewModel.updatePosterImage(width: Int(posterImageView.frame.size.width * UIScreen.main.scale))
        
        bind(to: viewModel)
    }
    
    private func bind(to viewModel: MoviesListItemViewModel) {
        viewModel.posterImage.observe(on: self) { [weak self] in self?.posterImageView.image = $0.flatMap { UIImage(data: $0) } }
    }
    
    private func unbind(from item: MoviesListItemViewModel?) {
        item?.posterImage.remove(observer: self)
    }
}
