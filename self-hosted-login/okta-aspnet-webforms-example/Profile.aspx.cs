﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace okta_aspnet_webforms_example
{
    public partial class Profile : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.IsAuthenticated)
            {

                GridViewClaims.DataSource = HttpContext.Current.GetOwinContext().Authentication.User.Claims.Select(x => new { Name = x.Type, Value = x.Value });
                GridViewClaims.DataBind();
            }
            else
            {
                var mainContent = (ContentPlaceHolder)Page.Form.FindControl("MainContent");
                mainContent.Controls.Add(new Label
                {
                    Text = "You are not authenticated!"
                });
            }
        }
    }
}