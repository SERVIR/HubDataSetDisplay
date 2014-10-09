<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>RCMRD Layers</title>
    <link href="css/shadowbox.css" rel="stylesheet" />
    <script src="js/jquery-2.1.1.min.js"></script>
    <script src="js/shadowbox.js" type="text/javascript"></script>
    <script src="js/jquery.easing-1.3.pack.js" type="text/javascript"></script>
    <link href="css/StyleSheet.css" rel="stylesheet" />
    <script src="js/appScript.js" type="text/javascript"></script>
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
         <%--Template for datasets gridview--%>
        <div id="dvLayerstemplate">
            <table cellpadding="0" cellspacing="0" border="0" class="itemtable">
                <tr>
                    <td>

                        <div class="item space">
                            <h3><span class="LayerListTitle"></span></h3>
                            <div class="box">
                                <div class="thumb">
                                    <a href="#" class="mappopup" rel="shadowbox[Portfolio]" title="title here">
                                        <img src="#" class="layerPhotosStyle" alt="" /></a>
                                </div>
                                <h4><a href="#" class="mappopup">
                                    <p><span class="LayerListTitle"></span></p>
                                </a></h4>
                                <div class="summary" style="display: block;">
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
        <%--Template for datasets detail view--%>
        <div id="poptemplate" class="poptemplate">
            <div class="inner">
                <div class="detail">
                    <img src="images/eafricaheader.png" style="width:375px;" alt="SERVIR - East Africa" />
                    <h4>
                        <p class="productTitle">Title Not Provided</p>
                    </h4>
                    <p class="date">Published on: <span class="productDate">Date Not Provided</span></p>

                    <table style="width: 100%; padding-right:5px;" border="0" cellspacing="0" cellpadding="0">
                        <tbody>
                            <tr>
                                <td colspan="2">
                                    <p class="productAbstract">No Abstract Provided</p>
                                </td>
                            </tr>
                           
                            <tr>
                                <td colspan="2">
                                    <img src="images/spacer.png" style="height:80px; width:0px;" />
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2" style="text-align: center;">
                                    <a class="productDownload" target="_blank" href="#"><img src="images/download.png" alt="Download" /></a><a class="productvisualize" target="_blank" href="#"><img src="images/visualize.png" alt="visualize" /></a><a class="productReadMore" target="_blank" href="#"><img src="images/readmore.png" alt="Download" /></a>
                                </td>
                            </tr>
                            <tr style="background: url(images/footer-logos-bg.png);">
                                <td colspan="2">
                                    <img src="images/combologos.png" style="width:375px;" />
                                </td>
                            </tr>
                             <tr>
                                <td colspan="2">
                                    <p style="text-align:center;"><a href="https://servirglobal.net/Global/PrivacyTermsofUse.aspx" target="_blank">Read disclaimer</a>&nbsp;</p>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                    
                    <!---->
                    <!---->
                    
                </div>
                <div class="bigimage">
                    <img src="images/nopreview.jpg" alt="" />
                </div>
                <div class="clear"></div>
            </div>
        </div>
    </form>
</body>
</html>
