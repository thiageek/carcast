angular.module('starter.controllers', [])

.controller('DashCtrl', function($scope) {
  var success = function(message) {
      alert(message);
  };

  var failure = function() {
      alert("Error calling Hello Plugin");
  };

  document.addEventListener("deviceready", onDeviceReady, false);
  function onDeviceReady() {
    console.log('typeof fordapplink: ' + typeof fordapplink);
    if (fordapplink) {
      console.log('has fordapplink');
      // console.log('fordapplink methods:');
      // for(var p in fordapplink) {
      //   console.log('typeof '+ p +': '+ typeof fordapplink[p]);
          
      // }


      // var success = function(message) {
      //     alert(message);
      // };

      // var failure = function() {
      //     alert("Error calling Hello Plugin");
      // };
    // :)
//      fordapplink.greet('OHHHH YEAHHH!', success, failure);
        fordapplink.setupProxy();
    } else {
      alert('FordAppLink plugin not found.');
    }

  }

  // FordAppLinkPlugin.greet("World", success, failure);
})

.controller('AudiosCtrl', function($scope, Audios) {
  $scope.audios = Audios.all();
  $scope.remove = function(audio) {
    Audios.remove(audio);
  }
})

.controller('AudioDetailCtrl', function($scope, $stateParams, Audios) {
  $scope.audio = Audios.get($stateParams.audioId);
})

.controller('CategoriesCtrl', function($scope, Categories) {
  $scope.categories = Categories.all();
})

.controller('CategoryDetailCtrl', function($scope, $stateParams, Categories) {
  $scope.category = Categories.get($stateParams.categoryId);
})

.controller('AccountCtrl', function($scope) {
  $scope.settings = {
    enableCategories: true
  };
});
