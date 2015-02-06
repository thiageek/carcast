 angular.module('starter.services', [])

.factory('Audios', function() {
  // Might use a resource here that returns a JSON array

  // Some fake testing data
  var audios = [{
    id: 0,
    title: 'Nerdcast Empreendedor 01',
    subtitle: 'O valor de uma ideia',
    author: 'Jovem Nerd',
    image: 'img/debug/jn.jpg',
    category: 'podcast'
  }, {
    id: 1,
    title: 'Geração de Valor',
    subtitle: 'Compartilhando inspiração',
    author: 'Flávio Augusto',
    image: 'img/debug/gv.jpg',
    category: 'audiobook'
  }];

  return {
    all: function() {
      return audios;
    },
    remove: function(audio) {
      audios.splice(audios.indexOf(audio), 1);
    },
    get: function(audioId) {
      for (var i = 0; i < audios.length; i++) {
        if (audios[i].id === parseInt(audioId)) {
          return audios[i];
        }
      }
      return null;
    }
  }
})

/**
 * A simple example service that returns some data.
 */
.factory('Friends', function() {
  // Might use a resource here that returns a JSON array

  // Some fake testing data
  var friends = [{
    id: 0,
    name: 'Ben Sparrow',
    notes: 'Enjoys drawing things',
    face: 'https://pbs.twimg.com/profile_images/514549811765211136/9SgAuHeY.png'
  }, {
    id: 1,
    name: 'Max Lynx',
    notes: 'Odd obsession with everything',
    face: 'https://avatars3.githubusercontent.com/u/11214?v=3&s=460'
  }, {
    id: 2,
    name: 'Andrew Jostlen',
    notes: 'Wears a sweet leather Jacket. I\'m a bit jealous',
    face: 'https://pbs.twimg.com/profile_images/491274378181488640/Tti0fFVJ.jpeg'
  }, {
    id: 3,
    name: 'Adam Bradleyson',
    notes: 'I think he needs to buy a boat',
    face: 'https://pbs.twimg.com/profile_images/479090794058379264/84TKj_qa.jpeg'
  }, {
    id: 4,
    name: 'Perry Governor',
    notes: 'Just the nicest guy',
    face: 'https://pbs.twimg.com/profile_images/491995398135767040/ie2Z_V6e.jpeg'
  }];


  return {
    all: function() {
      return friends;
    },
    get: function(friendId) {
      // Simple index lookup
      return friends[friendId];
    }
  }
})

/**
 * A simple example service that returns some data.
 */
.factory('Categories', function() {
  // Might use a resource here that returns a JSON array

  // Some fake testing data
  var categories = [{
    id: 0,
    name: 'All',
    icon: 'ion-grid'
  }, {
    id: 1,
    name: 'Podcasts',
    icon: 'ion-headphone'
  }, {
    id: 2,
    name: 'Audio Books',
    icon: 'ion-android-book'
  }];


  return {
    all: function() {
      return categories;
    },
    get: function(categoryId) {
      // Simple index lookup
      return categories[categoryId];
    }
  }
});
