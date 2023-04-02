extends Node
class_name ValidatedResponse

var is_error: bool
var message: String

static func create_new_validated_response(is_error: bool, message: String) -> ValidatedResponse:
	var validated_response = ValidatedResponse.new()
	validated_response.is_error = is_error
	validated_response.message = message
	
	return validated_response
	
