import UIKit

class AddRecipeViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate {
    
    weak var delegate: AddRecipeDelegate?
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    
    // Kullanıcıya gösterilecek resim; başlangıçta placeholder simge
    let recipeImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "photo")
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.isUserInteractionEnabled = true  // Dokunmaya izin ver
        return iv
    }()
    
    // Tarif başlığı için
    let titleTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Recipe Title"
        tf.borderStyle = .roundedRect
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    // Malzemeler için text view, placeholder metin ile birlikte ve rengi gray
    let ingredientsTextView: UITextView = {
        let tv = UITextView()
        tv.layer.borderColor = UIColor.gray.cgColor
        tv.layer.borderWidth = 1.0
        tv.layer.cornerRadius = 5.0
        tv.font = UIFont.systemFont(ofSize: 16)
        tv.text = "Enter ingredients here, e.g. 2 eggs, 1 cup flour, etc."
        tv.textColor = UIColor.gray
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    // Talimatlar için text view, placeholder metin ile birlikte ve rengi gray
    let instructionsTextView: UITextView = {
        let tv = UITextView()
        tv.layer.borderColor = UIColor.gray.cgColor
        tv.layer.borderWidth = 1.0
        tv.layer.cornerRadius = 5.0
        tv.font = UIFont.systemFont(ofSize: 16)
        tv.text = "Enter cooking instructions here, e.g. Preheat oven, mix ingredients, etc."
        tv.textColor = UIColor.gray
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    // Tarifin kaydedilmesini sağlayan buton
    let saveButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Save Recipe", for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Add Recipe"
        
        // UITextViewDelegate için ayarlama
        ingredientsTextView.delegate = self
        instructionsTextView.delegate = self
        
        setupUI()
    }
    
    func setupUI() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        
        contentView.addSubview(recipeImageView)
        contentView.addSubview(titleTextField)
        contentView.addSubview(ingredientsTextView)
        contentView.addSubview(instructionsTextView)
        contentView.addSubview(saveButton)
        
        // Resim seçimi için Gesture Recognizer
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        recipeImageView.addGestureRecognizer(tapGesture)
        
        NSLayoutConstraint.activate([
            recipeImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            recipeImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            recipeImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            recipeImageView.heightAnchor.constraint(equalToConstant: 200),
            
            titleTextField.topAnchor.constraint(equalTo: recipeImageView.bottomAnchor, constant: 20),
            titleTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            titleTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            titleTextField.heightAnchor.constraint(equalToConstant: 40),
            
            ingredientsTextView.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 20),
            ingredientsTextView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            ingredientsTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            ingredientsTextView.heightAnchor.constraint(equalToConstant: 100),
            
            instructionsTextView.topAnchor.constraint(equalTo: ingredientsTextView.bottomAnchor, constant: 20),
            instructionsTextView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            instructionsTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            instructionsTextView.heightAnchor.constraint(equalToConstant: 150),
            
            saveButton.topAnchor.constraint(equalTo: instructionsTextView.bottomAnchor, constant: 20),
            saveButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            saveButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
        
        saveButton.addTarget(self, action: #selector(saveRecipe), for: .touchUpInside)
    }
    
    // MARK: - Image Picker İşlemleri
    @objc func imageTapped() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        present(picker, animated: true, completion: nil)
    }
    
    // MARK: - Tarif Kaydetme
    @objc func saveRecipe() {
        guard let title = titleTextField.text, !title.isEmpty else {
            showAlert(message: "Please enter a recipe title.")
            return
        }
        let ingredients = (ingredientsTextView.textColor == UIColor.gray) ? "" : ingredientsTextView.text ?? ""
        let instructions = (instructionsTextView.textColor == UIColor.gray) ? "" : instructionsTextView.text ?? ""
        let image = recipeImageView.image
        
        let recipe = UserRecipeModel(id: UUID().uuidString,
                                     title: title,
                                     ingredients: ingredients,
                                     instructions: instructions,
                                     image: image)
        
        delegate?.didAddRecipe(recipe)
        navigationController?.popViewController(animated: true)
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: - UIImagePickerControllerDelegate ve UINavigationControllerDelegate
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.originalImage] as? UIImage {
            recipeImageView.image = selectedImage
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - UITextViewDelegate Metotları
    func textViewDidBeginEditing(_ textView: UITextView) {
        // Eğer placeholder metin görünüyorsa temizle ve siyah yap.
        if textView.textColor == UIColor.gray {
            textView.text = ""
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        // Eğer kullanıcı hiçbir şey yazmamışsa, ilgili placeholder metni geri yükle.
        if textView.text.isEmpty {
            if textView == ingredientsTextView {
                textView.text = "Enter ingredients here, e.g. 2 eggs, 1 cup flour, etc."
            } else if textView == instructionsTextView {
                textView.text = "Enter cooking instructions here, e.g. Preheat oven, mix ingredients, etc."
            }
            textView.textColor = UIColor.gray
        }
    }
    
    // Eğer kullanıcı herhangi bir tuşa bastığında placeholder metni temizleme
    func textView(_ textView: UITextView,
                  shouldChangeTextIn range: NSRange,
                  replacementText text: String) -> Bool {
        if textView.textColor == UIColor.gray {
            textView.text = ""
            textView.textColor = UIColor.black
        }
        return true
    }
}
