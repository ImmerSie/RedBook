<%-- 
    Document   : createUser
    Created on : 05/09/2017, 4:00:21 PM
    Author     : Max
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Create User Account</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" type="text/css" href="assets/css/bootstrap.css">

        <!-- Website CSS style -->
        <link rel="stylesheet" type="text/css" href="CreateCSS.css">

        <!-- Website Font style -->
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.6.1/css/font-awesome.min.css">

        <!-- Google Fonts -->
        <link href='https://fonts.googleapis.com/css?family=Passion+One' rel='stylesheet' type='text/css'>
        <link href='https://fonts.googleapis.com/css?family=Oxygen' rel='stylesheet' type='text/css'>

    </head>
    <body>
        <div class="container">
            <div class="row main"> 
                <p>&nbsp;</p>
                 <p>&nbsp;</p>
                 <p>&nbsp;</p>
                 
                <div class="main-login main-center">
                    <form class="form-horizontal" action="newUser.jsp" method="post">
                        <div class="form-group">
                            <label for="name" class="cols-sm-2 control-label">Your Full Name</label>
                            <div class="cols-sm-10">
                                <div class="input-group">
                                    <span class="input-group-addon"><i class="fa fa-user fa" aria-hidden="true"></i></span>

                                    <input class="form-control" type="text" name="name" placeholder="Enter your Name">
                                </div>
                            </div>
                        </div>


                        <div class="form-group">
                            <label for="email" class="cols-sm-2 control-label">Your Email</label>
                            <div class="cols-sm-10">
                                <div class="input-group">
                                    <span class="input-group-addon"><i class="fa fa-envelope fa" aria-hidden="true"></i></span>
                                    <input class="form-control" type="email" name="email" placeholder="Enter your Email"/>
                                </div>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="password" class="cols-sm-2 control-label">Password</label>
                            <div class="cols-sm-10">
                                <div class="input-group">
                                    <span class="input-group-addon"><i class="fa fa-lock fa-lg" aria-hidden="true"></i></span>
                                    <input class="form-control" type="password" name="password"placeholder="Enter your Password" />
                                </div>
                            </div>
                        </div>

                        <div class="form-group ">
                            <input type="submit" class="btn btn-primary btn-lg btn-block" id="submit" value="Sign Up">
                            <!--                            <button type="button" class="btn btn-primary btn-lg btn-block login-button">Register</button>-->
                        </div>

                        <!--                        <input type="submit" value="CreateUser">-->
                    </form>
                  
                </div>
            </div>
        </div>
    </body>
</html>
