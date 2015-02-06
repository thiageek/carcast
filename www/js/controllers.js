angular.module('starter.controllers', [])

.controller('DashCtrl', function($scope) {})

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
