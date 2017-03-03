(function () {
    angular.module('icheck.directives', []);

    angular.module('icheck.directives').directive('icheck', function ($timeout, $parse) {
        return {
            require: 'ngModel',
            scope:{action:'&'},
            link: function ($scope, element, $attrs, ngModel) {
                return $timeout(function () {
                    var value;
                    value = $attrs['value'];
                    var skin = $attrs['skin'];

                    $scope.$watch($attrs['ngModel'], function (newValue) {
                        $(element).iCheck('update');
                    });

                    $attrs.$observe('disabled', function () {
                        $(element).iCheck('update');
                    });

                    return $(element).iCheck({
                        checkboxClass: 'icheckbox_' + skin,
                        radioClass: 'iradio_' + skin

                    }).on('ifToggled', function (event) {
                        if ($(element).attr('type') === 'checkbox' && $attrs['ngModel']) {
                            //call method in TaskCtrl
                            $scope.action();

                            $scope.$apply(function () {
                                return ngModel.$setViewValue(event.target.checked);
                            });                           
                        }
                        if ($(element).attr('type') === 'radio' && $attrs['ngModel']) {
                            return $scope.$apply(function () {
                                return ngModel.$setViewValue(value);
                            });
                        }
                    });
                });
            }
        };
    });

}).call(this);