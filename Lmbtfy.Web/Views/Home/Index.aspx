﻿<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="indexTitle" ContentPlaceHolderID="TitleContent" runat="server">
    Let me Bing that for you!
</asp:Content>

<asp:Content ID="headerContent" ContentPlaceHolderID="HeaderContent" runat="server">
    <meta name="keywords" content="bing, google, let me bing that for you, let me google that for you" />
    <meta name="description" content="Let Me Bing That For You! - For all those people that find it more convenient to bother you with their questions rather than Bing it for themselves." />

    <script type="text/javascript">
        $(function() {
            var searchForm = $("#sb_form");
            var searchQuery = $("#sb_form_q");
            var searchResult = $("#lmbtfyResult");

            searchForm.submit(function(e) {
                if (searchQuery.val() != "") {
                    searchResult.load(
                        searchForm[0].action + '?q=' + escape(searchQuery.val()),
                        function(result) {
                            searchResult.show("bounce", "fast");
                        });
                }
                e.preventDefault();
            });
        });
    </script>
</asp:Content>

<asp:Content ID="indexContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="sc_grad"><div></div></div>
    
    <table class="layout">
      <tr>
        <td align="center" class="layout">
          <div id="sw_hdr">
            <div class="sw_tb">
                <div class="sw_tb_content">
                    &nbsp;&nbsp;<%= Html.ActionLink("LMBTFY", "Index") %>
                    &nbsp;|&nbsp;&nbsp;<%= Html.ActionLink("About...", "About") %>
                </div>
              <div style="clear:both">
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
                    <div class="let_me">Let me</div>
                    <div class="sw_logo">Bing
                    </div>
                    <div class="that_for_you">that for you!</div>
                    <div class="sw_mbrand">
                    </div>
                    <div class="beta">
                    </div>
                    <div class="search_controls">
                      <form method="get" class="sw_box" id="sb_form" action="/Home/GenerateUrl">
                        <div class="sw_bd">
                          <div class="sw_b">
                            <input class="sw_qbox" id="sb_form_q" name="q" title="Enter your search term" type="text" value=""/>
                            <input class="sw_qbtn" id="sb_form_go" name="go" tabindex="0" title="Search" type="submit" value=""/>
                          </div>
                          <div class="instructions"><span>Type in a question and click the search button</span></div>
                          <div id="sw_as">
                          </div>
                        </div>
                      </form>
                    </div>
                    <div id="lmbtfyResult"></div>
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
