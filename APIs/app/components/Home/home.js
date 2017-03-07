angular.module('LelongApi.app.home')
    .controller('homeCtrl',
        function ($scope, $http, $window) {
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
                    $http.delete('/Home/Delete/' + custModel.Id)
                   .success(function (data, status, headers, config) {
                       if (data.success === true) {
                           $scope.message = name + ' deleted from record!!';
                           $scope.result = "color-green";
                           $scope.init();
                           console.log(data);
                       }
                       else {
                           $scope.message = 'Error on deleting Record!';
                           $scope.result = "color-red";
                       }
                   })
                   .error(function (data, status, headers, config) {
                       $scope.message = 'Unexpected Error while deleting data!!';
                       $scope.result = "color-red";
                       console.log($scope.message);
                   });
                }
            };
        });