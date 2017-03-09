angular.module('LelongApi.app.home').controller('homeCtrl',
        function ($scope, $http, $window) {
            $scope.listGoods = null;
            $scope.username = "VoiCoi84";
            $scope.password = "123456";
            $scope.listCategory = '';
            $scope.defaultCategory = [
              { id: 1, name: "Phone & Tablet" },
              { id: 2, name: "Electronics & Appliances" },
              { id: 3, name: "Fasion" },
              { id: 4, name: "Beauty & Personal Care" },
              { id: 5, name: "Toys & Games" },
              { id: 6, name: "Watches, Pens & Clocks" },
              { id: 7, name: "Gifts & Premiums" },
              { id: 8, name: "Home & Gardening" },
              { id: 9, name: "Sports & Recreation" },
              { id: 10, name: "Books & Comics" }
            ];
            $scope.init = function () {
                var url = "/api/goods/getAll";
                
                var header = {
                    "Authorization": "Bearer 123",
                    "X-User-Context": "test1",
                    "Accept": "application/json"
                }
                $http.get(url, { headers: header }).then(function (response) {
                    $scope.listGoods = response.data;

                    $scope.listGoods.forEach(function (item) {
                        if (item.Category != undefined && item.Category.length > 0 && item.Category != "0") {
                            var lstCate = [];
                            var split = item.Category.split(";");
                            for (var i = 0; i < split.length; i++) {
                                for (var j=0;j<$scope.defaultCategory.length; j++){
                                    if (split[i] == $scope.defaultCategory[j].id.toString()) {
                                        lstCate.push($scope.defaultCategory[j].name);
                                        break;
                                    }
                                }
                            }
                            item.Category = lstCate != undefined ? lstCate.join(';') : $scope.goodItem[i].Category;
                        }
                        else
                        {
                            item.Category = '';
                        }
                        if (item.listPhoto != undefined && item.listPhoto.length > 0) {
                            item.PhotoUrl = item.listPhoto[0].PhotoUrl;
                        }
                    });
                }, function (err) {
                });
            }
            $scope.editObj = function(id)
            {
                $window.location.href = '../Home/detail.html?GoodPublishId=' + id;
            }
            $scope.addObj = function()
            {
                $window.location.href = '../Home/detail.html';
            }
            $scope.delObj = function (id, name) {
                var IsConf = confirm('You are about to delete ' + name + '. Are you sure?');
                if (IsConf) {

                    var url = "/api/goods/deleteGoods/?guid=" + id;

                    var header = {
                        "Authorization": "Bearer 123",
                        "X-User-Context": "test1",
                        "Accept": "application/json"
                    }
                    $http.delete(url, { headers: header })
                   .success(function (data, status, headers, config) {
                        $scope.init();
                   })
                   .error(function (data, status, headers, config) {
                       console.log($scope.message);
                   });
                }
            };
        });

