angular.module('LelongApi.app').directive('datetimepicker', function () {
	return {
		restrict: 'A',
		require: 'ngModel',
		link: function (scope, element, attrs, ngModelCtrl) {
			$(function () {
				element.datetimepicker({
					format: 'm/d/Y h:m:s A',
					onSelect: function (date) {
						scope.$apply(function () {
							ngModelCtrl.$setViewValue(date);
						});
					}
				});
			});
		}
	};
});

angular.module('pulse.app').directive('datetimepicker1', function () {
    return {
        restrict: 'A',
        require: 'ngModel',
        link: function (scope, element, attrs, ngModelCtrl) {
            $(function () {
                element.datetimepicker({
                    format: 'm/d/Y h:m A',
                    onSelect: function (date) {
                        scope.$apply(function () {
                            ngModelCtrl.$setViewValue(date);
                        });
                    }
                });
            });
        }
    };
});

angular.module('pulse.app').directive("datePicker", function () {
	return {
		restrict: 'A',
		require: 'ngModel',
		link: function (scope, element, attrs, ngModelCtrl) {
			$(function () {
				element.datetimepicker({
					format: 'm/d/Y',
					timepicker: false,
					closeOnDateSelect: true,
					onSelect: function (date) {
						scope.$apply(function () {
							ngModelCtrl.$setViewValue(date);
						});
					}
				});
			});
		}
	};
});

angular.module('pulse.app').directive("timePicker", function () {
    return {
		restrict: 'A',
		require: 'ngModel',
		link: function (scope, element, attrs, ngModelCtrl) {
		    $(function () {
				element.datetimepicker({
					format: 'h:m A',
					datepicker: false,
					onSelect: function (date) {
						scope.$apply(function () {
							ngModelCtrl.$setViewValue(date);
						});
					}
				});
			});
		}
	};
});

angular.module('pulse.app').directive("timePicker1", function () {
    return {
        restrict: 'A',
        require: 'ngModel',
        link: function (scope, element, attrs, ngModelCtrl) {
            $(function () {
                element.datetimepicker({
                    format: 'H:m',
                    datepicker: false,
                    onSelect: function (date) {
                        scope.$apply(function () {
                            ngModelCtrl.$setViewValue(date);
                        });
                    }
                });
            });
        }
    };
});

angular.module('pulse.app').directive("monthPicker", function () {
    return {
        restrict: 'A',
        require: 'ngModel',
        link: function (scope, element, attrs, ngModelCtrl) {
            $(function () {
                element.datetimepicker({
                    format: 'm/Y',
                    timepicker: false,
                    closeOnDateSelect: true,
                    onSelect: function (date) {
                        scope.$apply(function () {
                            ngModelCtrl.$setViewValue(date);
                        });
                    }
                });
            });
        }
    };
});

angular.module('pulse.app').directive("weekPicker", function () {
    return {
        restrict: 'A',
        require: 'ngModel',
        link: function (scope, element, attrs, ngModelCtrl) {
            $(function () {
                element.datetimepicker({
                    format: 'W/Y',
                    timepicker: false,
                    closeOnDateSelect: true,
                    onSelect: function (date) {
                        scope.$apply(function () {
                            ngModelCtrl.$setViewValue(date);
                        });
                    }
                });
            });
        }
    };
});



