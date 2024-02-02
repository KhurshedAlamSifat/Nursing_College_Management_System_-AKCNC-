<%@ Page Language="C#" AutoEventWireup="true" CodeFile="LocalHomePage.aspx.cs" Inherits="HomePages_LocalHomePage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <!--Meta Tags-->
    <%--  <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="" />
    <meta name="keywords" content="" />--%>

    <!--Favicons-->
    <%--<link rel="shortcut icon" type="image/x-icon" href="/HomePages/assets/img/favicon.ico" />--%>

    <!--Page Title-->
    <title>AKCNC</title>

    <!-- Bootstrap core CSS -->
    <link href="/HomePages/assets/bootstrap/css/bootstrap.min.css" rel="stylesheet" />
    <!-- Google Font  -->
    <link href="https://fonts.googleapis.com/css?family=Dosis:300,400,500,600,700,800|Roboto:300,400,400i,500,500i,700,700i,900,900i" rel="stylesheet" />
    <!-- Fontawesome CSS -->
    <link rel="stylesheet" href="/HomePages/assets/css/icofont.min.css" />
    <!-- Meanmenu CSS -->
    <link rel="stylesheet" href="/HomePages/assets/css/meanmenu.min.css" />
    <!--- owl carousel Css-->
    <link rel="stylesheet" href="/HomePages/assets/owlcarousel/css/owl.carousel.min.css" />
    <link rel="stylesheet" href="/HomePages/assets/owlcarousel/css/owl.theme.default.min.css" />
    <!-- animate CSS -->
    <link rel="stylesheet" href="/HomePages/assets/css/animate.css" />
    <!-- venobox -->
    <link rel="stylesheet" href="/HomePages/assets/venobox/css/venobox.css" />
    <!-- SLIDER REVOLUTION 4.x CSS SETTINGS -->
    <link rel="stylesheet" type="text/css" href="/HomePages/rs-plugin/css/settings.css" media="screen" />
    <link rel="stylesheet" type="text/css" href="/HomePages/assets/css/extralayers.css" media="screen" />
    <!-- Style CSS -->
    <link rel="stylesheet" href="/HomePages/assets/css/style.css" />
    <!-- Responsive  CSS -->
    <link rel="stylesheet" href="/HomePages/assets/css/responsive.css" />
    <style>
        .home-3 .top-area {
            background: #ffffff;
        }

        .logo-area {
            padding: 0px 0;
        }

        .welcome-section-padding {
            padding: 30px 0;
        }

        .section-padding {
            padding: 30px 0;
        }

        p {
            text-align: justify;
        }

        @media only screen and (max-width: 488px) {
            .top-header-area {
                display: block !important;
            }
        }

        .top-header-area {
            display: flex;
            justify-content: center;
            align-items: center;
        }

            .top-header-area .logo-area img {
                max-width: 120px;
                margin-right: 20px;
            }

        .logo-text-area {
            text-align: left;
        }

        .top-header-area .logo-text-area h1 {
            font-size: 30px;
            font-weight: 600;
            color: rgb(0,87,255);
        }

        .top-header-area .logo-text-area span {
            font-size: 15px;
            font-weight: 500;
            color: rgb(0,2,139);
            font-style: italic;
        }
    </style>
</head>

<body class="home-3">
    <form id="form2" runat="server">
        <!-- START PRELOADER -->
        <div id="page-preloader">
            <div class="loader"></div>
            <div class="loa-shadow"></div>
        </div>
        <!-- END PRELOADER -->
        <!-- START HEADER SECTION -->
        <header class="main-header">
            <!-- START TOP AREA -->
            <div class="top-area">
                <div class="auto-container">
                    <div class="row">
                        <div class="col-lg-8 col-12 mx-auto text-center justify-content-center">
                            <div class="top-menu top-header-area">
                                <div class="logo-area">
                                    <img src="/HomePages/assets/img/custom/logo_prps.jpg" />
                                </div>
                                <div class="logo-text-area">
                                    <h1>PRAN RFL Public School</h1>
                                    <span>Where Knowledge Unfolds...</span>
                                </div>
                            </div>
                        </div>
                        <!-- end col -->
                    </div>
                </div>
            </div>
            <!-- END TOP AREA -->

            <asp:Panel ID="pnlScrollingMessage" runat="server">
                <div class="logo-area">
                    <div class="auto-container">
                        <div class="row">
                            <marquee behavior="scroll" direction="left" style="color: blue; font-size: large; font-weight: 700;" onmouseover="this.stop();" onmouseout="this.start();">
                                <asp:Repeater ID="rptNotice" runat="server">
                                    <itemtemplate>
                                        <a href="../Pages/Public/ViewLocalNotice.aspx?id=<%#Eval("Id") %>">| &nbsp;&nbsp;&nbsp; <%#Eval("Title") %> &nbsp;&nbsp;&nbsp;|</a>
                                    </itemtemplate>
                                </asp:Repeater>
                            </marquee>
                        </div>
                    </div>
                </div>
            </asp:Panel>

            <!-- START NAVIGATION AREA -->
            <div class="sticky-menu">
                <div class="mainmenu-area">
                    <div class="auto-container">
                        <div class="row">
                            <div class="col-9 mx-auto d-none d-lg-block d-md-none">
                                <nav class="navbar navbar-expand-lg justify-content-center">
                                    <ul class="navbar-nav">
                                        <li><a href="#slider" class="nav-link js-scroll-trigger">Slider</a></li>
                                        <li><a href="#gallery" class="nav-link js-scroll-trigger">Gallery</a></li>
                                        <li><a href="../Pages/Public/LocalNoticeList.aspx" class="nav-link js-scroll-trigger">Notice</a></li>
                                        <li><a href="../Pages/Public/ContentList.aspx" class="nav-link js-scroll-trigger">Content</a></li>
                                        <li><a href="../Pages/JobApplication/JobApplicationEntry.aspx" class="nav-link js-scroll-trigger">Job-Apllication</a></li>
                                        <li><a href="../Login.aspx?CampusNo=<% =CampusNo %>" class="nav-link js-scroll-trigger">Login</a></li>
                                        <li class="dropdown"><a class="nav-link">Admission</a>
                                            <ul class="dropdown-menu">
                                                <li><a href="../Pages/User/AdmissionCircular.aspx">Admission Circular</a></li>
                                                <li><a href="../Pages/User/ApplicationDownload.aspx">Application Download</a></li>
                                                <li><a href="../Pages/User/ApplicationPayment.aspx">Application Payment</a></li>
                                                <li><a href="../Pages/User/AdmitCard.aspx">Admit Card</a></li>
                                                <li><a href="../Pages/User/AdmissionTestSchedule.aspx">Exam Schedule</a></li>
                                                <li><a href="../Pages/User/AdmissionResult.aspx">Admission Result</a></li>
                                            </ul>
                                        </li>
                                    </ul>
                                </nav>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- END NAVIGATION AREA -->
        </header>
        <!-- END HEADER SECTION -->

        <section id="slider" class="slider-section">
            <div class="tp-banner-container">
                <div class="tp-banner">
                    <ul>
                        <!-- SLIDE 1 -->
                        <li data-transition="slideup" data-slotamount="1" data-masterspeed="1000" data-delay="10000" data-saveperformance="off" data-title="Slide One">
                            <!-- MAIN IMAGE -->
                            <img src="/HomePages/assets/img/custom/bannner_1.jpg" alt="" data-bgposition="center center" data-bgfit="cover" data-bgrepeat="no-repeat" />
                            <!-- LAYERS -->
                            <div class="tp-caption lfb ltt tp-resizeme rs-parallaxlevel-10"
                                data-x="right" data-hoffset="-245"
                                data-y="center" data-voffset="70"
                                data-speed="1400"
                                data-start="1400"
                                data-endspeed="1200"
                                data-easing="easeOutExpo"
                                data-splitin="none"
                                data-splitout="none"
                                data-elementdelay="0.01"
                                data-endelementdelay="0.1">
                            </div>
                        </li>
                        <!-- SLIDE 1 -->
                        <li data-transition="slideright" data-slotamount="1" data-masterspeed="1000" data-delay="10000" data-saveperformance="off" data-title="Slide two">
                            <!-- MAIN IMAGE -->
                            <img src="/HomePages/assets/img/custom/bannner_2.jpg" alt="" data-bgposition="center center" data-bgfit="cover" data-bgrepeat="no-repeat" />
                            <!-- LAYERS -->
                            <div class="tp-caption lfb ltt tp-resizeme rs-parallaxlevel-10"
                                data-x="right" data-hoffset="-245"
                                data-y="center" data-voffset="70"
                                data-speed="1400"
                                data-start="1400"
                                data-endspeed="1200"
                                data-easing="easeOutExpo"
                                data-splitin="none"
                                data-splitout="none"
                                data-elementdelay="0.01"
                                data-endelementdelay="0.1">
                            </div>
                        </li>
                        <!-- SLIDE 3 -->
                        <li class="text-center" data-transition="slideleft" data-slotamount="1" data-masterspeed="1000" data-delay="10000" data-saveperformance="off" data-title="Slide Three">
                            <!-- MAIN IMAGE -->
                            <img src="/HomePages/assets/img/custom/bannner_3.jpg" alt="" data-bgposition="center center" data-bgfit="cover" data-bgrepeat="no-repeat" />
                            <!-- LAYERS -->
                            <div class="tp-caption lfb ltt tp-resizeme rs-parallaxlevel-10"
                                data-x="right" data-hoffset="-245"
                                data-y="center" data-voffset="70"
                                data-speed="1400"
                                data-start="1400"
                                data-endspeed="1200"
                                data-easing="easeOutExpo"
                                data-splitin="none"
                                data-splitout="none"
                                data-elementdelay="0.01"
                                data-endelementdelay="0.1">
                            </div>
                        </li>
                    </ul>
                    <div class="tp-bannertimer"></div>
                </div>
            </div>
        </section>


        <asp:Repeater ID="rptrMiddleContents" runat="server">
            <ItemTemplate>
                <section class="welcome-section-padding">
                    <div class="auto-container">
                        <div class="row">
                            <div class="col-lg-6 col-md-6 col-12 mb-lg-0 mb-lg-0 mb-5">
                                <div class="about-wel-des">
                                    <h2 class="my-4"><%#Eval("Title") %></h2>
                                    <p><%#Eval("Content") %></p>
                                </div>
                            </div>
                            <%# Eval("Category").ToString() == "Text With Youtube Video" ? "<div class='col-lg-6 col-md-6 col-12'><div class='thumbnail'><h2 class='my-4'>&nbsp;</h2><iframe width='560' height='315' src='https://www.youtube.com/embed/"+ Eval("YoutubeLink") + "' title='YouTube video player' frameborder='0' allow='accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture' allowfullscreen></iframe></div></div>" 
                                    : "<div class='col-lg-6 col-md-6 col-12'><h2 class='my-4'>&nbsp;</h2><div class='tea-intro-img float-lg-right float-none text-lg-right text-center'><img class='img-fluid' src='../VariableContent/HomePage/"+Eval("ImageLink").ToString()+"' alt='' /></div></div>" %>
                        </div>
                    </div>
                </section>
            </ItemTemplate>
        </asp:Repeater>


        <section id="gallery" class="section-padding">
            <div class="auto-container">
                <div class="row">
                    <div class="col-lg-7 col-md-7 col-12 mx-auto text-center">
                        <div class="section-title">
                            <h2>Image Gallery</h2>
                        </div>
                    </div>
                </div>
                <!-- end section title -->
                <div class="row mb-5" style="display: none;">
                    <div class="col-12 mx-auto text-center wow fadeInDown">
                        <div class="portfolio-filter-menu">
                            <ul>
                                <li class="filter active" data-filter="*">All Works</li>
                                <li class="filter" data-filter=".one">Learning</li>
                                <li class="filter" data-filter=".two">Games</li>
                                <li class="filter" data-filter=".three">School</li>
                                <li class="filter" data-filter=".four">Class</li>
                            </ul>
                        </div>
                    </div>
                </div>
                <!-- end portfolio menu list -->
                <div class="row project-list">
                    <asp:Repeater ID="rptrImageForGallery" runat="server">
                        <ItemTemplate>
                            <div class="col-lg-4 col-md-6 col-12 mb-lg-4 mb-md-4 mb-4 two">
                                <img class="img-fluid" style="border: 5px solid black;" src='../VariableContent/HomePage/<%#Eval("ImageLink") %>' alt="" />
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
                <%--<div class="row mt-4">
                    <div class="col-12 mx-auto text-center wow fadeInDown">
                        <a href="#" class="port-btn">Load More <i class="icofont-bubble-right"></i></a>
                    </div>
                </div>--%>
            </div>
            <!--- END CONTAINER -->
        </section>

        <!-- START FOOTER -->
        <footer class="footer-section footer-2">
            <div id="bottom-footer" class="bg-gray">
                <div class="auto-container">
                    <div class="row mb-lg-0 mb-md-4 mb-4">
                        <div class="col-12 text-center">
                            <p class="copyright-text">Copyright © 2022 <a href="#">PRAN RFL Group-CS-MIS</a> All Rights Reserved</p>
                        </div>
                        <!-- end col -->
                    </div>
                </div>
            </div>
        </footer>
        <!-- END FOOTER -->
        <!-- Latest jQuery -->
        <script src="/HomePages/assets/js/jquery-2.2.4.min.js"></script>
        <!-- popper js -->
        <script src="/HomePages/assets/bootstrap/js/popper.min.js"></script>
        <!-- Latest compiled and minified Bootstrap -->
        <script src="/HomePages/assets/bootstrap/js/bootstrap.min.js"></script>
        <!-- Meanmenu Js -->
        <script src="/HomePages/assets/js/jquery.meanmenu.js"></script>
        <!-- Sticky JS -->
        <script src="/HomePages/assets/js/jquery.sticky.js"></script>
        <!-- SLIDER REVOLUTION 4.x SCRIPTS  -->
        <script src="/HomePages/rs-plugin/js/jquery.themepunch.plugins.min.js"></script>
        <script src="/HomePages/rs-plugin/js/jquery.themepunch.revolution.min.js"></script>
        <!-- countdown js -->
        <script src="/HomePages/assets/js/jquery.countdown.min.js"></script>
        <!-- owl-carousel min js  -->
        <script src="/HomePages/assets/owlcarousel/js/owl.carousel.min.js"></script>
        <!-- isotope js -->
        <script src="/HomePages/assets/js/isotope.3.0.6.min.js"></script>
        <!-- venobox js -->
        <script src="/HomePages/assets/venobox/js/venobox.min.js"></script>
        <!-- jquery appear js  -->
        <script src="/HomePages/assets/js/jquery.appear.js"></script>
        <!-- countTo js -->
        <script src="/HomePages/assets/js/jquery.inview.min.js"></script>
        <!-- scrolltopcontrol js -->
        <script src="/HomePages/assets/js/scrolltopcontrol.js"></script>
        <!-- WOW - Reveal Animations When You Scroll -->
        <script src="/HomePages/assets/js/wow.min.js"></script>
        <!-- scripts js -->
        <script src="/HomePages/assets/js/scripts.js"></script>
        <script>
            jQuery(document).ready(function () {
                jQuery('.tp-banner').show().revolution(
                    {
                        dottedOverlay: "none",
                        delay: 16000,
                        startwidth: 1170,
                        startheight: 550,
                        hideThumbs: 200,
                        thumbWidth: 100,
                        thumbHeight: 50,
                        thumbAmount: 5,
                        navigationType: "bullet",
                        navigationArrows: "solo",
                        navigationStyle: "preview2",
                        touchenabled: "on",
                        onHoverStop: "on",
                        swipe_velocity: 0.7,
                        swipe_min_touches: 1,
                        swipe_max_touches: 1,
                        drag_block_vertical: false,
                        parallax: "mouse",
                        parallaxBgFreeze: "on",
                        parallaxLevels: [7, 4, 3, 2, 5, 4, 3, 2, 1, 0],
                        keyboardNavigation: "off",
                        navigationHAlign: "center",
                        navigationVAlign: "bottom",
                        navigationHOffset: 0,
                        navigationVOffset: 20,
                        soloArrowLeftHalign: "left",
                        soloArrowLeftValign: "center",
                        soloArrowLeftHOffset: 20,
                        soloArrowLeftVOffset: 0,
                        soloArrowRightHalign: "right",
                        soloArrowRightValign: "center",
                        soloArrowRightHOffset: 20,
                        soloArrowRightVOffset: 0,
                        shadow: 0,
                        fullWidth: "on",
                        fullScreen: "off",
                        spinner: "spinner4",
                        stopLoop: "off",
                        stopAfterLoops: -1,
                        stopAtSlide: -1,
                        shuffle: "off",
                        autoHeight: "off",
                        forceFullWidth: "off",
                        hideThumbsOnMobile: "off",
                        hideNavDelayOnMobile: 1500,
                        hideBulletsOnMobile: "off",
                        hideArrowsOnMobile: "off",
                        hideThumbsUnderResolution: 0,
                        hideSliderAtLimit: 0,
                        hideCaptionAtLimit: 0,
                        hideAllCaptionAtLilmit: 0,
                        startWithSlide: 0,
                        fullScreenOffsetContainer: ""
                    });
            });
        </script>
    </form>
</body>
</html>
