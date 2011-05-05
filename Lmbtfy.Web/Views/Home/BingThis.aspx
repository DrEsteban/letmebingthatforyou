﻿<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<string>" %>

<asp:Content ID="indexTitle" ContentPlaceHolderID="TitleContent" runat="server">
    Let me Bing that for you!
</asp:Content>
<asp:Content ID="headerContent" ContentPlaceHolderID="HeaderContent" runat="server">
    <script type="text/javascript">
        var displayContainer;
        var searchQuery;
        var searchButton;
        var fakeMouse;

        $(function() {
            displayContainer = $("#lmbtfyResult");
            searchQuery = $("#sb_form_q");
            searchButton = $("#sb_form_go");
            fakeMouse = $("#fake_mouse");
            displayContainer.show("bounce", "fast", function() {
                if (jQuery.browser.msie) { this.style.removeAttribute('filter'); }
                $(".step1").show("drop", function() {
                    if (jQuery.browser.msie) { this.style.removeAttribute('filter'); }
                    $(".step2").show("drop", function() {
                    if (jQuery.browser.msie) { this.style.removeAttribute('filter'); }
                        fakeMouse.show("bounce");
                        fakeMouse.animate({
                            top: (searchQuery.offset().top + 15) + "px",
                            left: (searchQuery.offset().left + 10) + "px"
                        }, 1500, 'swing', function() {
                            searchQuery.focus();
                            fakeMouse.animate({ top: "+=18px", left: "+=10px" }, "fast");

                            $(".step3").show("drop", function() {
                                if (jQuery.browser.msie) { this.style.removeAttribute('filter'); }
                                type(unescape('<%= Ajax.JavaScriptStringEncode(Model) %>'), 0);
                            });
                        });
                    });
                });
            });
        });

        // this method was stolen from lmgtfy.com.
        // credits: http://twitter.com/coderifous
        // thanks!
        function type(string, index) {
            var val = string.substr(0, index + 1);
            searchQuery.attr('value', val);
            if (index < string.length) {
                setTimeout(function() { type(string, index + 1); }, Math.random() * 240);
            }
            else {
                doneTyping();
            }
        }

        function doneTyping() {
            $(".step4").show("drop", function() {
                if (jQuery.browser.msie) { this.style.removeAttribute('filter'); }
                fakeMouse.animate({
                    top: (searchButton.offset().top + 10) + "px",
                    left: (searchButton.offset().left + 10) + "px"
                }, 2000, 'swing', function() {
                    searchButton.click();
                });
            });
        }
    </script>

</asp:Content>
<asp:Content ID="indexContent" ContentPlaceHolderID="MainContent" runat="server">
    <img src="<%=Url.Content("~/Content/mouse_pointer.gif")%>" id="fake_mouse" style="display: none;" />
    
    <div class="sc_grad">
        <div>
        </div>
    </div>
    
    <table class="layout">
        <tr>
            <td align="center" class="layout">
                <div id="sw_hdr">
                    <div class="sw_tb">
                        <div style="clear: both">
                        </div>
                    </div>
                    <div class="sw_tbb">
                    </div>
                </div>
                <div id="container">
                    <div class="content_wrap">
                        <div id="content">
                            <div id="sw_content">
                                <div class="sw_sform">
                                    <div class="let_me">
                                        Let me</div>
                                    <div class="sw_logo">
                                        Bing
                                    </div>
                                    <div class="that_for_you">
                                        that for you!</div>
                                    <div class="sw_mbrand">
                                    </div>
                                    <div class="beta">
                                    </div>
                                    <div class="search_controls">
                                        <form method="get" class="sw_box" id="sb_form" action="http://www.bing.com/search">
                                        <div class="sw_bd">
                                            <div class="sw_b">
                                                <input class="sw_qbox" id="sb_form_q" name="q" title="Enter your search term" type="text"
                                                    value="" />
                                                <input class="sw_qbtn" id="sb_form_go" name="go" tabindex="0" title="Search" type="submit"
                                                    value="" />
                                            </div>
                                            <div id="sw_as">
                                            </div>
                                        </div>
                                        </form>
                                    </div>
                                    <div id="lmbtfyResult" style="background-color: #fff;">
                                        <div>
                                            <h1>Let me Bing that for you!</h1>
                                            <h2 class="step1">
                                                Here's how you can do it yourself...</h2>
                                            <ol class="steps">
                                                <li class="step2">Navigate to <a href="http://www.bing.com">Bing.com</a></li>
                                                <li class="step3">Enter your search query</li>
                                                <li class="step4">Click the button and behold the results!</li>
                                            </ol>
                                        </div>
                                    </div>
                                </div>
                                <div id="bgDiv">
                                </div>
                            </div>
                        </div>
                    </div>
                    <div id="sb_foot">
                        <% Html.RenderPartial("Footer"); %>
                    </div>
                </div>
            </td>
        </tr>
    </table>
</asp:Content>
