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

.controller('ChatsCtrl', function($scope, Chats) {
  $scope.chats = Chats.all();
  $scope.remove = function(chat) {
    Chats.remove(chat);
  };
})

.controller('ChatDetailCtrl', function($scope, $stateParams, Chats) {
  $scope.chat = Chats.get($stateParams.chatId);
})

.controller('FriendsCtrl', function($scope, Friends) {
  $scope.friends = Friends.all();
})

.controller('FriendDetailCtrl', function($scope, $stateParams, Friends) {
  $scope.friend = Friends.get($stateParams.friendId);
})

.controller('AccountCtrl', function($scope) {
  $scope.settings = {
    enableFriends: true
  };
});
