//
//  ViewController.swift
//  Egg Timer
//
//  Created by Марина on 25.07.2023.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    var counter = 60
    var timer = Timer()
    
    var totalTime = 0
    var secondsPassed = 0
    
    let eggTimes = ["Soft" : 1, "Medium" : 2, "Hard" : 3]
    
    var player: AVAudioPlayer?
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "How do you like your eggs?"
//        label.adjustsFontSizeToFitWidth = true
        label.font = .systemFont(ofSize: 25)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let titleView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let timerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var viewsStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var eggsStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let softEggImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "soft_egg")
        imageView.contentMode = .scaleAspectFit
//        imageView.backgroundColor = .black
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let MediumEggImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "medium_egg")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let HardEggImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "hard_egg")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var SoftButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Soft", for: .normal)
        button.tintColor = .white
        button.titleLabel?.textAlignment = .center
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
//        button.backgroundColor = .green
        return button
    }()
    
    private lazy var MediumButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Medium", for: .normal)
        button.titleLabel?.textAlignment = .center
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var HardButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Hard", for: .normal)
        button.titleLabel?.textAlignment = .center
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()
    
    private let viewSoft: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let viewMedium: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let viewHard: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let progView: UIProgressView = {
        let progressView = UIProgressView(progressViewStyle: .bar)
        progressView.translatesAutoresizingMaskIntoConstraints = false
//        progressView.progress = 0.5
        progressView.progressTintColor = .systemYellow
        progressView.trackTintColor = .systemGray
        return progressView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.4198841155, green: 0.8717851043, blue: 0.9802951217, alpha: 1)
        
        setupView()
        setConstarints()
        
    }
    
    private func configireStack() {
        
        viewsStack.addArrangedSubview(titleView)
        viewsStack.addArrangedSubview(eggsStack)
        viewsStack.addArrangedSubview(timerView)
        
//        timerView.backgroundColor = .red
//        progView.backgroundColor = .yellow
//        viewsStack.backgroundColor = .systemYellow
        
        titleView.addSubview(nameLabel)
        timerView.addSubview(progView)
        
        eggsStack.addArrangedSubview(viewSoft)
        eggsStack.addArrangedSubview(viewMedium)
        eggsStack.addArrangedSubview(viewHard)
        
        viewSoft.addSubview(softEggImage)
        viewMedium.addSubview(MediumEggImage)
        viewHard.addSubview(HardEggImage)

        viewSoft.addSubview(SoftButton)
        viewMedium.addSubview(MediumButton)
        viewHard.addSubview(HardButton)
        
        view.addSubview(viewsStack)

    }
    
    private func setupView() {
        configireStack()
    }
    
    @objc func buttonTapped(_ sender: UIButton) {
        
        timer.invalidate()
        
        let hardness = sender.currentTitle!
        totalTime = eggTimes[hardness]! * 60
        
        progView.progress = 0
        secondsPassed = 0
        nameLabel.text = hardness
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
        }
    func playSound() {
       let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")

        player = try! AVAudioPlayer(contentsOf: url!, fileTypeHint: AVFileType.mp3.rawValue)

        player!.play()

    }
        

        
    @objc private func updateCounter() {
        if secondsPassed < totalTime {
            secondsPassed += 1
            let percentProgress = Float(secondsPassed) / Float(totalTime)
            print(percentProgress)
            progView.progress = percentProgress
        }
        else {
            timer.invalidate()
            nameLabel.text = "Done"
            print("Timer is out")
            playSound()
        }
    }
}
              
extension ViewController {
    private func setConstarints() {
        NSLayoutConstraint.activate([
            
            
            softEggImage.widthAnchor.constraint(equalToConstant: 115),
            softEggImage.heightAnchor.constraint(equalToConstant: 160),
            softEggImage.centerYAnchor.constraint(equalTo: viewSoft.centerYAnchor),
            softEggImage.centerXAnchor.constraint(equalTo: viewSoft.centerXAnchor),
            
            SoftButton.topAnchor.constraint(equalTo: viewSoft.topAnchor),
            SoftButton.leadingAnchor.constraint(equalTo: viewSoft.leadingAnchor),
            SoftButton.trailingAnchor.constraint(equalTo: viewSoft.trailingAnchor),
            SoftButton.bottomAnchor.constraint(equalTo: viewSoft.bottomAnchor),
            
            
            MediumEggImage.widthAnchor.constraint(equalToConstant: 115),
            MediumEggImage.heightAnchor.constraint(equalToConstant: 160),
            MediumEggImage.centerYAnchor.constraint(equalTo: viewMedium.centerYAnchor),
            MediumEggImage.centerXAnchor.constraint(equalTo: viewMedium.centerXAnchor),
            
            MediumButton.topAnchor.constraint(equalTo: viewMedium.topAnchor),
            MediumButton.leadingAnchor.constraint(equalTo: viewMedium.leadingAnchor),
            MediumButton.trailingAnchor.constraint(equalTo: viewMedium.trailingAnchor),
            MediumButton.bottomAnchor.constraint(equalTo: viewMedium.bottomAnchor),
            
        
            HardEggImage.widthAnchor.constraint(equalToConstant: 115),
            HardEggImage.heightAnchor.constraint(equalToConstant: 160),
            HardEggImage.centerYAnchor.constraint(equalTo: viewHard.centerYAnchor),
            HardEggImage.centerXAnchor.constraint(equalTo: viewHard.centerXAnchor),
            
            HardButton.topAnchor.constraint(equalTo: viewHard.topAnchor),
            HardButton.leadingAnchor.constraint(equalTo: viewHard.leadingAnchor),
            HardButton.trailingAnchor.constraint(equalTo: viewHard.trailingAnchor),
            HardButton.bottomAnchor.constraint(equalTo: viewHard.bottomAnchor),
            

            nameLabel.centerYAnchor.constraint(equalTo: titleView.centerYAnchor),
            nameLabel.centerXAnchor.constraint(equalTo: titleView.centerXAnchor),
            
            viewsStack.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            viewsStack.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            viewsStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            viewsStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            progView.leadingAnchor.constraint(equalTo: timerView.leadingAnchor, constant: 10),
            progView.centerXAnchor.constraint(equalTo: timerView.centerXAnchor),
            progView.centerYAnchor.constraint(equalTo: timerView.centerYAnchor),
            progView.trailingAnchor.constraint(equalTo: timerView.trailingAnchor, constant: -10),
            progView.heightAnchor.constraint(equalToConstant: 5)
        ])
    }
}

