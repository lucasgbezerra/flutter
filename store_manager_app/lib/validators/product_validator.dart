class ProductValidator {
  String? validateImages(List? images) {
    if (images == null || images.isEmpty) return "Add image to product.";
    return null;
  }

  String? validateTitle(String? title) {
    if (title == null || title.isEmpty) return "Title field is required.";
    return null;
  }

  String? validateDescription(String? description) {
    if (description == null || description.isEmpty) {
      return "Description field is required.";
    }
    return null;
  }

  String? validatePrice(String? price) {
    if (price == null || price.isEmpty) {
      return "Price field is required.";
    } else if (!price.contains(".") || price.split(".")[1].length != 2) {
      return "Invalid price.";
    }
    return null;
  }

  String? validateSizes(List? sizes) {
    if (sizes == null || sizes.isEmpty) return "Add size to product";
    return null;
  }
}
