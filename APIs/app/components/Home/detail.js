angular.module('LelongApi.app.home')
    .controller('detailCtrl',
        function ($scope, $http, $window) {
            $scope.goodPublishId = '';
            $scope.goodItem = {};
            $scope.hasError = false;
            $scope.isNew = true;
            $scope.username = "VoiCoi84";
            $scope.password = "123456";
            $scope.initdetail = function () {
                if ($scope.goodPublishId != undefined || $scope.goodPublishId != '') {
                    $scope.isNew = false;
                }
                $scope.defaultCategory = [
               { value: 1, name: "Phone & Tablet"},
               { value: 2, name: "Electronics & Appliances"},
               { value: 3, name: "Fasion" },
               { value: 4, name: "Beauty & Personal Care" },
               { value: 5, name: "Toys & Games" },
               { value: 6, name: "Watches, Pens & Clocks"},
               { value: 7, name: "Gifts & Premiums"},
               { value: 8, name: "Home & Gardening"},
               { value: 9, name: "Sports & Recreation"},
               { value: 10, name: "Books & Comics"}
                ];

                $scope.goodPublishId = $scope.getUrlVars()["GoodPublishId"];
                
                if ($scope.goodPublishId != undefined) {
                    var url = "/api/goods/selectById/?goodId=" + $scope.goodPublishId;

                    var header = {
                        "Authorization": "Bearer 123",
                        "X-User-Context": "test1",
                        "Accept": "application/json"
                    }
                    $http.get(url, { headers: header }).then(function (response) {
                        
                        $scope.goodItem = response.data;
                        
                    }, function (err) {
                    });
                }
                else {
                    //doing else
                }               
            }
            $scope.showPopup = function () {
                if (!$scope.isNew) {
                    if ($scope.goodItem.Category.length > 0) {
                        var items = response[0].Category.split(",");
                        for (var i = 0; i <= items.length - 1; i++) {
                            $scope.defaultCategory[items[i]] = true;
                        }
                    }
                }
            }
            $scope.goBack = function () {
                window.location.href = '../Home/home.html';
            };
            $scope.save = function () {
                var item = $scope.goodItem;
                var url = "/api/goods/saveGoods/?goodsItem=" + $scope.goodItem;

                var header = {
                    'Content-type': 'application/json',
                    "Authorization": "Bearer 123",
                    "X-User-Context": "test1",
                    "Accept": "application/json"
                }
                
                $http.post(url, $scope.goodItem, { headers: header }).then(function (response) {

                    $scope.goBack();

                }, function (err) {
                });

            };
            $scope.getUrlVars = function () {
                var vars = {};
                var parts = window.location.href.replace(/[?&]+([^=&]+)=([^&]*)/gi,
                function (m, key, value) {
                    vars[key] = value;
                });
                return vars;
            };
            
        });