using System;
using System.Collections.Generic;

using Xamarin.Forms;

namespace Foodie
{
	public partial class EditRecipePage : ContentPage
	{
		public EditRecipePage(Recipe recipe)
		{
			InitializeComponent();
			BindingContext = recipe;
		}

		async void HandleCancel_Clicked(object sender, System.EventArgs e)
		{			
			await Navigation.PopModalAsync();
		}
	}
}
