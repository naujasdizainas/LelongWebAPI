angular.module('LelongApi.app.home')
    .controller('homeCtrl',
        function ($scope, $http) {
            var self = this;
            $scope.listGoods = null;
            $scope.username = "VoiCoi84";
            $scope.password = "123456";
            $scope.init = function () {
                var url = "/api/goods/getAll";
                
                var header = {
                    "Authorization": "Bearer 123",
                    "X-User-Context": "test1",
                    "Accept": "application/json"
                }
                $http.get(url, { headers: header }).then(function (response) {
                    $scope.listGoods = response.data;
                }, function (err) {
                });
            }

        });