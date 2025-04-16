import UIKit

class AddRecipeViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate {
    
    weak var delegate: AddRecipeDelegate?

    //view tipini kolayca cast edebilmek için computed property
    private var addRecipeView: AddRecipeView!{
        return self.view as? AddRecipeView
    }
    
    
    override func loadView() {
        // Root view olarak AddRecipeView ata
        view = AddRecipeView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Add Recipe"
        
        // UITextViewDelegate için ayarlama
        addRecipeView.ingredientsTextView.delegate = self
        addRecipeView.instructionsTextView.delegate = self
        
        setupUI()
    }
    
    func setupUI() {

        // Resim seçimi için Gesture Recognizer
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        addRecipeView.recipeImageView.addGestureRecognizer(tapGesture)
        
        NSLayoutConstraint.activate([
           
        ])
        
        addRecipeView.saveButton.addTarget(self, action: #selector(saveRecipe), for: .touchUpInside)
    }
    
//     Image Picker İşlemleri
    @objc func imageTapped() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        present(picker, animated: true, completion: nil)
    }
    
    // Tarif Kaydetme
    @objc func saveRecipe() {
        guard let title = addRecipeView.titleTextField.text, !title.isEmpty else {
            showAlert(message: "Please enter a recipe title.")
            return
        }
        let ingredients = (addRecipeView.ingredientsTextView.textColor == UIColor.gray) ? "" : addRecipeView.ingredientsTextView.text ?? ""
        let instructions = (addRecipeView.instructionsTextView.textColor == UIColor.gray) ? "" : addRecipeView.instructionsTextView.text ?? ""
        let image = addRecipeView.recipeImageView.image
        
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
    
    // UIImagePickerControllerDelegate ve UINavigationControllerDelegate
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.originalImage] as? UIImage {
            addRecipeView.recipeImageView.image = selectedImage
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    // UITextViewDelegate Metotları
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
            if textView == addRecipeView.ingredientsTextView {
                textView.text = "Enter ingredients here, e.g. 2 eggs, 1 cup flour, etc."
            } else if textView == addRecipeView.instructionsTextView {
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
