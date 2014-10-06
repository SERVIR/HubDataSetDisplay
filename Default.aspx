<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>RCMRD Layers</title>
    <style type="text/css">
        * {
            margin: 0;
            padding: 0;
            border: none;
            box-sizing: border-box;
            -moz-box-sizing: border-box; /* Firefox */
            -webkit-box-sizing: border-box; /* Safari */
        }

        .clear {
            clear: both;
        }

        html {
            margin: 0;
            width: 100%;
            height: 100%;
        }

        body {
            margin: 0; /*Top and Bottom 0, Left and Right auto */
            width: 100%;
            height: 100%;
            overflow: hidden;
        }

        .body #main_wrapper {
            margin: 0;
            width: 100%;
            height: 100%;
            overflow-y: scroll;
        }
        /*********************To remove scroll bar from scrolling div***********************************
            Currently commented out for demo purposes so we can see the scrollbar position
        #main_wrapper::-webkit-scrollbar {
            display: none;
        }
        ***********************************************************************************************/
        #form1 {
            width: 100%;
            height: 100%;
        }

        #rcmrdlayers {
            width: 100%;
            height: 100%;
            margin: 0;
            padding: 0;
            border: none;
        }

        .navbar-fixed-top {
            display: none !important;
        }

        #countholder {
            position: absolute;
            top: 10px;
            left: 10px;
            background-color: aliceblue;
            padding: 5px;
            display: none;
        }

        #dvLayers .box {
            float: left;
            border: 1px solid #e5e4e4;
            background: #efeff0;
            padding: 9px;
            margin: 0 0 20px 0;
            width: 100%;
        }

        #dvLayers .item.space {
            /*width: 48%;
            float: left;
            margin-right: 20px;*/
        }

        #dvLayerstemplate {
            display: none;
        }

        .layerPhotosStyle {
            width: 100px;
        }

        .mappopup {
            color: #1b407b;
        }

            .mappopup:hover {
                color: #ed9126;
            }

        .read-more-content {
            display: block;
            overflow: hidden;
            max-width: 370px;
        }

            .read-more-content.hide {
                display: none;
                overflow: hidden;
            }

        .itemtable {
            width: 400px;
            float: left;
            padding: 5px;
        }

        .poptemplate {
            display: none;
        }
        #sb-player.html{
            overflow:hidden!important;
        }
        #sb-title-inner, #sb-info-inner, #sb-loading-inner, div.sb-message {
            color: orange !important;
        }

        #sb-player .bigimage {
            overflow: hidden;
            text-align: center;
            background: #ededee url(../images/ajax-loader.gif) no-repeat center;
        }

        #sb-player .detail {
            float: right;
            padding: 10px;
            width: 410px;
            max-height: 510px;
            /*width: 270px;
height: 455px;*/
            overflow: auto;
        }

        #sb-player .inner {
            margin: 30px;
            border: 5px solid silver;
            padding: 5px;
            border-style: ridge;
        }
    </style>
    <link href="css/shadowbox.css" rel="stylesheet" />
    <script src="js/jquery-2.1.1.min.js"></script>
    <script src="js/shadowbox.js"></script>
    <script src="js/jquery.easing-1.3.pack.js"></script>
    <script type="text/javascript">
        var pageIndex = 0;
        var pageCount = 200;
        var evenNum = true;
        var imagePath = "images/";
        function GetRecords() {
            //updateRecordCount(2);
            pageIndex++;
            if (pageIndex == 2 || pageIndex <= pageCount) {
                $("#loader").show();
                $.ajax({
                    type: "POST",
                    url: "Default.aspx/GetMoreArticles",
                    data: '{pageIndex: ' + pageIndex + '}',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: OnScrollSuccess,
                    failure: function (response) {
                        alert(response.d);
                    },
                    error: function (response) {
                        alert(response.d);
                    }
                });
            }
        }
        function UrlExists(url) {
            var http = new XMLHttpRequest();
            http.open('HEAD', url, false);
            http.send();
            return http.status != 404;
        }
        randomCounter = 1;
        var debugSet;
        function OnScrollSuccess(response) {
            randomCounter++;
            var xmlDoc = $.parseXML(response.d);
            var xml = $(xmlDoc);
            pageCount = parseInt(xml.find("PageCount").eq(0).find("PageCount").text());
            var dataSets = xml.find("DataSets");
            debugSet = dataSets;
            dataSets.each(function () {
                var dataSet = $(this);
                var table = $("#dvLayerstemplate table").eq(0).clone(true);
                var mytitle = dataSet.find("title").text();
                $(".LayerListTitle", table).html(mytitle);

                var dataID = dataSet.find("DataID").text() + "info" + randomCounter;

                var thepic = $(".layerPhotosStyle", table);
                var theThumb;
                var MetadataUID = dataSet.find("MetadataUID").text();
                if (UrlExists(imagePath + MetadataUID + '.jpg'))
                {
                    theThumb = imagePath + MetadataUID + '.jpg'
                }
                else {
                    theThumb = dataSet.find("Thumb").text();
                }
                



                thepic.attr({
                    alt: mytitle,
                    title: mytitle,
                    src: theThumb//.replace("width=100", "width=350").replace("height=100", "height=350")
                });

                var poptemplate = $("#poptemplate").eq(0).clone(true);
                // poptemplate
                //poptemplate.hide();
                //8cbccad2-40ac-11e4-b27d-080027beafcd

                var bgimg;

                if (UrlExists(imagePath + 'lg' + MetadataUID + '.jpg')) {
                    bgimg = imagePath + 'lg' + MetadataUID + '.jpg'
                }
                else {
                    bgimg = dataSet.find("Thumb").text().replace("width=100", "width=515").replace("height=100", "height=515")
                }

                var bigimage = $(".bigimage img", poptemplate);
                bigimage.attr({
                    alt: mytitle,
                    title: mytitle,
                    src: bgimg
                });


                poptemplate.attr(
                    { id: 'pop' + dataID });
                var mappopup = $(".mappopup", table);
                mappopup.attr({
                    href: 'javascript:popMe("#pop' + dataID + '")'
                });

                $(".productTitle", poptemplate).html(mytitle);
                $(".productDate", poptemplate).html(dataSet.find("PublicationDate").text());
                var productAbstract = dataSet.find("Abstract").text();
                if (productAbstract.length > 153)
                {
                    productAbstract = productAbstract.substring(0, 153) + '...';
                }
                $(".productAbstract", poptemplate).html(productAbstract);
                $(".productType", poptemplate).html(dataSet.find("Type").text());
                var dsinfo = "<a href='" + dataSet.find("MetadataURL").text() + "' target='_blank'>SERVIR AFRICA PORTAL</a><br />";
                dsinfo += "<a href='http://rcmrd.org/' target='_blank'>RCMRD</a><br />";
                dsinfo += "<a href='https://servirglobal.net/' target='_blank'>SERVIR</a><br />";
                $(".productDataSource", poptemplate).html(dsinfo);
                var downloadTitle = "Zipfile";
                var downloadLink = $(".productDownload", poptemplate);
                var downLoadHref = dataSet.find("Zipfile").text();
                if (downLoadHref.trim().length < 8) {
                    downLoadHref = dataSet.find("ArcGrid").text();
                    downloadTitle = "ArcGrid";
                }
                downloadLink.attr({
                    href: downLoadHref,// + "http%3A%2F%2Fwww.isotc211.org%2F2005%2Fgmd",
                    title: mytitle + ' - ' + downloadTitle,
                    target: '_blank'
                });

                //productDownload
                /*
                var TilesLink = dataSet.find("Tiles").text();
                var PNGLink = dataSet.find("PNG").text();
                var KMLLink = dataSet.find("KML").text();
                var PDFLink = dataSet.find("PDF").text();
                var somehtml = "<center><h2>" + mytitle + "</h2><img src='" + dataSet.find("Thumb").text() + "' style='width:498px;' /><br />Downloads" +
                    "<br /><a href='" + TilesLink + "' target='_blank'>Tiles</a> &nbsp; <a href='" + PNGLink + "' target='_blank'>PNG</a><br /> " +
                   " <a href='" + KMLLink + "' target='_blank'>KML</a> &nbsp; <a href='" + PDFLink + "' target='_blank'>PDF</a>" +
                "</center>";
                $(".LayerFullDetailInfo", table).html(somehtml);

                var mappopup = $(".mappopup", table);
                mappopup.attr({
                    href: 'javascript:popMe("#' + dataID + '")'
                });
                */
                $(".read-more-content", table).attr(
                    { id: dataID });
                $(".LayerAbstract", table).html(dataSet.find("Abstract").text());

                /*
                var theLink = $(".MetadataLink", table);

                theLink.attr({
                    href: dataSet.find("MetadataURL").text(),// + "http%3A%2F%2Fwww.isotc211.org%2F2005%2Fgmd",
                    title: mytitle,
                    target: '_blank'
                });
                */
                $("#dvLayers").append(table);//.append("<br />");
                $("#dvLayers").append(poptemplate);
                evenNum = !evenNum;
                if (evenNum) {
                    $("#dvLayers").append("<br style='clear:both;'/>");
                }
            });
            $("#loader").hide();
            finishedLoading = true;
            setTimeout("checkScrollbar()", 2000);
        }
        //this function is basically for demo purposes only
        function loadx(x) {
            for (var i = 0; i < x; i++) {
                pageIndex = 0;
                pageCount = 200;
                GetRecords();
            }
            //updateRecordCount(x * 3);
        }
        function updateRecordCount(howMany) {
            var thecount = $("#recordcount").text();
            thecount = (thecount * 1) + howMany;
            $("#recordcount").text(thecount);
        }
        $(document).ready(function () {
            $('.read-more-content').addClass('hide');
            $('.read-more-toggle').on('click', function () {
                openDetails(this);
            });
            Shadowbox.init({
                skipSetup: true
            });
            GetRecords();
            $("#main_wrapper").scroll(function () {
                if ($("#main_wrapper").scrollTop() + 1400 >= document.getElementById('main_wrapper').scrollHeight - $(window).height() && finishedLoading == true) {
                    finishedLoading = false;
                    GetRecords(); //this should be used instead of line below
                    //loadx(1);  //this would be removed after demo
                }
            });
        });
        function checkScrollbar() {
            if (document.getElementById('main_wrapper').clientHeight >= document.getElementById('main_wrapper').scrollHeight) {
                GetRecords();
            }
        }
        function popMe(which) {
            Shadowbox.open({
                content: which,
                player: 'inline',
                height: 600,
                width: 1000,
                counterType: "skip"
            });
        }
        function openDetails(which) {
            var readContentDiv = $(which).next('.read-more-content');
            if (readContentDiv.hasClass('hide')) {
                readContentDiv.removeClass('hide');
                readContentDiv.hide();
                var adjustnumHeight = readContentDiv.height('auto').height();
                readContentDiv.height(0);
                readContentDiv.show();
                readContentDiv.animate({
                    height: '+=' + adjustnumHeight + 'px'
                }, 500);
            }
            else {
                readContentDiv.addClass('hide');
                readContentDiv.animate({
                    height: '0px'
                }, 250);
            }
        }
    </script>
</head>
<body class="body">
    <form id="form1" runat="server">
        <div id="countholder">
            Record count = <span id="recordcount">0</span>
        </div>
        <div id="main_wrapper">
            <table style="width: 850px;">
                <tr>
                    <td>
                        <div id="dvLayers">
                            <%--Layers will go here created from template below--%>
                        </div>


                    </td>
                </tr>
                <tr>
                    <td valign="bottom" align="center">
                        <img id="loader" alt="" src="images/loading.gif" style="display: none" />
                    </td>
                </tr>
            </table>
        </div>

        <div class="clear"></div>

        <div id="dvLayerstemplate">
            <table cellpadding="0" cellspacing="0" border="0" class="itemtable">
                <tr>
                    <td>

                        <div class="item space">
                            <h3><span class="LayerListTitle"></span></h3>
                            <div class="box">
                                <div class="thumb">
                                    <a href="#inline-sample" class="mappopup" rel="shadowbox[Portfolio]" title="title here">
                                        <img src="#" class="layerPhotosStyle" alt=""></a>
                                </div>
                                <h4><a href="#" class="mappopup">
                                    <p><span class="LayerListTitle"></span></p>
                                </a></h4>
                                <div class="summary" style="display: block;">
                                    <%-- <p>

                                        <a href="#meta" target="_blank" class="MetadataLink">...Metadata</a>
                                    </p>--%>
                                </div>
                                <a href="#" class="read-more-toggle">Expand to see more</a>
                                <div class="read-more-content">
                                    <span class="LayerAbstract"></span>
                                    <span class="LayerFullDetailInfo"></span>
                                </div>

                            </div>
                        </div>


                    </td>
                </tr>
            </table>

        </div>
        <div id="inline-sample" style="display: none">
            <div class="inline-sample-content">
                hello! 
            </div>
        </div>



        <div id="poptemplate" class="poptemplate">
            <div class="inner">
                <div class="detail">
                    <h4>
                        <p class="productTitle">Title Not Provided</p>
                    </h4>
                    <p class="date">Published on: <span class="productDate">Date Not Provided</span></p>

                    <table style="width: 100%;" border="0" cellspacing="0" cellpadding="0">
                        <tbody>
                           <%-- <tr>
                                <td valign="top" nowrap="nowrap" width="124">
                                    <p><strong>Production date: </strong></p>
                                </td>
                                <td valign="top" width="255">
                                    <p>2012</p>
                                </td>
                            </tr>--%>
                            <tr>
                                <td valign="top" nowrap="nowrap" width="124">
                                    <p><strong>Data content</strong>:</p>
                                </td>
                                <td valign="top" width="255">
                                    <p class="productAbstract">No Abstract Provided</p>
                                </td>
                            </tr>
                            <tr>
                                <td valign="top" nowrap="nowrap" width="124">
                                    <p><strong>Geometry type:</strong></p>
                                </td>
                                <td valign="top" width="255">
                                    <p class="productType">No Type Provided</p>
                                </td>
                            </tr>
                           <%-- <tr>
                                <td valign="top" nowrap="nowrap" width="124">
                                    <p><strong>Coordinate system</strong>:</p>
                                </td>
                                <td valign="top" width="255">
                                    <p>WGS 1984 - Geographic</p>
                                </td>
                            </tr>--%>
                            <tr>
                                <td valign="top" nowrap="nowrap" width="124">
                                    <p>
                                        <strong>Data source:
                                        </strong>
                                    </p>
                                </td>
                                <td valign="top" width="255">
                                    <p class="productDataSource">Environment Operations Center (<a href="http://www.gms-eoc.org">www.gms-eoc.org</a>) digitized from GMS Transport Sector Strategy and other ADB maps</p>
                                </td>
                            </tr>
                            <tr>
                                <td valign="top" nowrap="nowrap" width="124">
                                    <p><strong>Disclaimer:</strong></p>
                                </td>
                                <td valign="top" width="255">
                                    <p><a href="https://servirglobal.net/Global/PrivacyTermsofUse.aspx" target="_blank">Read disclaimer</a>&nbsp;</p>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                    <p>&nbsp;</p>
                    <!---->
                    <!---->
                    <a class="productDownload" target="_blank" href="/uploads/map/data/download/gms_ec-roads_4.zip">Download</a>
                </div>
                <div class="bigimage">
                    <img src="images/nopreview.jpg" data="images/nopreview.jpg" alt="ECONOMIC CORRIDORS">
                </div>
                <div class="clear"></div>
            </div>
        </div>



    </form>

</body>

</html>
