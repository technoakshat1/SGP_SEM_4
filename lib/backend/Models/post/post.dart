enum Categories { ALL, BREAKFAST, BRUNCH, LUNCH, HIGH_TEA, DINNER }
enum Filters {
  ALL,
  VEG,
  NON_VEG,
  JAIN,
  DIET,
  PROBIOTIC,
  LOW_SALT,
  FESTIVE,
  FASTING
}

class Post {
  String id;
  String title;
  String username;
  String caption;
  List<Categories> category;
  List<Filters> filter;
  String time;
  String costOfIngredients;
  int noOfPersons;
  List ingredients;
  List steps;
  bool comment;
  List images;
  List videos;
  DateTime dateTime;

  void parseAndInflatePost(Map<String, dynamic> response) {
    id=response['_id'];
    title = response['title'];
    username = response['userId'];
    caption = response['caption'];
    category=_mapCategoriesToArray(response['categories']);
    //print(category);
    filter=_mapFilterstoArray(response['filters']);
    time=response['time'];
    costOfIngredients=response['CookingInfo']['cost'];
    noOfPersons=response['CookingInfo']['persons'];
    ingredients=response['CookingInfo']['ingredients'];
    steps=response['Method']['steps'];
    comment=response['comment'];
    images=response['media']['images'];
    videos=response['media']['videos'];
    dateTime=DateTime.parse(response['dateTime']);
  }

  dynamic _mapFilterstoArray(List filters){
    List<Filters> processedFilters=List.empty(growable: true);
    for(int i=0;i<filters.length;i++){
      switch(filters[i]){
        case 'All':
          processedFilters.add(Filters.ALL);
          break;
        case 'Veg':
          processedFilters.add(Filters.VEG);
          break;
        case 'Non_Veg':
          processedFilters.add(Filters.NON_VEG);
          break;
        case 'Jain':
         processedFilters.add(Filters.JAIN);
          break;
        case 'Diet':
         processedFilters.add(Filters.DIET);
         break;
        case 'Probiotic':
         processedFilters.add(Filters.PROBIOTIC);
         break;
        case 'Low_Salt':
         processedFilters.add(Filters.LOW_SALT);
         break;
        case 'Fasting':
          processedFilters.add(Filters.FASTING);
          break;
        case 'Festive':
          processedFilters.add(Filters.FESTIVE);
          break;
      }
    }
    return processedFilters;
  }

  dynamic _mapCategoriesToArray(List categories) {
    List<Categories> processedCat=List.empty(growable: true);
    for (int i = 0; i < categories.length; i++) {
      switch (categories[i]) {
        case 'All':
          processedCat.add(Categories.ALL);
          break;
        case 'Breakfast':
          processedCat.add(Categories.BREAKFAST);
          break;
        case 'Lunch':
          processedCat.add(Categories.LUNCH);
          break;
        case 'Brunch':
          processedCat.add(Categories.BRUNCH);
          break;
        case 'High_Tea':
          processedCat.add(Categories.HIGH_TEA);
          break;
        case 'Dinner':
          processedCat.add(Categories.DINNER);
          break;
      }
    }
    return processedCat;
  }

  @override
  String toString() {
      return title+" "+category.toString()+" "+filter.toString()+" "+dateTime.toLocal().toString();
   }
}
