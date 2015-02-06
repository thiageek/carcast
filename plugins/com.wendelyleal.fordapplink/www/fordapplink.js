/*global cordova, module*/
module.exports = {
    greet: function (name, successCallback, errorCallback) {
        console.log('exec("FordAppLink")');
        cordova.exec(successCallback, errorCallback, "FordAppLink", "greet", ['(FordAppLink) ' + name]);
    },
	setupProxy: function (name, successCallback, errorCallback) {
	   console.log('setupProxy, exec("FordAppLink")');
	   cordova.exec(null, null, "FordAppLink", "setupProxy", ['(FordAppLink setupProxy) ' + name]);
	}
};
