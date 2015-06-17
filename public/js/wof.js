function read_cookie(key)
{
    var result;
    return (result = new RegExp('(?:^|; )' + encodeURIComponent(key) + '=([^;]*)').exec(document.cookie)) ? (result[1]) : null;
}

var user_id = read_cookie('user_id');

var viewModel = {
    username: ko.observable(),
    email: ko.observable(),
    description: ko.observable()
}

ko.applyBindings(viewModel);

$.getJSON("/users/" + user_id + "/", function(result) {
    viewModel.username(result.username);
    viewModel.email(result.email);
})