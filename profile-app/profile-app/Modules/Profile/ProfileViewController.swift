//
//  ViewController.swift
//  profile-app
//
//  Created by Марина Рябчун on 01.08.2023.
//

import UIKit

protocol ProfileViewProtocol {
    var skill: String? { get set}
}

class ProfileViewController: UIViewController {
    
    private var viewModel: ProfileViewModelProtocol = ProfileViewModel()


    // MARK: - Properties
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Properties contentHeaderView
    private lazy var contentHeaderView: UIView = {
        let view = UIView()
        view.backgroundColor = Constants.Colors.backgroundColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var blockImage: UIImageView = {
        let image = UIImage(named: Constants.Image.defaultPhoto)
        let view = UIImageView(image: image)
        view.contentMode = .scaleAspectFill
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = Constants.Colors.basicColor
        label.font = Constants.Fonts.header
        label.textAlignment = .center
        label.numberOfLines = -1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var labelDescription: UILabel = {
        let label = UILabel()
        label.textColor = Constants.Colors.descriptionColor
        label.font = Constants.Fonts.text
        label.textAlignment = .center
        label.numberOfLines = -1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var locationStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 2
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(iconLocation)
        stackView.addArrangedSubview(labelLocation)
        return stackView
    }()
    public lazy var iconLocation: UIImageView = {
        let image = UIImage(named: Constants.Image.iconLocation)
        let imageStar = UIImageView(image: image)
        imageStar.contentMode = .scaleAspectFill
        imageStar.translatesAutoresizingMaskIntoConstraints = false
        return imageStar
    }()
    private lazy var labelLocation: UILabel = {
        let label = UILabel()
        label.textColor = Constants.Colors.descriptionColor
        label.font = Constants.Fonts.text
        label.textAlignment = .center
        label.numberOfLines = -1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    // MARK: - Properties contentSkillsView
    private lazy var titleSkills: UILabel = {
        let label = UILabel()
        label.textColor = Constants.Colors.basicColor
        label.font = Constants.Fonts.subTitle
        label.text = "Мои навыки"
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    public lazy var addSkillButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "plus"),
                        for: .normal)
        button.addTarget(self, action: #selector(onAddSkillButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    public lazy var editButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: Constants.Image.iconPencil),
                        for: .normal)
        button.addTarget(self, action: #selector(onEditButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    public lazy var saveButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: Constants.Image.iconСheckMark),
                        for: .normal)
        button.addTarget(self, action: #selector(onSaveButton), for: .touchUpInside)
        button.isHidden = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 5
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    // MARK: - Properties contentResumeSummaryView
    private lazy var titleResumeSummary: UILabel = {
        let label = UILabel()
        label.textColor = Constants.Colors.basicColor
        label.font = Constants.Fonts.subTitle
        label.text = "О себе"
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var descriptionResumeSummary: UILabel = {
        let label = UILabel()
        label.textColor = Constants.Colors.basicColor
        label.font = Constants.Fonts.text
        label.textAlignment = .left
        label.numberOfLines = -1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    // MARK: - LifeCicle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupNavigationBar()
        setupView()
        setupConstraints()
        setUpCollectionView()
        configure(model: Person.example)
        
        viewModel.skills.bind { [weak self] _ in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
    }
    // MARK: - Private methods
    @objc
    private func onEditButton()  {
        editButton.isHidden = true
        collectionView.isHidden = false
        print("tapEditButton")
        saveButton.isHidden = false
    }
    
    @objc
    private func onAddSkillButton() {
        let ac = UIAlertController(title: "Добавление навыка",
                                   message: "Введите название навыка которым вы владеете",
                                   preferredStyle: .alert)
        ac.addTextField()
        
        let submitAction = UIAlertAction(title: "Добавить", style: .default) { [weak ac] _ in
            
            guard let textField = ac?.textFields?[0], let text = textField.text else { return }
            self.viewModel.addSkill(text)
        }
        
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel)
        
        ac.addAction(cancelAction)
        ac.addAction(submitAction)
        
        present(ac, animated: true)
    }

    @objc
    private func onSaveButton() {
        saveButton.isHidden = true
        print("tapEditButton")
        editButton.isHidden = false
    }
    
    private var isEditingMode = false {
        didSet {
            collectionView.reloadData()
        }
    }
}

// MARK: - Extension
extension ProfileViewController {
    private func configure(model: Person) {
        blockImage.image = UIImage(named: model.photo ?? Constants.Image.defaultPhoto)
        titleLabel.text = model.name
        labelDescription.text = model.description
        labelLocation.text = model.location
        descriptionResumeSummary.text = model.resumeSummary
    }
    private func setupNavigationBar() {
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: Constants.Colors.basicColor ?? .black
        ]
        navigationController?.navigationBar.titleTextAttributes = attributes
        title = "Профиль"
    }
    
    private func setupView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(contentHeaderView)
        
        contentHeaderView.addSubview(blockImage)
        contentHeaderView.addSubview(titleLabel)
        contentHeaderView.addSubview(labelDescription)
        contentHeaderView.addSubview(locationStackView)
        
        contentView.addSubview(titleSkills)
        contentView.addSubview(editButton)
        contentView.addSubview(saveButton)
        contentView.addSubview(addSkillButton)
        contentView.addSubview(collectionView)
        
        contentView.addSubview(titleResumeSummary)
        contentView.addSubview(descriptionResumeSummary)
    }
    
    private func setUpCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(SkillsCollectionViewCell.self, forCellWithReuseIdentifier: "SkillsCollectionViewCell")
    }
    
    @objc private func editButtonTapped() {
        isEditingMode.toggle()
        collectionView.reloadData()
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        let heightConstraint = contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        heightConstraint.priority = UILayoutPriority(250)
        
        NSLayoutConstraint.activate([
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
        contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
        contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
          heightConstraint,
        ])
        
        NSLayoutConstraint.activate([
            contentHeaderView.heightAnchor.constraint(equalToConstant: 290),
            contentHeaderView.topAnchor.constraint(equalTo: contentView.topAnchor),
            contentHeaderView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            contentHeaderView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            blockImage.topAnchor.constraint(equalTo: contentHeaderView.topAnchor, constant: 24),
            blockImage.centerXAnchor.constraint(equalTo: contentHeaderView.centerXAnchor),
            blockImage.widthAnchor.constraint(equalToConstant: 120),
            blockImage.heightAnchor.constraint(equalToConstant: 120),
            
            titleLabel.topAnchor.constraint(equalTo: blockImage.bottomAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: contentHeaderView.leadingAnchor, constant: 35),
            titleLabel.trailingAnchor.constraint(equalTo: contentHeaderView.trailingAnchor, constant: -35),
            
            labelDescription.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            labelDescription.leadingAnchor.constraint(equalTo: contentHeaderView.leadingAnchor, constant: 35),
            labelDescription.trailingAnchor.constraint(equalTo: contentHeaderView.trailingAnchor, constant: -35),
            
            locationStackView.topAnchor.constraint(equalTo: labelDescription.bottomAnchor, constant: 8),
            locationStackView.centerXAnchor.constraint(equalTo: contentHeaderView.centerXAnchor),
            locationStackView.bottomAnchor.constraint(equalTo: contentHeaderView.bottomAnchor,constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            titleSkills.topAnchor.constraint(equalTo: contentHeaderView.bottomAnchor, constant: 24),
            titleSkills.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleSkills.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -48),
            
            editButton.topAnchor.constraint(equalTo: contentHeaderView.bottomAnchor, constant: 24),
            editButton.leadingAnchor.constraint(equalTo: titleSkills.trailingAnchor, constant: 8),
            editButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            editButton.centerYAnchor.constraint(equalTo: titleSkills.centerYAnchor),
            editButton.widthAnchor.constraint(equalToConstant: 24),
            editButton.heightAnchor.constraint(equalToConstant: 24),
            
            addSkillButton.topAnchor.constraint(equalTo: contentHeaderView.bottomAnchor, constant: 24),
            addSkillButton.leadingAnchor.constraint(equalTo: titleSkills.trailingAnchor, constant: 8),
            addSkillButton.trailingAnchor.constraint(equalTo: editButton.leadingAnchor, constant: -8),
            addSkillButton.widthAnchor.constraint(equalToConstant: 24),
            addSkillButton.heightAnchor.constraint(equalToConstant: 24),
            
            saveButton.topAnchor.constraint(equalTo: contentHeaderView.bottomAnchor, constant: 24),
            saveButton.leadingAnchor.constraint(equalTo: titleSkills.trailingAnchor, constant: 8),
            saveButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            editButton.centerYAnchor.constraint(equalTo: titleSkills.centerYAnchor),
            saveButton.widthAnchor.constraint(equalToConstant: 24),
            saveButton.heightAnchor.constraint(equalToConstant: 24),
            
            collectionView.topAnchor.constraint(equalTo: titleSkills.bottomAnchor, constant: 10),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            collectionView.heightAnchor.constraint(equalToConstant: 200)
        ])
        
        NSLayoutConstraint.activate([
            titleResumeSummary.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 24),
            titleResumeSummary.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleResumeSummary.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

            descriptionResumeSummary.topAnchor.constraint(equalTo: titleResumeSummary.bottomAnchor, constant: 8),
            descriptionResumeSummary.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            descriptionResumeSummary.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension ProfileViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.skills.value?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SkillsCollectionViewCell", for: indexPath) as! SkillsCollectionViewCell
        cell.configure(with: viewModel.skills.value?[indexPath.item] ?? "")
        cell.isEditing = isEditingMode
        cell.deleteButtonHandler = { [weak self] in
            self?.viewModel.skills.value?.remove(at: indexPath.item)
            self?.collectionView.deleteItems(at: [indexPath])
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let skill = viewModel.skills.value?[indexPath.item]
        var size: CGSize = CGSize(width: 50, height: 40)
        if !isEditingMode {
            size = skill?.size(withAttributes: [.font: UIFont.systemFont(ofSize: 16)]) ?? size
        } else {
            size = skill?.size(withAttributes: [.font: UIFont.systemFont(ofSize: 16)]) ?? size
            size.width += 30
        }
        return CGSize(width: size.width + 50,  height: size.height + 30)
    }
}


// MARK: - SwiftUI for Preview

import SwiftUI
struct MainProvider: PreviewProvider {
    static var previews = ConteinerView()
    
    struct ConteinerView: UIViewControllerRepresentable {
        typealias UIViewControllerType = UINavigationController
        
        func makeUIViewController(context: Context) -> UINavigationController {
            let vc = ProfileViewController()
            let navController = UINavigationController(rootViewController: vc)
            return navController
        }
        
        func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {
        }
    }
}

