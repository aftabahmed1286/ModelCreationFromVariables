# ModelCreationFromVariables

Do you have a large model file to be created with the json response? Here it is a simple mac app where in you can paste your json response key value pairs like the one's below and obtain the model created for you. You just have to paste the output into you swift file.

Input in the TextView: 

"key1": "value1",
"key2": "value2"

Output in the TextView:

class Model: Codable {


      /**************************************************
      Properties
      **************************************************/
      var key1: String?
      var key2: String?
      var key3”: String?


      /**************************************************
      CodingKeys for Codable
      **************************************************/
      enum CodingKeys: String, CodingKey {
            case key1
            case key2
            case key3”
      }


}

You can chose to have the encoder/decoder functions or the model to be a class or struct(by default).



