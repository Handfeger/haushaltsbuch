<!DOCTYPE html>
<html lang="de" class="no-js" ng-app="Haushaltsbuch">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>Haushaltsbuch</title>
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width">

    <link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="assets/vendor/bootstrap/bootstrap.css">
    <link rel="stylesheet" href="assets/css/style.css">
</head>
<body ng-controller="Haushaltsbuch as appCtrl">
<!--Start Header-->
<div id="screensaver">
    <canvas id="canvas"></canvas>
    <i class="fa fa-lock" id="screen_unlock"></i>
</div>
<div id="modalbox">
    <div class="devoops-modal">
        <div class="devoops-modal-header">
            <div class="modal-header-name">
                <span>Basic table</span>
            </div>
            <div class="box-icons">
                <a class="close-link">
                    <i class="fa fa-times"></i>
                </a>
            </div>
        </div>
        <div class="devoops-modal-inner"></div>
        <div class="devoops-modal-bottom"></div>
    </div>
</div>

@yield('content')

@yield('footer')

</body>
</html>