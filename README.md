

Features:

 -Responsive design for mobile.
 -Get Categories and products of the api


Code declaration:


   In this project, the MVC architecture pattern is  used and
Bloc state management is used.
   There are three main folders.They are the presentation,repositories,controller .
   The first folder is presentation.It contains dashboard folder.In this folder ,the main dashboard screen is used to navigate the body as 5 pages.This process is controlled by dashboard controller. This controller emits  integer 0 to 5 to change the current state of bottom navigation bar and  the builder of pageview.The event is added by the method called activate that adds various events on Bloc.
    The Discover page's Ui is designed by Figma design. 
    The categories are fetched by the categorylistbloc.The bloc used CategoryRepo that contains a method called getallcategory,it fetches the the list of category.As the api only returns the list of String,the images of the categories are mapped in the categoryMap.Thes url  images are chosen by the name of categories.
   The product can be chosen  by the  Category . This process is handled by the controller called product_list_bloc .The first product list must be all products. The custom products by the category are fetched in the product service class  .In the product service class,there are two main methods called getAllproducts and getproductbycategory.The first method fetches all products.The second fetches by the category so that it requires the category name.They are handled by the product_list_bloc.The list of products can be sorted by the two button called the lowest price first and the highest price first.Tapping on these button are controlled by the two event called arrangeproductbylowestprice and arrangeproductbyhighestprice .By getting these events, the list is sorted by the requirements and is emitted the new list as fetchproductloadedstate.The two valueNotifiers  called islowestpricefirst and  ishighestpricefirst control  the color of the buttons.The "isselected" ValueNotifier controls the ui of category items when user choice.
    The  service classes and controllers are returned as the Result class .It contains data and general error.The data can be any type.The general error must be message and stack Trace.The message is used to show the user when there is an error on fetching or other.The stack Trace for developer.The data is used to show for ui of various methods.
    The get_it is used for registering a singleton for the instance of the service classes.
     