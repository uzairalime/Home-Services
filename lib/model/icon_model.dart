class ServiceIconModel {
  final String? title;
  final String? icon;
  ServiceIconModel(this.title, this.icon);

  static List<ServiceIconModel> servicesicon = [
    ServiceIconModel("Cleaning", "assets/icons/cleaning.svg"),
    ServiceIconModel("Painting", "assets/icons/painting.svg"),
    ServiceIconModel("Tailor", "assets/icons/tailor.svg"),
    ServiceIconModel("Handyman", "assets/icons/handyman.svg"),
    ServiceIconModel("Pest Control", "assets/icons/pestControl.svg"),
    ServiceIconModel("Women Salon", "assets/icons/womenSalon.svg"),
    ServiceIconModel("Spa", "assets/icons/spa.svg"),
    ServiceIconModel("Men Salon", "assets/icons/menSalon.svg"),
    ServiceIconModel("Electricity", "assets/icons/electricity.svg"),
    ServiceIconModel("Plumbing", "assets/icons/plumbing.svg"),
    ServiceIconModel("Ac Repair", "assets/icons/acRepair.svg"),
  ];
}
