abstract class BaseApiServices{

  Future<dynamic> getGetApiResponse(String url); //abstract methode

  Future<dynamic> getPostApiResponse(String url, dynamic data);

}