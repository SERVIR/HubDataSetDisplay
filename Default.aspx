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
                    <h4>
                        <p class="productTitle">Title Not Provided</p>
                    </h4>
                    <p class="date">Published on: <span class="productDate">Date Not Provided</span></p>

                    <table style="width: 100%;" border="0" cellspacing="0" cellpadding="0">
                        <tbody>
                            <tr>
                                <td class="popupdataLabel">
                                    <p><strong>Data content</strong>:</p>
                                </td>
                                <td class="popupdataData">
                                    <p class="productAbstract">No Abstract Provided</p>
                                </td>
                            </tr>
                            <tr>
                                <td class="popupdataLabel">
                                    <p><strong>Geometry type:</strong></p>
                                </td>
                                <td class="popupdataData">
                                    <p class="productType">No Type Provided</p>
                                </td>
                            </tr>
                            <tr>
                                <td class="popupdataLabel">
                                    <p>
                                        <strong>Data source:
                                        </strong>
                                    </p>
                                </td>
                                <td class="popupdataData">
                                    <p class="productDataSource"></p>
                                </td>
                            </tr>
                            <tr>
                                <td class="popupdataLabel">
                                    <p><strong>Disclaimer:</strong></p>
                                </td>
                                <td class="popupdataData">
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
                    <img src="images/nopreview.jpg" alt="" />
                </div>
                <div class="clear"></div>
            </div>
        </div>
    </form>
</body>
</html>
