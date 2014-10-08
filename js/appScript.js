
var pageIndex = 0;
var pageCount = 200;
var evenNum = true;
var imagePath = "images/";
function GetRecords() {
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
                alert(response + ' failure ' + response.d);
            },
            error: function (response) {
                alert(response + ' error ' + response.d);
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
        //if (UrlExists(imagePath + MetadataUID + '.jpg')) {
            theThumb = imagePath + MetadataUID + '.jpg'
       // }
       // else {
        //    theThumb = dataSet.find("Thumb").text();

            /* Make ajax call here to fire server process to create the local thumbnail and lg image */

       // }
        thepic.attr({
            alt: mytitle,
            title: mytitle,
            src: theThumb,//.replace("width=100", "width=350").replace("height=100", "height=350")
            width: '100px',
            height: '100px'

        });

        var poptemplate = $("#poptemplate").eq(0).clone(true);
        var bgimg;

        //if (UrlExists(imagePath + 'lg' + MetadataUID + '.jpg')) {
            bgimg = imagePath + 'lg' + MetadataUID + '.jpg'
        //}
        //else {
         //   bgimg = dataSet.find("Thumb").text().replace("width=100", "width=515").replace("height=100", "height=515")
        //}

        var bigimage = $(".bigimage img", poptemplate);
        bigimage.attr({
            alt: mytitle,
            title: mytitle,
            src: bgimg,
            width: '515px',
            height: '515px'
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
        if (productAbstract.length > 153) {
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
            href: downLoadHref,
            title: mytitle + ' - ' + downloadTitle,
            target: '_blank'
        });

        $(".read-more-content", table).attr(
            { id: dataID });
        $(".LayerAbstract", table).html(dataSet.find("Abstract").text());

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
function MakeThumbNail(which) {
   /* $.ajax({
        type: "POST",
        url: "Default.aspx/CreateThumbNail",
        data: '{theUID: "' + which + '"}',
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: OnCreateThumbNailSuccess,
        failure: function (response) {
            alert(response.d);
        },
        error: function (response) {
            alert(response.d);
        }
    });*/
}
function OnCreateThumbNailSuccess(response)
{
    //alert(response);
}
