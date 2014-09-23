
function checkUser(){
	var username = document.getElementById("usernameBox").value;
	var password = document.getElementById("passwordBox").value;
	window.location.replace("/users/auth?username=" + username + "&" + "password" + "=" +password);
}