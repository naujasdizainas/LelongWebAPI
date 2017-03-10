var appHome = angular.module('LelongApi.app.home')
    .controller('detailCtrl',
        function ($scope, $http, $window) {
            $scope.slides = [];
            $scope.goodPublishId = '';
            $scope.goodItem = {};
            $scope.result = '';
            $scope.message = '';
            $scope.modal_title = '';
            $scope.modal_infor = '';

            $scope.onReadySwiper = function (swiper) {
                swiper.initObservers();
            };

            $scope.initdetail = function () {
                $scope.curLstCategory = [];
                $scope.defaultCategory = [
               { id: 1, name: "Phone & Tablet"},
               { id: 2, name: "Electronics & Appliances"},
               { id: 3, name: "Fasion" },
               { id: 4, name: "Beauty & Personal Care" },
               { id: 5, name: "Toys & Games" },
               { id: 6, name: "Watches, Pens & Clocks" },
               { id: 7, name: "Gifts & Premiums" },
               { id: 8, name: "Home & Gardening" },
               { id: 9, name: "Sports & Recreation" },
               { id: 10, name: "Books & Comics" }
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

                        $scope.slides = $scope.goodItem.listPhoto;

                        if ($scope.goodItem.Category.length > 0) {
                            var split = $scope.goodItem.Category.split(";");
                            for (var i = 0; i < split.length; i++) {
                                for (var j = 0; j < $scope.defaultCategory.length; j++) {
                                    if (split[i] == $scope.defaultCategory[j].id.toString()) {
                                        $scope.curLstCategory.push($scope.defaultCategory[j]);
                                        break;
                                    }
                                }
                            }
                        }                        
                    }, function (err) {
                    });
                }
                else {
                    //doing else
                }               
            }
            
            $scope.goBack = function () {
                window.location.href = '../Home/home.html';
            };
            $scope.IsValid = function () {
                if ($scope.goodItem.Title == undefined || $scope.goodItem.Title.trim() == "") {
                    $scope.result = 'alert alert-danger';
                    $scope.message = "Must be input title for good!";
                    $("#txtTitle").focus();
                    return false;
                }
                if ($scope.goodItem.Condition == undefined || $scope.goodItem.Condition.trim() == "") {
                    $scope.result = 'alert alert-danger';
                    $scope.message = "Must be input condition for good!";
                    $("#txtCondition").focus();                    
                    return false;
                }
                if ($scope.goodItem.Quantity == undefined || $scope.goodItem.Quantity.toString().trim() == "0") {
                    $scope.result = 'alert alert-danger';
                    $scope.message = "Must be input quantity for good!";
                    $("#txtQuantity").focus();
                    return false;
                }
                if ($scope.goodItem.SalePrice == undefined || $scope.goodItem.SalePrice.toString().trim() == "0") {
                    $scope.result = 'alert alert-danger';
                    $scope.message = "Must be input sale price for good!";
                    $("#txtSalePrice").focus();
                    return false;
                }
                return true;
            }
            
            $scope.save = function () {
                if (!$scope.IsValid()) {
                    return 0;
                }

                if ($scope.curLstCategory.length > 0) {
                    var lstCate = [];
                    for (var i = 0; i < $scope.curLstCategory.length; i++) {
                        lstCate.push($scope.curLstCategory[i].id);
                    }
                    $scope.goodItem.Category = lstCate.join(';')
                }
                
                var url = "/api/goods/saveGoods";

                var header = {
                    'Content-type': 'application/json',
                    "Authorization": "Bearer 123",
                    "X-User-Context": "test1",
                    "Accept": "application/json"
                }
                
                $http.post(url, $scope.goodItem, { headers: header }).then(function (response) {
                    $scope.result = 'alert alert-success';
                    $scope.message = $scope.goodItem + "is saved!";
                    $scope.goBack();

                }, function (err) {
                    $scope.result = 'alert alert-danger';
                    $scope.message = err + ": " +  $scope.goodItem + "can't be saved!";
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

appHome.directive('multipleAutocomplete', [
        '$filter',
        '$http',
        function ($filter, $http) {
            return {
                restrict: 'EA',
                scope: {
                    suggestionsArr: '=?',
                    modelArr: '=ngModel',
                    apiUrl: '@',
                    beforeSelectItem: '=?',
                    afterSelectItem: '=?',
                    beforeRemoveItem: '=?',
                    afterRemoveItem: '=?'
                },
                templateUrl: 'multiple-autocomplete-tpl.html',
                link: function (scope, element, attr) {
                    scope.objectProperty = attr.objectProperty;
                    scope.selectedItemIndex = 0;
                    scope.name = attr.name;
                    scope.isRequired = attr.required;
                    scope.errMsgRequired = attr.errMsgRequired;
                    scope.isHover = false;
                    scope.isFocused = false;
                    var getSuggestionsList = function () {
                        var url = scope.apiUrl;
                        $http({
                            method: 'GET',
                            url: url
                        }).then(function (response) {
                            scope.suggestionsArr = response.data;
                        }, function (response) {
                            console.log("*****Angular-multiple-select **** ----- Unable to fetch list");
                        });
                    };

                    if (scope.suggestionsArr == null || scope.suggestionsArr == "") {
                        if (scope.apiUrl != null && scope.apiUrl != "")
                            getSuggestionsList();
                        else {
                            console.log("*****Angular-multiple-select **** ----- Please provide suggestion array list or url");
                        }
                    }

                    if (scope.modelArr == null || scope.modelArr == "") {
                        scope.modelArr = [];
                    }
                    scope.onFocus = function () {
                        scope.isFocused = true
                    };

                    scope.onMouseEnter = function () {
                        scope.isHover = true
                    };

                    scope.onMouseLeave = function () {
                        scope.isHover = false;
                    };

                    scope.onBlur = function () {
                        scope.isFocused = false;
                    };

                    scope.onChange = function () {
                        scope.selectedItemIndex = 0;
                    };

                    scope.keyParser = function ($event) {
                        var keys = {
                            38: 'up',
                            40: 'down',
                            8: 'backspace',
                            13: 'enter',
                            9: 'tab',
                            27: 'esc'
                        };
                        var key = keys[$event.keyCode];
                        if (key == 'backspace' && scope.inputValue == "") {
                            if (scope.modelArr.length != 0) {
                                scope.removeAddedValues(scope.modelArr[scope.modelArr.length - 1]);
                                //scope.modelArr.pop();
                            }
                        }
                        else if (key == 'down') {
                            var filteredSuggestionArr = $filter('filter')(scope.suggestionsArr, scope.inputValue);
                            filteredSuggestionArr = $filter('filter')(filteredSuggestionArr, scope.alreadyAddedValues);
                            if (scope.selectedItemIndex < filteredSuggestionArr.length - 1)
                                scope.selectedItemIndex++;
                        }
                        else if (key == 'up' && scope.selectedItemIndex > 0) {
                            scope.selectedItemIndex--;
                        }
                        else if (key == 'esc') {
                            scope.isHover = false;
                            scope.isFocused = false;
                        }
                        else if (key == 'enter') {
                            var filteredSuggestionArr = $filter('filter')(scope.suggestionsArr, scope.inputValue);
                            filteredSuggestionArr = $filter('filter')(filteredSuggestionArr, scope.alreadyAddedValues);
                            if (scope.selectedItemIndex < filteredSuggestionArr.length)
                                scope.onSuggestedItemsClick(filteredSuggestionArr[scope.selectedItemIndex]);
                        }
                    };

                    scope.onSuggestedItemsClick = function (selectedValue) {
                        if (scope.beforeSelectItem && typeof (scope.beforeSelectItem) == 'function')
                            scope.beforeSelectItem(selectedValue);

                        scope.modelArr.push(selectedValue);

                        if (scope.afterSelectItem && typeof (scope.afterSelectItem) == 'function')
                            scope.afterSelectItem(selectedValue);
                        scope.inputValue = "";
                    };

                    var isDuplicate = function (arr, item) {
                        var duplicate = false;
                        if (arr == null || arr == "")
                            return duplicate;

                        for (var i = 0; i < arr.length; i++) {
                            duplicate = angular.equals(arr[i], item);
                            if (duplicate)
                                break;
                        }
                        return duplicate;
                    };

                    scope.alreadyAddedValues = function (item) {
                        var isAdded = true;
                        isAdded = !isDuplicate(scope.modelArr, item);
                        //if(scope.modelArr != null && scope.modelArr != ""){
                        //    isAdded = scope.modelArr.indexOf(item) == -1;
                        //    console.log("****************************");
                        //    console.log(item);
                        //    console.log(scope.modelArr);
                        //    console.log(isAdded);
                        //}
                        return isAdded;
                    };

                    scope.removeAddedValues = function (item) {
                        if (scope.modelArr != null && scope.modelArr != "") {
                            var itemIndex = scope.modelArr.indexOf(item);
                            if (itemIndex != -1) {
                                if (scope.beforeRemoveItem && typeof (scope.beforeRemoveItem) == 'function')
                                    scope.beforeRemoveItem(item);

                                scope.modelArr.splice(itemIndex, 1);

                                if (scope.afterRemoveItem && typeof (scope.afterRemoveItem) == 'function')
                                    scope.afterRemoveItem(item);
                            }
                        }
                    };

                    scope.mouseEnterOnItem = function (index) {
                        scope.selectedItemIndex = index;
                    };
                }
            };
        }
]);