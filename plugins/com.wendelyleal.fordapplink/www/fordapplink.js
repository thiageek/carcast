/*global cordova, module*/
module.exports = {
    greet: function (name, successCallback, errorCallback) {
        console.log('exec("FordAppLink")');
        cordova.exec(successCallback, errorCallback, "FordAppLink", "greet", ['(FordAppLink) ' + name]);
    }
};
