var app = angular.module('LelongApi.app.home');
app.controller('multipleCtrl', [
  '$scope', '$element', 'title', 'close', 
  function($scope, $element, title, close) {

    $scope.fileList = [];
    $scope.curFile;
    $scope.ImageProperty = {
        file: ''
    }

    $scope.photoName = '';
    $scope.photoUrl = '';
    $scope.photoDesc = '';
    $scope.title = title;

    //  This close function doesn't need to use jQuery or bootstrap, because
    //  the button has the 'data-dismiss' attribute.
    $scope.close = function () {
        close({
            photoName: $scope.photoName,
            photoUrl: $scope.photoUrl,
            photoDesc: $scope.photoDesc
        }, 500); // close, but give 500ms for bootstrap to animate
    };

      //  This cancel function must use the bootstrap, 'modal' function because
      //  the doesn't have the 'data-dismiss' attribute.
    $scope.cancel = function () {
        //  Manually hide the modal.
        $element.modal('hide');

        //  Now call close, returning control to the caller.
        close({
            photoName: $scope.photoName,
            photoUrl: $scope.photoUrl,
            photoDesc: $scope.photoDesc
        }, 500); // close, but give 500ms for bootstrap to animate
    };

    $scope.setFile = function (element) {
        $scope.fileList = [];
        // get the files
        var files = element.files;
        for (var i = 0; i < files.length; i++) {
            $scope.ImageProperty.file = files[i];
            $scope.fileList.push($scope.ImageProperty);
            $scope.ImageProperty = {};
            $scope.$apply();
        }
    }

    $scope.UploadFile = function () {
        for (var i = 0; i < $scope.fileList.length; i++) {
            $scope.UploadFileIndividual(
                $scope.fileList[i].file,
                $scope.fileList[i].file.name,
                $scope.fileList[i].file.type,
                $scope.fileList[i].file.size,
                i);
        }
    }
    
    function genGUID() {
        var d = new Date().getTime();
        var uuid = 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function (c) {
            var r = (d + Math.random() * 16) % 16 | 0;
            d = Math.floor(d / 16);
            return (c == 'x' ? r : (r & 0x3 | 0x8)).toString(16);
        });
        return uuid;
    };

    $scope.UploadFileIndividual = function (fileToUpload, name, type, size, index) {
        //Create XMLHttpRequest Object
        var reqObj = new XMLHttpRequest();

        //event Handler
        reqObj.upload.addEventListener("progress", uploadProgress, false)
        reqObj.addEventListener("load", uploadComplete, false)
        reqObj.addEventListener("error", uploadFailed, false)
        reqObj.addEventListener("abort", uploadCanceled, false)

        //open the object and set method of call(get/post), url to call, isasynchronous(true/False)
        reqObj.open("POST", "/api/image/addGoodsImage", true);

        //set Content-Type at request header.For file upload it's value must be multipart/form-data
        reqObj.setRequestHeader("Content-Type", "multipart/form-data");

        //Set Other header like file name,size and type
        reqObj.setRequestHeader('X-File-Name', name);
        reqObj.setRequestHeader('X-File-Type', type);
        reqObj.setRequestHeader('X-File-Size', size);

        // send the file
        reqObj.send(fileToUpload);

        function uploadProgress(evt) {
            if (evt.lengthComputable) {
                var uploadProgressCount = Math.round(evt.loaded * 100 / evt.total);
                document.getElementById('P' + index).innerHTML = uploadProgressCount;

                if (uploadProgressCount == 100) {
                    document.getElementById('P' + index).innerHTML =
                   '<i class="fa fa-refresh fa-spin" style="color:maroon;"></i>';
                }
            }
        }

        function uploadComplete(evt) {
            /* This event is raised when the server  back a response */
            document.getElementById('P' + index).innerHTML = 'Saved';
            $scope.NoOfFileSaved++;
            $scope.$apply();
        }

        function uploadFailed(evt) {
            document.getElementById('P' + index).innerHTML = 'Upload Failed..';
        }

        function uploadCanceled(evt) {
            document.getElementById('P' + index).innerHTML = 'Canceled....';
        }
    }

}]);